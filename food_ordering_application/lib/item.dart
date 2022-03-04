class Item {
  final String name;
  final double price;
  final String imgUrl;
  int quantity;
  // final String description;

  Item({this.name, this.price, this.imgUrl, this.quantity});

  String getName() {
    return name;
  }

  double getPrice() {
    return price;
  }

  String getImgurl() {
    return imgUrl;
  }

  int getQuantity() {
    return quantity;
  }
}
