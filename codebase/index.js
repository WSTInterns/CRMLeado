const functions = require("firebase-functions");

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.scheduleNotification = functions.firestore
    .document('notify/{notificationId}')
    .onCreate((snapshot, context) => {
        const data = snapshot.data();
        const notificationDate = new Date(data.year, data.month - 1, data.date, data.hour, data.minute);
        const now = new Date();
        const diff = notificationDate.getTime() - now.getTime();
        if (diff > 0) {
            const payload = {
                notification: {
                    title: 'Scheduled Notification',
                    body: data.message
                }
            };
            const options = {
                priority: 'high',
                timeToLive: Math.floor(diff / 1000)
            };
            return admin.messaging().sendToTopic('notifications', payload, options);
        }
        return null;
    });
    exports.runScheduledFunction = functions.firestore
    .document('schedule/function1')
    .onUpdate((change, context) => {
      const data = change.after.data();
      const scheduledTime = data.scheduledTime.toDate();
      const currentTime = new Date();
  
      if (scheduledTime.getTime() === currentTime.getTime()) {
        // Run your function here
      }
  
      return null;
    });
  