import 'package:flutter/material.dart';
import 'package:tokis_app/presenter/functional_presenter.dart';
import '../model/chart_data.dart';
import '../presenter/chart_presenter.dart';

class OrderHistoryTile extends StatelessWidget {
  final ChartData data;
  final ChartPresenter cPresentC;
  final FunctionalPresenter mPres;
  const OrderHistoryTile(
      {super.key, required this.data, required this.cPresentC,
      required this.mPres
      });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02, horizontal: size.width * 0.02),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(cPresentC.todayDate(data.orderDate), style: TextStyle(
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.w500
                ),),
              ],
            ),
            Column(
              children: data.listData.map((e) {
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(
                      width: 1.0, color: Colors.black
                    ))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e.productName, style: TextStyle(
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.w500
                      ),),
                      Text(e.productAmount.toString()),
                      Text(mPres.itemPrice(e.totalPrice, e.productAmount).toString())
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
