import 'package:flutter/material.dart';

class ValueCash extends StatelessWidget {
  final String imageAs;
  final String value;
  final String title;
  final Widget? ic;
  const ValueCash(
      {super.key,
      required this.title,
      required this.imageAs,
      required this.value,
      this.ic});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Card(
      child: Stack(
        children: [
          Positioned(
              right: 4,
              bottom: 4,
              child: SizedBox(child: Image.asset(imageAs))),
          Padding(
            padding: EdgeInsets.all(size.height * 0.018),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                Text(
                  value,
                  style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.w500,
                      color:  Theme.of(context).primaryColor),
                ),
                  ],
                ),
                ic ?? const SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
