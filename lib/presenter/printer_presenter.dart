import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokis_app/services/bluetooth_printer_service.dart';
import 'package:tokis_app/state_riverpod.dart';

final printPresenter =
    Provider((ref) => PrinterPresenter(btService: ref.read(btServe)));

class PrinterPresenter extends PrinterBluetooth {
  final PrinterBluetooth btService;
  PrinterPresenter({required this.btService});
  List<BluetoothDevice> get devicesa => btService.devices;
  bool get deviceReady => btService.deviceDone;
  // Future<void> get initDevices => btService.initPrinter();
  // Future<void> get initPermis => btService.initPermission();
  Future<void> connectIt(BluetoothDevice device) async {
    btService.connectDevice(device);
  }
}
