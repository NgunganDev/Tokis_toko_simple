import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tokis_app/services/popup_service.dart';

import '../model/cart.dart';
import '../model/chart_data.dart';
import '../services/chart_service.dart';
import '../state_riverpod.dart';

final chartPresenter = Provider((ref) => ChartPresenter(
    service: ref.read(chartServe), popServe: ref.read(popService)));

class ChartPresenter {
  List<Weekday> days = [
    Weekday.monday,
    Weekday.tuesday,
    Weekday.wednesday,
    Weekday.thursday,
    Weekday.friday,
    Weekday.saturday,
    Weekday.sunday
  ];
  final dayname = ['sen', 'sel', 'rab', 'kam', 'jum', 'sab', 'min'];
  final ChartService service;
  final PopUpService popServe;
  ChartPresenter({required this.service, required this.popServe});
  List<List<ChartData>> fetchFinalWeek() {
    List<List<ChartData>> res = [];
    for (var i = 0; i < 7; i++) {
      res.add(service.fetchInWeek(days[i]));
    }
    return res;
  }

  Future<void> addTheOrder(List<CartModel> value) async {
    await service.addData(value);
  }

  List<ChartData> get allChartData => service.fetchChartData();
  List<ChartData> get dataInWeek => service.fetchByWeek();
  List<ChartData> get dataWeekAago => service.fetchWeekAgo();

  String todayDate(DateTime value) {
    return DateFormat('dd/MM/yyyy HH:mm').format(value);
  }

  void doAalert(BuildContext context, VoidCallback cbYes, VoidCallback cbNo) {
    popServe.showAlert(context, cbYes, cbNo);
  }

  void doAttention(BuildContext ctx) {
    popServe.showAttention(ctx);
  }

  void doWarning(BuildContext ctx) {
    popServe.showWarning(ctx);
  }

  // this week
  String get mostOrdered => service.mostlyOrder();

  // this week
  int myAvr(List<ChartData> datas) {
    return service.avrOrderWeek(datas);
  }

  List<int> get myProgressLine => service.dataLine();

  int get todayOrdered => service.orderToday();

  int myPercPProgress(int prev, int now) {
    return service.progressPercent(prev, now);
  }

  int allPricePrint(List<ChartData> values) {
    int res = 0;
    for (var t in values) {
      for (var u in t.listData) {
        res += u.totalPrice * u.productAmount;
      }
    }
    return res;
  }

  List<List<ChartData>> get willData => fetchFinalWeek();
}
