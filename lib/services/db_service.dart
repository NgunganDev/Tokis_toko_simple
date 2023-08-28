import 'package:hive_flutter/hive_flutter.dart';
import 'package:tokis_app/model/product.dart';

class DBService {
  var productBox = Hive.box<Product>('product');

  Future<void> addProduct(Product values) async {
    productBox.add(values).then((value){
      print('success add product');
    });
  }

  List<Product> fetchProduct() {
     List<Product> model = productBox.values.toList();
     return model;
  }

  Future<void> deleteProduct(int index) async {
    var listKey = productBox.keys.cast().toList();
    if(productBox.containsKey(listKey[index])){
      productBox.delete(listKey[index]).then((value) {
        print('success delete item');
      });
    }
  }
  Future<void> updateProduct(int index, Product newProduct) async {
    final allkeys = productBox.keys.cast().toList();
    if(productBox.containsKey(allkeys[index])){
      await productBox.put(allkeys[index], newProduct).then((value) {
        print('success update item');
      });
    }

  }
}