class OrderModel {
  late String uId;
  late String drinkName;
  late String drinkImage;
  late int id = 0;
  late bool isCold;
  late bool isNewOrder;
  String? orderTime;
  String? drinkType;
  String? drinkQuantity;
  String? otherAdd;
  String? glassType;
  String? sugarType;
  String? coldDrinkSugarType;
  String? coffeeType;
  String? coffeeLevel;
  String? doubleGlassType;
  String? isDouble;
  String? sCGlassType;
  String? cSugarType;


  OrderModel({
    required this.uId,
    required this.drinkName,
    required this.drinkImage,
    required this.id,
    required this.isCold,
    required this.isNewOrder,
    this.orderTime,
    this.drinkType,
    this.drinkQuantity,
    this.otherAdd,
    this.glassType,
    this.sugarType,
    this.coldDrinkSugarType,
    this.coffeeType,
    this.coffeeLevel,
    this.doubleGlassType,
    this.isDouble,
    this.sCGlassType,
    this.cSugarType,

  });
  OrderModel.fromJson(Map<String,dynamic>json){
    uId = json['uId'];
    drinkName = json['drinkName'];
    drinkImage = json['drinkImage'];
    id = json['id'];
    isNewOrder = json['isNewOrder'];
    isCold = json['isCold'];
    orderTime = json['orderTime'];
    drinkType = json['drinkType'];
    drinkQuantity = json['drinkQuantity'];
    otherAdd = json['otherAdd'];
    glassType = json['glassType'];
    sugarType = json['sugarType'];
    coldDrinkSugarType = json['coldDrinkSugarType'];
    coffeeType = json['coffeeType'];
    coffeeLevel = json['coffeeLevel'];
    doubleGlassType = json['doubleGlassType'];
    isDouble = json['isDouble'];
    sCGlassType = json['sCGlassType'];
    cSugarType = json['cSugarType'];
  }

  Map<String,dynamic> toMap(){
    return{
      'uId':uId,
      'drinkName':drinkName,
      'drinkImage':drinkImage,
      'id':id,
      'isCold':isCold,
      'isNewOrder':isNewOrder,
      'orderTime':orderTime,
      'drinkType':drinkType,
      'drinkQuantity':drinkQuantity,
      'otherAdd':otherAdd,
      'glassType':glassType,
      'sugarType':sugarType,
      'coldDrinkSugarType':coldDrinkSugarType,
      'coffeeType':coffeeType,
      'coffeeLevel':coffeeLevel,
      'doubleGlassType':doubleGlassType,
      'isDouble':isDouble,
      'sCGlassType':sCGlassType,
      'cSugarType':cSugarType,
    };
  }
}
