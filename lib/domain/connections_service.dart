import 'dart:async';
import 'dart:collection';

import 'package:cbj_integrations_controller/integrations_controller.dart';
import 'package:cybearjinni/infrastructure/network_utilities_flutter.dart';

part 'package:cybearjinni/infrastructure/connection_service/app_connection_service.dart';
part 'package:cybearjinni/infrastructure/connection_service/demo_connection_service.dart';
part 'package:cybearjinni/infrastructure/connection_service/none_connection_service.dart';

enum ConnectionType {
  appAsHub,
  hub,
  remotePipes,
  demo,
  none,
  ;
}

abstract interface class ConnectionsService {
  static ConnectionsService? _instance;

  static ConnectionsService get instance {
    return _instance ??= _AppConnectionService();
  }

  static ConnectionType _currentConnectionType = ConnectionType.appAsHub;

  static void setCurrentConnectionType(ConnectionType? connectionType) {
    if (connectionType == _currentConnectionType) {
      return;
    }
    final ConnectionsService? oldInstance = _instance;
    switch (connectionType) {
      case ConnectionType.appAsHub:
        _instance = _AppConnectionService();
        _currentConnectionType = ConnectionType.appAsHub;
      case ConnectionType.demo:
      case ConnectionType.hub:
      case ConnectionType.remotePipes:
        _instance = _DemoConnectionService();
        _currentConnectionType = ConnectionType.demo;
      case ConnectionType.none:
      case null:
        _instance = _NoneConnectionService();
        _currentConnectionType = ConnectionType.none;
    }
    oldInstance?.dispose();
  }

  static ConnectionType getCurrentConnectionType() => _currentConnectionType;

  Future searchDevices();

  void setEntityState({
    required HashMap<VendorsAndServices, HashSet<String>> uniqueIdByVendor,
    required EntityProperties property,
    required EntityActions actionType,
    HashMap<ActionValues, dynamic>? value,
  });

  Future<HashMap<String, DeviceEntityBase>> get getAllEntities;

  Stream<MapEntry<String, DeviceEntityBase>> watchEntities();

  Future dispose();
}
