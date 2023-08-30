import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../state_riverpod.dart';

class MyLineChart extends ConsumerStatefulWidget {
  final List<int> mydata;
  const MyLineChart({super.key, required this.mydata});

  @override
  ConsumerState<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends ConsumerState<MyLineChart> {
  final dayName = ['sen', 'sel', 'rab', 'kam', 'jum', 'sab', 'min'];
  // final leftLine = [-50, -30, 0, 30, 50, ];
  FlGridData get myGrid => const FlGridData(show: true);

  FlBorderData get myBorder => FlBorderData(show: false);

  FlTitlesData get myTitle => FlTitlesData(
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
          sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          return Text(
            dayName[value.toInt()],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          );
        },
      )));

  LineTouchData get myTouch => LineTouchData(
          touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Theme.of(context).secondaryHeaderColor,
        getTooltipItems: (touchedSpots) {
          var isd = touchedSpots.map((e) {
            return e.y;
          });
          return [
            LineTooltipItem('${isd.last.toInt()} index',
                const TextStyle(fontWeight: FontWeight.bold))
          ];
        },
      ));

  LineChartData myData(bool statf, BuildContext ctx) {
    return LineChartData(
        maxY: 50,
        minY: -50,
        titlesData: myTitle,
        borderData: myBorder,
        gridData: myGrid,
        lineTouchData: myTouch,
        lineBarsData: [
          LineChartBarData(
              dotData: const FlDotData(show: false),
              barWidth: 6,
              isCurved: true,
              curveSmoothness: 0.45,
              isStrokeCapRound: true,
              isStepLineChart: statf,
              color: Theme.of(ctx).primaryColor,
              spots: widget.mydata.asMap().entries.map((e) {
                return FlSpot(e.key.toDouble(), e.value.toDouble());
              }).toList())
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final watchStep = ref.watch(lineStep);
    final size = MediaQuery.sizeOf(context);
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02, horizontal: size.width * 0.04),
        child: Column(
          children: [
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterSwitch(
                    width: size.width * 0.1,
                    height: size.height * 0.025,
                    valueFontSize: size.height * 0.012,
                    toggleSize: size.height * 0.03,
                    value: watchStep,
                    borderRadius: 8,
                    padding: 3,
                    onToggle: (val) {
                      ref.read(lineStep.notifier).update((state) => val);
                    },
                  ),
                  InkWell(
                    onTap: () {
                      ref.read(myChartState.notifier).update((state) => 0);
                    },
                    child: Text(
                      'Progresss Per Day',
                      style: TextStyle(
                          fontSize: size.height * 0.022,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
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
              child: LineChart(myData(watchStep, context)),
            ),
          ],
        ),
      ),
    );
  }
}
