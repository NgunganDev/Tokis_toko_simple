import 'package:hive_flutter/hive_flutter.dart';
part 'cart.g.dart';

@HiveType(typeId: 3)
class CartModel {
  @HiveField(0)
  final String productName;
  @HiveField(1)
  int productAmount;
  @HiveField(2)
  int totalPrice;
  CartModel(
      {required this.productAmount,
      required this.totalPrice,
      required this.productName});

  static int itemPrice(int price, int qua) {
    int prices = 0;
    return prices += price * qua;
  }
}
