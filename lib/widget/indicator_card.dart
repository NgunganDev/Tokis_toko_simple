import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tokis_app/constant/color.dart';

class IndicatorCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget? ic;
  const IndicatorCard(
      {super.key, required this.title, required this.value, this.ic});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Card(
      child: Padding(
    padding: EdgeInsets.symmetric(
      vertical: size.height * 0.02,
      horizontal: size.width * 0.04
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: size.height * 0.024,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            ic ?? const SizedBox()
          ],
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircularPercentIndicator(
              radius: size.height * 0.05,
              lineWidth: size.height * 0.01,
              circularStrokeCap: CircularStrokeCap.round,
              percent: 0.6,
              center: Text("60%", style: TextStyle(
                fontSize: size.height * 0.03,
                fontWeight: FontWeight.w500
              ),),
              progressColor: ColorUse.secC,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                          fontSize: size.height * 0.045,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                       Text(
                      'Order',
                      style: TextStyle(
                          fontSize: size.height * 0.03,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ],
                ),
                Text('lorem ipsumdolorsit amet ', maxLines: 2,overflow: TextOverflow.ellipsis, style: TextStyle(
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey
                ),)
              ],
            ),
            SizedBox(
              width: size.width * 0.02,
            )
          ],
        )
      ],
    ),
      ),
    );
  }
}
