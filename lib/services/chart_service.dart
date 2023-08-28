import 'package:hive_flutter/hive_flutter.dart';
import '../model/cart.dart';
import '../model/chart_data.dart';

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

class ChartService {
  List<Weekday> days = [
    Weekday.monday,
    Weekday.tuesday,
    Weekday.wednesday,
    Weekday.thursday,
    Weekday.friday,
    Weekday.saturday,
    Weekday.sunday
  ];
  var chartData = Hive.box<ChartData>('chartbox');
  DateTime _theDate = DateTime.now();
  DateTime get myDate => _theDate;
  set dateTo(DateTime date) {
    _theDate = date;
  }

  Future<void> addData(List<CartModel> value) async {
    if (value.isNotEmpty) {
      await chartData
          .add(ChartData(listData: value, orderDate: DateTime.now()));
    } else {
      print('no data');
    }
    print('add data to chart');
  }

  List<ChartData> fetchChartData() {
    return chartData.values.toList();
  }

  int balanceWeek() {
    int total = 0;
    for (var t in fetchByWeek()) {
      for (var y in t.listData) {
        total += itemPrice(y.totalPrice, y.productAmount);
      }
    }
    return total;
  }

  int balanceWeekAgo() {
    int ago = 0;
    for (var u in fetchWeekAgo()) {
      for (var e in u.listData) {
        ago += itemPrice(e.totalPrice, e.productAmount);
      }
    }
    return ago;
  }

  int itemPrice(int price, int qua) {
    int prices = 0;
    return prices += price * qua;
  }

  List<ChartData> fetchByWeek() {
    DateTime isNow = myDate;
    DateTime startWeek = isNow.subtract(Duration(days: isNow.weekday - 1));
    DateTime endWeek = isNow.add(Duration(days: 7 - isNow.weekday));
    return fetchChartData().where((element) {
      return element.orderDate.isAfter(startWeek) &&
          element.orderDate.isBefore(endWeek);
    }).toList();
  }

  List<ChartData> fetchWeekAgo() {
    DateTime isNow = myDate;
    DateTime startWeekAgo = isNow.subtract(Duration(days: isNow.weekday + 6));
    DateTime endWeekAago = isNow.subtract(Duration(days: isNow.weekday - 1));
    return fetchChartData().where((element) {
      return element.orderDate.isAfter(startWeekAgo) &&
          element.orderDate.isBefore(endWeekAago);
    }).toList();
  }

  bool checkArrow(double re) {
    if (re * -1 != re) {
      return true;
    } else {
      return false;
    }
  }

  // for lineChart Service
  List<int> dataLine() {
    List<int> hh = [];
    int res = 0;
    for (var i = 0; i < fetchFWeek().length; i++) {
      res = fetchFWeek()[i].length - fetchAWeek()[i].length;
      hh.add(res);
      print(res);
    }
    print(hh);
    return hh;
  }

  // exc
  int percentInBalance() {
    int res = balanceWeek();
    int ret = balanceWeekAgo();
    int result = 0;
    double r = 0;
    if (res > ret || res < ret) {
      result = res - ret;
      r = result / ret * 100;
      checkArrow(r);
    } else {
      return 0;
    }
    return r.toInt();
  }

  // mostly order this week by the name countamount in order;
  String mostlyOrder() {
    String item = '';
    List<String> pp = [];
    List<Map<String, int>> nameC = [];
    Map<String, int> dd = {};
    int maxCount = 0;
    for (var t in fetchByWeek()) {
      for (var g in t.listData) {
        pp.add(g.productName);
        nameC.add({g.productName: g.productAmount});
      }
    }
    for (var f in pp) {
      if (dd.containsKey(f)) {
        dd[f] = (dd[f] ?? 0) + 1;
      } else {
        dd[f] = 1;
      }
    }
    dd.forEach((food, count) {
      if (count > maxCount) {
        maxCount = count;
        item = food;
      }
    });
    return item;
  }

  List<List<ChartData>> fetchFWeek() {
    List<List<ChartData>> res = [];
    for (var i = 0; i < 7; i++) {
      res.add(fetchInWeek(days[i]));
    }
    return res;
  }

  List<List<ChartData>> fetchAWeek() {
    List<List<ChartData>> res = [];
    for (var i = 0; i < 7; i++) {
      res.add(fetchBeWeek(days[i]));
    }
    return res;
  }

  int avrOrderWeek(List<ChartData> data) {
    int totalLength = 0;
    int res = 0;
    for (var y in data) {
      totalLength += y.listData.length;
    }
    res = (totalLength ~/ 7).toInt();
    return res;
  }

  int progressPercent(int prev, int now) {
    int ref = 0;
    int res = 0;
    if (now > prev || now < prev) {
      ref = now - prev;
      res = (ref / prev * 100).toInt();
    }
    return res;
  }

  int orderToday() {
    int total = 0;
    List<ChartData> data = fetchChartData().where((element) {
      return element.orderDate.day == DateTime.now().day;
    }).toList();
    total += data.length;
    return total;
  }

  List<ChartData> fetchInWeek(Weekday day) {
    return fetchByWeek().where((element) {
      return element.orderDate.weekday == day.index + 1;
    }).toList();
  }

  List<ChartData> fetchBeWeek(Weekday day) {
    return fetchByWeek().where((element) {
      return element.orderDate.weekday == day.index;
    }).toList();
  }
}
