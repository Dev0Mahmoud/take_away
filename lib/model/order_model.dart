class OrderModel {
  late String drinkName;
  late String drinkImage;
  String? drinkType;
  String? drinkQuantity;
  String? otherAdd;
  String? glassType;
  String? sugarType;

  String? coffeeType;
  String? coffeeLevel;
  String? doubleGlassType;
  String? isDouble;
  String? sCGlassType;
  String? cSugarType;


  OrderModel({
    required this.drinkName,
    required this.drinkImage,
    this.drinkType,
    this.drinkQuantity,
    this.otherAdd,
    this.glassType,
    this.sugarType,
    this.coffeeType,
    this.coffeeLevel,
    this.doubleGlassType,
    this.isDouble,
    this.sCGlassType,
    this.cSugarType,

  });
}
