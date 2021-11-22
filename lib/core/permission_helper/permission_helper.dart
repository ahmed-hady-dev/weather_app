import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  Future<bool> _requestPermission({Permission? permission}) async {
    final status = await permission!.request();
    if (status == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestLocationPermission({Function? onPermissionDenied}) async {
    final granted = await _requestPermission(permission: Permission.location);
    if (!granted) {
      onPermissionDenied!();
    }
    return granted;
  }

//===============================================================
  Future<bool> _hasPermission({Permission? permission}) async {
    final permissionStatus = await permission!.status;
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> hasLocationPermission() async {
    return _hasPermission(permission: Permission.location);
  }
}
