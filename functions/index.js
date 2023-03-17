const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

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
            await sessionDoc.ref.update({ available: 5 });
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
            await sessionDoc.ref.update({ available: 5 });
          }
        }
      });
      console.log("Reset available slots successfully");
    } catch (error) {
      console.error("Error resetting available slots:", error);
    }
  });
