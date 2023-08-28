class TempCart {
  final String name;
  int amount;
  int allPrice;
  TempCart({
    required this.allPrice,
    required this.amount,
    required this.name
  });

  
  static int itemPrice(int price, int qua) {
    int prices = 0;
    return prices += price * qua;
  }
}