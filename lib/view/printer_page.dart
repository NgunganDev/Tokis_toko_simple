// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';
import 'package:tokis_app/constant/color.dart';
import 'package:tokis_app/presenter/printer_presenter.dart';
import 'package:tokis_app/widget/button_ble.dart';
import '../services/bluetooth_printer_service.dart';

class PrinterPage extends ConsumerStatefulWidget {
  const PrinterPage({super.key});

  @override
  ConsumerState<PrinterPage> createState() => _PrinterPageState();
}

class _PrinterPageState extends ConsumerState<PrinterPage> {
  PrinterPresenter? _present;
  // BluetoothDevice? dev;
  @override
  void initState() {
    super.initState();
    _present = ref.read(printPresenter);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stateit =
        StateNotifierProvider<PrinterBluetooth, List<BluetoothDevice>>((ref) {
      return PrinterBluetooth();
    });
    final watchState = ref.watch(stateit);
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                        horizontal: size.width * 0.02),
                    width: size.width,
                    height: size.height * 0.18,
                    color: ColorUse.secC,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Connect Printer',
                              style: TextStyle(
                                  fontSize: size.height * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: ColorUse.getC),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Expanded(
                          child: Container(
                            width: size.width,
                            color: ColorUse.primC,
                            child: _present!.devicesa.isEmpty
                                ? const RiveAnimation.asset('images/scananim.riv')
                                : ListView.builder(
                                    itemCount:  1,
                                    itemBuilder: (c, i) {
                                      return ListTile(
                                        onTap: () {
                                          ref
                                              .read(stateit.notifier)
                                              .connectDevice(watchState[i]);
                                        },
                                        title: Text(_present!.devicesa[i].name!),
                                        subtitle: Text(_present!.devicesa[i].address!),
                                        trailing: Text(_present!.devicesa[i].type.toString()),
                                        leading: SizedBox(
                                          child: Image.asset('images/btic.png'),
                                        ),
                                      );
                                    }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: size.width * 0.24,
                child: SizedBox(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: size.width * 0.65,
                          height: size.height * 0.12,
                          child: Card(
                            color: ColorUse.getC,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.02,
                                horizontal: size.width * 0.04,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Name'),
                                  ButtonBle(
                                      action: () async {
                                        print(watchState);
                                        // _present!.initPermis;
                                        ref
                                            .read(stateit.notifier)
                                            .initPermission();
                                        // print(_present!.devices);
                                        // print('scanning');
                                      },
                                      name: 'scan'),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
