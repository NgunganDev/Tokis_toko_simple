import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 1)
class Product {
  @HiveField(0)
  final String productName;
  @HiveField(1)
  final String productCategory;
  @HiveField(2)
  final int productPrice;
  @HiveField(3)
  final String imagePath ;

  Product(
      {required this.productCategory,
      required this.productName,
      required this.productPrice,
      required this.imagePath,
      });
}
