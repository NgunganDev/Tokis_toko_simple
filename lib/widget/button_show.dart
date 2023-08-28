import 'package:flutter/material.dart';

class ButtonShow extends StatelessWidget {
  final String btnName;
  final VoidCallback action;
  const ButtonShow({super.key, required this.action, required this.btnName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: action,
          child: Text(
            btnName,
            style: TextStyle(
                fontSize: size.height * 0.024, fontWeight: FontWeight.w500),
          )),
    );
  }
}
