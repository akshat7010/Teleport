class Processing{
  final String time;
  final String shopUID;
  final String shopAddress;
  final String customerUID;
  final String customerAddress;
  final String phoneNumber;
  final String orderUID;
  final String shopName;
  final double cost;
  int state;
  Processing({this.time,this.shopUID,this.shopAddress,
    this.customerUID,this.customerAddress,this.orderUID,this.shopName,this.state,this.phoneNumber,this.cost});
}