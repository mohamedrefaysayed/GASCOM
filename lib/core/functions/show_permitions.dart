import 'package:permission_handler/permission_handler.dart';

showPermissions() async {
  /////Notifications
  bool notificationsIsGranted = await Permission.notification.status.isGranted;
  if (!notificationsIsGranted) {
    notificationsIsGranted = await Permission.notification.request().isGranted;
  }

  /////mic

  bool calenderIsGranted = await Permission.microphone.status.isGranted;
  if (!calenderIsGranted) {
    calenderIsGranted = await Permission.microphone.request().isGranted;
  }

/////camera

  bool cameraIsGranted = await Permission.camera.status.isGranted;
  if (!cameraIsGranted) {
    cameraIsGranted = await Permission.camera.request().isGranted;
  }

  /////locations

  bool locationsIsGranted = await Permission.location.status.isGranted;
  if (!locationsIsGranted) {
    locationsIsGranted = await Permission.location.request().isGranted;
  } else {
    bool locationsIsGranted = await Permission.locationAlways.status.isGranted;
    if (!locationsIsGranted) {
      locationsIsGranted = await Permission.locationAlways.request().isGranted;
    }
  }
}
