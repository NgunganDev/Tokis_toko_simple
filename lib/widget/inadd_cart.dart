import 'package:flutter/material.dart';

import '../constant/color.dart';

class InAddCard extends StatelessWidget {
  final String bl;
  final IconData ic;
  final String nameC;
  final int value;
  const InAddCard({super.key, required this.bl, required this. nameC, required this.ic, required this.value});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.01),
      decoration: BoxDecoration(
          color: ColorUse.getC, borderRadius: BorderRadius.circular(12)),
      width: size.width * 0.6,
      height: size.height * 0.12,
      child: Stack(
        children: [
          Positioned(
            right: 2,
            bottom: 2,
            child: SizedBox(
              child: Image.asset('images/pathcircle.png'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(ic),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Text(
                        nameC,
                        style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                            color: ColorUse.secC),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.arrow_upward, color: ColorUse.secC,),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                      Text('${value}%', style: TextStyle(
                        fontSize: size.height * 0.022,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey
                      ),),
                    ],
                  ),
                ],
              ),
              Text(
               bl,
                style: TextStyle(
                    fontSize: size.height * 0.04,
                    fontWeight: FontWeight.w500,
                    color: ColorUse.secC),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
