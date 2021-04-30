class Cart {
  final String shop;
  final String uid;
  final String shopUID;
  final String shopAddress;
  final String customerAddress;
  final String phone;
  final String shopName;
  final double cost;
  final Map<String,dynamic> list;

  Cart({
    this.cost,
    this.shopName,
    this.customerAddress,
    this.phone,
    this.shopAddress,
    this.uid,
    this.shop,
    this.shopUID,
    this.list,
  });
}