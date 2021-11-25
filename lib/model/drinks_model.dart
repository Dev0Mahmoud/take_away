class DrinksModel {
  late String drinkName;
  late String drinkImage;

  DrinksModel({
    required this.drinkName,
    required this.drinkImage,
  });
  DrinksModel.fromJson(Map<String,dynamic>json){
    drinkName = json['drinkName'];
    drinkImage = json['drinkImage'];
  }
  Map<String,dynamic> toMap(){
    return{
      'drinkName':drinkName,
      'drinkImage':drinkImage,
    };
  }
}
