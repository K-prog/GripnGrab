const functions = require("firebase-functions");
const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
// scheduling notification
exports.resetAvailableSlots = functions.pubsub
  .schedule("0 * * * *")
  .timeZone("Asia/Kolkata")
  .onRun(async () => {
    try {
      const sessions = await admin.firestore().collection("sessions").get();
      const now = new Date().toLocaleTimeString("en-US", {
        hour12: false,
        timeZone: "Asia/Kolkata",
      });
      const currentHour = parseInt(now.substring(0, 2), 10);

      sessions.forEach(async (sessionDoc) => {
        const sessionData = sessionDoc.data();
        const { sessionType, timeFrame } = sessionData;

        const startHour = parseInt(timeFrame.substring(0, timeFrame.indexOf("-")), 10);
      
        if (sessionType === "morning") {
          if (currentHour === startHour) {
            const slotsRef = sessionDoc.ref.collection("slots");
            const slots = await slotsRef.get();
            await Promise.all(
              slots.docs.map((doc) => {
                return doc.ref.delete();
              })
            );
            await sessionDoc.ref.update({ available: 8 });
          }
        } else if (sessionType === "evening") {
          if (currentHour === startHour + 12) {
            const slotsRef = sessionDoc.ref.collection("slots");
            const slots = await slotsRef.get();
            await Promise.all(
              slots.docs.map((doc) => {
                return doc.ref.delete();
              })
            );
            await sessionDoc.ref.update({ available: 8 });
          }
        }
      });
      console.log("Reset available slots successfully");
    } catch (error) {
      console.error("Error resetting available slots:", error);
    }
  });


// sending notification on new users
exports.sendNotificationOnUserCreate = functions.firestore
    .document('users/{userId}')
    .onCreate(async (snap, context) => {
        // Get the first and last name of the new user
        const userData = snap.data();
        const firstName = userData.firstName;
        const lastName = userData.lastName;
        
        // Get the FCM token of the admin from the admin collection
        const adminDoc = await admin.firestore()
            .collection('admin')
            .doc('adminDoc')
            .get();
        const adminData = adminDoc.data();
        const adminFcmToken = adminData.fcmToken;
        
        // Construct the notification message
        const message = {
            notification: {
                title: 'New User Added',
                body: `${firstName} ${lastName} has been added to the app.`
            },
            token: adminFcmToken
        };
        
        // Send the notification message using the Firebase Cloud Messaging API
        await admin.messaging().send(message);
    });
