class Item {
  final int productId;
  final String name;
  final double price;
  final String imgUrl;
  int quantity;
  final String description;

  Item(
      {this.productId,
      this.name,
      this.price,
      this.imgUrl,
      this.quantity,
      this.description});

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
