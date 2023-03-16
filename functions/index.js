const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.resetAvailableSlots = functions.pubsub
  .schedule('0 * * * *')
  .timeZone('Asia/Kolkata')
  .onRun(async () => {
    console.log('running');
    try {  
      const sessions = await admin.firestore().collection('sessions').get();
      const now = new Date().toLocaleTimeString('en-US', { hour12: false, timeZone: 'Asia/Kolkata' });

      // if time is 6.30 it will give currentHour as 6 and 30 as minute,
      // also if time is 6.30 pm then it will give currentHour as 18 and minute as 30
      const currentHour = parseInt(now.substring(0, 2), 10);
      const currentMinute = parseInt(now.substring(3, 5), 10);

      sessions.forEach(async (sessionDoc) => {
        const sessionData = sessionDoc.data();
        const { sessionType, timeFrame } = sessionData;

        const startHour = parseInt(timeFrame.substring(0, 2), 10);
        const endHour = parseInt(timeFrame.substring(6, 8), 10);

        // Check if the timeframe is in the past and not the current timeframe
        if (
          ((currentHour > endHour) || (currentHour === endHour && currentMinute > 0)) ||
          ((currentHour === startHour && currentMinute >= 0) || currentHour > startHour) &&
          sessionType === 'morning'
        ) {
          const slots = await sessionDoc.ref.collection('slots').get();
          await Promise.all(
            slots.docs.map((doc) => {
              return doc.ref.delete();
            })
          );
          const availableSlots = 5 - slots.size;
          await sessionDoc.ref.update({ available: availableSlots || 5 });
        } else if (
          (currentHour > endHour) ||
          ((currentHour === startHour && currentMinute >= 0) || currentHour > startHour) &&
          sessionType === 'evening'
        ) {
          const slots = await sessionDoc.ref.collection('slots').get();
          await Promise.all(
            slots.docs.map((doc) => {
              return doc.ref.delete();
            })
          );
          const availableSlots = 5 - slots.size;
          await sessionDoc.ref.update({ available: availableSlots || 5 });
        }
      });
      console.log('Reset available slots successfully');
    } catch (error) {
      console.error('Error resetting available slots:', error);
    }
  });
