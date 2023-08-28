import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokis_app/presenter/chart_presenter.dart';
import 'package:tokis_app/state_riverpod.dart';
import '../../constant/color.dart';

class CashChart extends ConsumerStatefulWidget {
  const CashChart({super.key});

  @override
  ConsumerState<CashChart> createState() => _CashChartState();
}

class _CashChartState extends ConsumerState<CashChart> {
  ChartPresenter? _present;
  @override
  void initState() {
    super.initState();
    _present = ref.read(chartPresenter);
  }

  BarChartData get myData => BarChartData(
        maxY: 800000,
        titlesData: myTitle,
        borderData: myBorder,
        barTouchData: myTouch,
        barGroups: _present!.dayname.asMap().entries.map((e) {
          return BarChartGroupData(x: e.key, barRods: [
            BarChartRodData(
              color: ColorUse.secC,
              width: 15,
              borderRadius: BorderRadius.circular(2),
                toY: _present!
                    .allPricePrint(_present!.willData[e.key])
                    .toDouble()),
          ]);
        }).toList(),
      );

      BarTouchData get myTouch => BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Theme.of(context).secondaryHeaderColor,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem('RP ${rod.toY}',  const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ));
          },
        )
      );

  FlBorderData get myBorder => FlBorderData(
        border: Border.all(),
        show: false,
      );
  FlTitlesData get myTitle => FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(
          sideTitles: SideTitles(
        showTitles: false,
      )),
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: (value, meta) {
          return Text(_present!.dayname[value.toInt()], style: const TextStyle(
            fontWeight: FontWeight.w500
          ),);
        },
      )));

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
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      ref.read(myChartState.notifier).update((state) => 1);
                    },
                    child: Text('Sales Per Week', style: TextStyle(
                      fontSize: size.height * 0.022,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey
                    ),),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            SizedBox(
              // width: size.width * 0.8,
              height: size.height * 0.18,
              child: BarChart(myData),
            ),
          ],
        ),
      ),
    );
  }
}
