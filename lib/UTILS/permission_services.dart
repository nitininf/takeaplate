import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  List<Permission> photos = [
    Permission.storage,
    Permission.camera,
  ];

  Future<void> askLocation() async {
    var activityRecognitionStatus = await Permission.location.status;
    if (activityRecognitionStatus != PermissionStatus.granted) {
      //here
      var status = await Permission.location.request();
      if (status != PermissionStatus.granted) {
        //here
        ///await openAppSettings();
      }
    }
  }

  Future<void> askStorage() async {
    var activityRecognitionStatus = await Permission.storage.status;
    if (activityRecognitionStatus != PermissionStatus.granted) {
      //here
      var status = await Permission.storage.request();
      if (status != PermissionStatus.granted) {
        //here
        await openAppSettings();
      }
    }
  }

  Future<bool> requestPermissionPhotos() async {
    bool permission = false;
    try {
      for (var element in photos) {
        if ((await element.status.isDenied ||
            await element.status.isPermanentlyDenied)) {
          await photos.request();
          permission = false;
          //print('requestPermission=============isDenied');
        } else {
          permission = true;
          //print('requestPermission=============Granted');
        }
      }
    } catch (e) {
      //print('requestPermission=============$e');
    }
    print('requestPermission=============$permission');

    return permission;
  }
}
