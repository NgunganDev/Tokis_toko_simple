import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tokis_app/model/cart.dart';
import 'package:tokis_app/model/product.dart';
import 'package:tokis_app/services/chart_service.dart';
import 'package:tokis_app/services/db_service.dart';
import 'package:tokis_app/services/popup_service.dart';
import 'package:tokis_app/state_riverpod.dart';
import 'package:tokis_app/view/add_page.dart';
import 'package:tokis_app/view/cart_page.dart';
import 'package:tokis_app/view/cash_page.dart';
import 'package:tokis_app/view/printer_page.dart';
import '../model/temp_cart.dart';
import '../services/cart_service.dart';

final funcPresenter = Provider((ref) => FunctionalPresenter(
    dataService: ref.watch(dbService),
    popService: ref.watch(popService),
    cartService: ref.watch(cartService)));

class FunctionalPresenter extends ChartService {
  final DBService dataService;
  final PopUpService popService;
  final CartService cartService;
  FunctionalPresenter(
      {required this.dataService,
      required this.popService,
      required this.cartService});

  String tcategory = '';

  set thecategory(String value) {
    tcategory = value;
  }

  String get category {
    return tcategory;
  }

  bool get myArrow => checkArrow(balanceInWeek.toDouble());

  void showPopProduct(
      BuildContext ctx,
      TextEditingController contProductName,
      TextEditingController contProductPrice,
      TextEditingController contCategory,
      cb,
      ref) {
    popService.showTheAdd(
        ctx, contProductName, contProductPrice, contCategory, cb, ref);
  }

  Future<DateTime> showCalendar (BuildContext ctx) async {
    return await popService.showCalen(ctx);
  }

  Future<void> addTheProduct(Product value) async {
    await dataService.addProduct(value);
  }

  Future<void> updateTheProduct(int index, Product value) async {
    await dataService.updateProduct(index, value);
  }

  List<Product> get fetchDB {
    return dataService.fetchProduct().where((element) {
      return element.productCategory == category;
    }).toList();
  }

  List<Product> get fetchAllData {
    return dataService.fetchProduct().toList();
  }

  Future<void> deleteItem(int index) async {
    await dataService.deleteProduct(index);
  }

  List<String> get listDrop {
    List<String> nameDrop = ['all'];
    for (var its in dataService.fetchProduct()) {
      nameDrop.add(its.productCategory);
    }
    return nameDrop.toSet().toList();
  }

  void addCart(CartModel value, TempCart value2) {
    cartService.addToCart(value, value2);
  }

  void decCart(CartModel value, TempCart value2) {
    cartService.minCart(value, value2);
  }

  List<CartModel> get listInCart {
    return cartService.model;
  }

  int get cartTotal => cartService.totalInCart();

  List<TempCart> get listInTemp => cartService.model2;
  List<CartModel> get finalTemp => cartService.modelFinalTemp;

  @override
  int itemPrice(int price, int qua) {
    int prices = 0;
    return prices += price * qua;
  }

  int itemLength(List<TempCart> val, String itemname) {
    int length = 0;
    for (var u in val) {
      if (u.name == itemname) {
        length += u.amount;
        break;
      }
    }
    return length;
  }

  int get percentWeek => percentInBalance();

  int get balanceInWeek => balanceWeek();

  int get allPrice {
    return cartService.totalAll();
  }

  List<CartModel> get theCartList => cartService.model;

  String get initPath => popService.pathIn;

  Widget homeChild(int state) {
    switch (state) {
      case 0:
        return const AddPage();
      case 1:
        return const CartPage();
      case 2:
        return const CashPage();
      case 3:
        return const PrinterPage();
      default:
        return const AddPage();
    }
  }
}
