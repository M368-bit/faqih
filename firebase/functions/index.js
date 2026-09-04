const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
const db = admin.firestore();
const messaging = admin.messaging();

/**
 * 1. Automated Post-Prayer Adhkar Notification Scheduler
 * Sends push notification after each prayer time for Makkah worshippers.
 */
exports.sendAutomatedPostPrayerAdhkar = functions.pubsub
  .schedule("every 30 minutes")
  .timeZone("Asia/Riyadh")
  .onRun(async (context) => {
    const topic = "post_prayer_adhkar";
    const payload = {
      notification: {
        title: "أذكار ما بعد الصلاة المفروضة 🕌",
        body: "قال ﷺ: (من قرأ آية الكرسي دبر كل صلاة مكتوبة لم يمنعه من دخول الجنة إلا أن يموت) - رطب لسانك بالاستغفار والتسبيح.",
      },
      data: {
        click_action: "FLUTTER_NOTIFICATION_CLICK",
        screen: "post_prayer_adhkar",
      },
    };

    try {
      await messaging.sendToTopic(topic, payload);
      console.log("Automated post-prayer push notification sent successfully.");
    } catch (error) {
      console.error("Error sending post-prayer notification:", error);
    }
    return null;
  });

/**
 * 2. Tahfeez Application Status Update Notification
 * Notifies the applicant immediately when approved or reviewed.
 */
exports.onApplicationStatusChange = functions.firestore
  .document("tahfeez_applications/{appId}")
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    if (before.status !== after.status) {
      const applicantId = after.applicantId;
      const userDoc = await db.collection("users").doc(applicantId).get();
      const fcmToken = userDoc.data()?.fcmToken;

      let title = "تحديث طلب التحفيظ - جامع فقيه";
      let body = "";

      if (after.status === "approved") {
        title = "تهانينا! تم قبولك بحلقات التحفيظ 🎉";
        body = `تم قبولك بنجاح في (${after.preferredCircleName}). يرجى الاطلاع على جدول التسميع اليومي.`;
      } else if (after.status === "rejected") {
        title = "إفادة بخصوص طلب الالتحاق بالحلقات";
        body = `نعتذر لعدم توفر مقاعد شاغرة حالياً في ${after.preferredCircleName}. تم إدراجك في قائمة الانتظار.`;
      }

      if (fcmToken) {
        await messaging.send({
          token: fcmToken,
          notification: { title, body },
          data: { screen: "tahfeez_dashboard" },
        });
      }
    }
  });

/**
 * 3. Daily Homework Assignment Notification
 * Notifies student when teacher assigns new (الجديد والمراجعة)
 */
exports.onHomeworkCreated = functions.firestore
  .document("homework/{homeworkId}")
  .onCreate(async (snap, context) => {
    const hw = snap.data();
    const userDoc = await db.collection("users").doc(hw.studentId).get();
    const fcmToken = userDoc.data()?.fcmToken;

    if (fcmToken) {
      await messaging.send({
        token: fcmToken,
        notification: {
          title: "واجب قرآني جديد لليوم 📖",
          body: `الجديد: سورة ${hw.newSurahName} (من ${hw.newAyahFrom} إلى ${hw.newAyahTo}) - المراجعة: سورة ${hw.reviewSurahName}`,
        },
        data: { screen: "student_homework" },
      });
    }
  });

/**
 * 4. Prayer Times Override Broadcast
 * Notifies worshippers if Sheikh adjusts Iqama or prayer times
 */
exports.onPrayerTimesOverride = functions.firestore
  .document("prayer_settings/{docId}")
  .onUpdate(async (change, context) => {
    const after = change.after.data();
    if (after.hasManualOverride) {
      await messaging.sendToTopic("prayer_alerts", {
        notification: {
          title: "تحديث مواقيت وإقامة جامع الشيخ عبد القادر فقيه",
          body: `تم اعتماد ضبط جديد لمواقيت الصلاة والإقامة بإشراف ${after.updatedBySheikhName}.`,
        },
      });
    }
  });
