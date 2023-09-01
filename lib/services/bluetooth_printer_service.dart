import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrinterBluetooth  {
  final BlueThermalPrinter _bt = BlueThermalPrinter.instance;
//  final BluetoothEnable _enabled
// error service
  List<BluetoothDevice> devices = [];
  bool isConnected = false;
  bool deviceDone = false;
  bool accessBTgranted = false;
  Future<void> initPrinter() async {
    // bool? isConnect = await _bt.isConnected;
    try {
        devices = await _bt.getBondedDevices();
        // devices.forEach((element) { 
        //   // state.add(element);
        // });
        print(devices);
        // state = devices;
      // state = await _bt.getBondedDevices();
      _bt.onStateChanged().listen((event) {
        switch (event) {
          case BlueThermalPrinter.CONNECTED:
            print('new device');
            isConnected = true;
          case BlueThermalPrinter.DISCONNECTED:
            print('state off');
            isConnected = false;
          case BlueThermalPrinter.STATE_OFF:
            // state.clear();
            print('off');
            isConnected = false;
          default:
            isConnected = false;
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> initPermission() async {
    BluetoothEnable.enableBluetooth.then((result) {
      if (result == "true") {
        initPrinter();
      } else if (result == "false") {}
    });
  }

  Future<void> connectDevice(BluetoothDevice device) async {
    if (devices.isNotEmpty) {
      _bt.isConnected.then((value) {
        _bt.connect(device).then((value) {
          deviceDone = true;
        });
      });
    } else {
      print('invalid assertion');
    }
  }
}
