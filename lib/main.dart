import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tokis_app/constant/color.dart';
import 'package:tokis_app/model/cart.dart';
import 'package:tokis_app/model/chart_data.dart';
import 'package:tokis_app/model/product.dart';
import 'package:tokis_app/state_riverpod.dart';

import 'view/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Product>(ProductAdapter());
  Hive.registerAdapter<ChartData>(ChartDataAdapter());
  Hive.registerAdapter<CartModel>(CartModelAdapter());
  var box = await Hive.openBox<Product>('product');
  var box2 = await Hive.openBox<ChartData>('chartbox');
  runApp( const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final watchTheme = ref.watch(stateTheme);
    return MaterialApp(
      theme: ColorUse.colorSelect(watchTheme),
      home: const HomePage(),
    );
  }
}
