import 'package:hive_flutter/hive_flutter.dart';
import 'package:tokis_app/model/cart.dart';
part 'chart_data.g.dart';

@HiveType(typeId: 2)
class ChartData {
  @HiveField(0)
  final List<CartModel> listData;
  @HiveField(1)
  final DateTime orderDate;
  ChartData({required this.listData, required this.orderDate});
}
