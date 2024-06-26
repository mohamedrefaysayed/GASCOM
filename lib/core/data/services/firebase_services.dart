import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinar_store/core/helpers/app_cache/cahch_helper.dart';
import 'package:dinar_store/core/helpers/notifications.dart';
import 'package:dinar_store/core/utils/genrall.dart';
import 'package:dinar_store/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseServices {
  static Future<void> init() async {
    mainUrl = CacheHelper.getData(key: "mainUrl") ?? mainUrl;

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    final appInfo = await FirebaseFirestore.instance
        .collection("Gaznaa-App")
        .doc("App-Info")
        .get();

    mainUrl = appInfo.data()!["mainUrl"] ?? mainUrl;

    CacheHelper.saveData(key: "mainUrl", value: mainUrl);
  }
}
