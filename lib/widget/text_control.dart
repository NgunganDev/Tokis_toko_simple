import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final String labelName;
  final TextEditingController controlText;
  const TextControl({super.key, required this.controlText, required this.labelName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width * 0.9,
      height: size.height * 0.09,
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
           borderSide: BorderSide(width: 1.0, color: Colors.black),
           borderRadius: BorderRadius.circular(10), 
          ),
          enabledBorder: OutlineInputBorder(
           borderSide: BorderSide(width: 1.0, color: Colors.black),
           borderRadius: BorderRadius.circular(10), 
          ),
          label: Text(labelName, style: TextStyle(
            fontSize: size.height * 0.024,
            fontWeight: FontWeight.w500,
          ),),
          hintText: labelName
        ),
        controller: controlText,
      ),
    );
  }
}