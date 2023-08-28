import '../model/cart.dart';
import '../model/temp_cart.dart';

class CartService {
  List<CartModel> model = [];
  List<TempCart> model2 = [];
  List<CartModel> modelFinalTemp = [];

  int itemPrice(int price, int qua) {
    int prices = 0;
    return prices += price * qua;
  }

  int totalAll() {
    int total = 0;
    for (var modi in model2) {
      total += itemPrice(modi.allPrice, modi.amount);
    }
    return total;
  }

  int totalInCart (){
    int totalCart = 0;
    for(var modelW in model){
      totalCart += modelW.productAmount;
    }
    return totalCart;
  }

  void addToCart(CartModel mod, TempCart mod2) {
    bool productex = false;
    for (var modi in model) {
      if (modi.productName == mod.productName) {
        modi.productAmount++;
        productex = true;
        break;
      }
    }
    for (var mode in model2) {
      if (mode.name == mod2.name) {
        mode.amount++;
        productex = true;
        break;
      }
    }
    if (!productex) {
      model.add(mod);
      modelFinalTemp = List<CartModel>.from(model);
      model2.add(mod2);
    }
  }

  void minCart(CartModel mod, TempCart mod2) {
    bool productexs = false;
    for (var modi in model) {
      if (modi.productName == mod.productName && modi.productAmount > 1) {
        modi.productAmount--;
        productexs = true;
        break;
      }
    }
    for (var mode in model2) {
      if (mode.name == mod2.name && mode.amount > 1) {
        mode.amount--;
        productexs = true;
        break;
      }
    }
    if (!productexs) {
      model.removeWhere((element) => element.productName == mod.productName);
      model2.removeWhere((element) => element.name == mod2.name);
    }
  }
}
