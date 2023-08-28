// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:tokis_app/constant/color.dart';

class ButtonBle extends StatelessWidget {
  final String name;
  final VoidCallback action;
  const ButtonBle({super.key, required this.action, required this.name});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width * 0.3,
      height: size.height * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorUse.secC,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          )
        ),
        onPressed: action, child: Text(name, style: TextStyle(
          fontSize: size.height * 0.03,
          fontWeight: FontWeight.w500
        ),)),
    );
  }
}