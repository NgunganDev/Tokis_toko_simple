// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tokis_app/widget/button_show.dart';
import 'package:tokis_app/widget/text_control.dart';

import 'db_service.dart';

class PopUpService extends DBService {
  String pathIn = '';

  Future<String> pickImage() async {
    // File path;
    XFile? file;
    ImagePicker pick = ImagePicker();
    try {
      file = await pick.pickImage(source: ImageSource.gallery);
      return file!.path;
    } catch (e) {
      return '';
    }
  }

  void showTheAdd(
      BuildContext ctx,
      TextEditingController contProductName,
      TextEditingController contProductPrice,
      TextEditingController contCategory,
      cb,
      WidgetRef ref) {
    showDialog(
        context: ctx,
        builder: (ctx) {
          final size = MediaQuery.sizeOf(ctx);
          return SizedBox(
            width: size.width,
            height: size.height * 0.2,
            child: AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Add Product',
                    style: TextStyle(
                        fontSize: size.height * 0.024,
                        fontWeight: FontWeight.w500),
                  ),
                  Image.asset('images/shadowbox.png')
                ],
              ),
              content: SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextControl(
                        controlText: contProductName,
                        labelName: 'Product Name'),
                    TextControl(
                        controlText: contProductPrice,
                        labelName: 'Product Price'),
                    TextControl(
                        controlText: contCategory,
                        labelName: 'Product Category'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(Icons.add_photo_alternate_outlined),
                            onPressed: () async {
                              pathIn = await pickImage();
                            }),
                        Text('add photo')
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                ButtonShow(
                    action: () {
                      Navigator.pop(ctx);
                    },
                    btnName: 'cancel'),
                SizedBox(
                  width: size.width * 0.05,
                ),
                ButtonShow(action: cb, btnName: 'save'),
              ],
            ),
          );
        });
  }

  Future<DateTime> showCalen(BuildContext ctx) async {
    final DateTime? res = await showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now().add(const Duration(days: 7)));
    print(res);
    return res!;
  }

  void showAlert(BuildContext context, VoidCallback cbYes, VoidCallback cbNo) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: 'Do you want to clear the cart',
      confirmBtnText: 'Yes',
      onConfirmBtnTap: cbYes,
      cancelBtnText: 'No',
      onCancelBtnTap: cbNo,
      confirmBtnColor: Theme.of(context).primaryColor,
    );
  }

  void showAttention(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      text: 'empty cart',
      confirmBtnColor: Theme.of(context).primaryColor,
    );
  }

  void showWarning(BuildContext ctx) {
    QuickAlert.show(
      context: ctx,
      type: QuickAlertType.info,
      text: 'setelah print pesanan silahkan clear cart ya ',
      autoCloseDuration: const Duration(seconds: 2),
      onConfirmBtnTap: () {
        Navigator.pop(ctx);
      },
    );
  }
}
