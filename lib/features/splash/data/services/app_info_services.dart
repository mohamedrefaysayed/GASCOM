// import 'dart:io';

// import 'package:dinar_store/features/splash/data/repos/app_info_repo.dart';
// import 'package:flutter/services.dart';


// class AppInfoServices implements AppInfoRepo {
//   ///get all needed app data
//   ///(appVersion, deviceId, platform & platformVersion)
//   @override
//   Future<AppInfoModel> getAppData() async {
//     Box<AppInfoModel> box = Hive.box<AppInfoModel>(kAppInfoModelBox);
//     late AppInfoModel appInfoModel;
//     if (box.get(kAppInfoKey) == null) {
//       appInfoModel = await _getAppDataFromDevice();
//       _saveAppDataInLocalDatabase(box, appInfoModel);
//     } else {
//       appInfoModel = _getAppDataFromLocalDatabase(box);
//       String appVersion = await _getAppVersion();

//       if (appInfoModel.appVersion != appVersion) {
//         //update app version
//         appInfoModel.appVersion = appVersion;
//         //save the updated AppInfoModel to the local database
//         _saveAppDataInLocalDatabase(box, appInfoModel);
//       }
//     }
//     return appInfoModel;
//   }

//   ///get app info model from local database
//   AppInfoModel _getAppDataFromLocalDatabase(Box<AppInfoModel> box) =>
//       box.get(kAppInfoKey)!;

//   ///generate unique id & get data from its source
//   Future<AppInfoModel> _getAppDataFromDevice() async {
//     String deviceId = await _generateUniqueId();
//     Map<String, dynamic> platformData = await _getPlatformData();
//     String appVersion = await _getAppVersion();
//     return AppInfoModel(
//       appVersion: appVersion,
//       deviceId: deviceId,
//       platform: platformData['platform'],
//       platformVersion: platformData['platformVerion'],
//       platformSdk: platformData['platformSdk'],
//     );
//   }

//   ///save app info model in local database
//   Future<void> _saveAppDataInLocalDatabase(
//     Box<AppInfoModel> box,
//     AppInfoModel appInfoModel,
//   ) async {
//     await box.put(kAppInfoKey, appInfoModel);
//   }

//   ///generate unique id
//   Future<String> _generateUniqueId() async {
//     String identifier;

//     try {
//       identifier = (await UniqueIdentifier.serial)!;
//     } on PlatformException {
//       identifier = 'Failed to get Unique Identifier';
//     }
//     return identifier;
//   }

//   ///get app version from pubspec.yaml
//   Future<String> _getAppVersion() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     return packageInfo.version;
//   }

//   ///get device's platform version
//   Future<Map<String, dynamic>> _getPlatformData() async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     if (Platform.isAndroid) {
//       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//       return {
//         'platform': 'android',
//         'platformVerion': androidInfo.version.release,
//         'platformSdk': androidInfo.version.sdkInt,
//       };
//     } else if (Platform.isIOS) {
//       IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//       return {
//         'platform': 'ios',
//         'platformVerion': iosInfo.systemVersion,
//         'platformSdk': null,
//       };
//     }
//     return {
//       'platform': 'fuchsia',
//       'platformVerion': 'N/A',
//       'platformSdk': null,
//     };
//   }
// }
