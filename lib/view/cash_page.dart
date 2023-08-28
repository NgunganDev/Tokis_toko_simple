import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokis_app/presenter/functional_presenter.dart';
import 'package:tokis_app/state_riverpod.dart';
import 'package:tokis_app/widget/indicator_card.dart';
import 'package:tokis_app/widget/order_history_tile.dart';
import '../presenter/chart_presenter.dart';
import '../widget/value_cash.dart';
import 'chart/cash_chart.dart';
import 'chart/cash_line_chart.dart';

class CashPage extends ConsumerStatefulWidget {
  const CashPage({super.key});

  @override
  ConsumerState<CashPage> createState() => _CashPageState();
}

class _CashPageState extends ConsumerState<CashPage> {
  ChartPresenter? _present;
  FunctionalPresenter? _mainP;
  @override
  void initState() {
    super.initState();
    _present = ref.read(chartPresenter);
    _mainP = ref.read(funcPresenter);
  }

  @override
  Widget build(BuildContext context) {
    final watchChart = ref.watch(myChartState);
    final watchTitle = ref.watch(orderTitle);
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        color:  Theme.of(context).hintColor,
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.01, horizontal: size.width * 0.02),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01, horizontal: size.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Insights',
                    style: TextStyle(
                      fontSize: size.height * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(onPressed: (){
                    _mainP!.showCalendar(context);
                  }, child: Text('select date', style: TextStyle(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.bold
                  ),),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
              child: watchChart == 0
                  ? const CashChart()
                  : MyLineChart(mydata: _present!.myProgressLine),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.04,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.01,
                    horizontal: size.width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        ref
                            .read(orderTitle.notifier)
                            .update((state) => !watchTitle);
                      },
                      child: Text(
                        watchTitle ? 'see value' : 'order history',
                        style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w400,
                            color:  Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: watchTitle
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 180,
                                crossAxisSpacing: 10,
                                mainAxisExtent: 200,
                                mainAxisSpacing: 10),
                        itemCount: _present!.dataInWeek.length,
                        itemBuilder: (c, i) {
                          return OrderHistoryTile(
                            data: _present!.dataInWeek[i],
                            cPresentC: _present!,
                            mPres: _mainP!,
                          );
                        })
                    : Column(
                        children: [
                          Expanded(
                            child: IndicatorCard(
                              title: 'Today Order',
                              value: _present!.todayOrdered.toString(),
                              ic: Icon(Icons.table_bar_outlined,
                                  size: size.height * 0.03),
                            ),
                          ),
                          Expanded(
                            child: GridView(
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 150,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              children: [
                                ValueCash(
                                    title: 'Most Ordered',
                                    imageAs: 'images/up.png',
                                    value: _present!.mostOrdered),
                                ValueCash(
                                  title: 'Average order',
                                  imageAs: 'images/avr.png',
                                  value:
                                      '${_present!.myAvr(_present!.dataInWeek).toString()} pesanan',
                                  ic: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_upward_outlined,
                                        color:  Theme.of(context).primaryColor,
                                        size: size.height * 0.03,
                                      ),
                                      Text(
                                        '${_present!.myPercPProgress(_present!.myAvr(_present!.dataWeekAago), _present!.myAvr(_present!.dataInWeek))}%',
                                        style: TextStyle(
                                            fontSize: size.height * 0.02,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
          ],
        ),
      ),
    );
  }
}
