class DrinksModel {
  late String drinkName;
  late String drinkImage;
  late int id = 0;

  DrinksModel({
    required this.drinkName,
    required this.drinkImage,
    required this.id,
  });
  DrinksModel.fromJson(Map<String,dynamic>json){
    drinkName = json['drinkName'];
    drinkImage = json['drinkImage'];
    id = json['id'];
  }
  Map<String,dynamic> toMap(){
    return{
      'drinkName':drinkName,
      'drinkImage':drinkImage,
      'id':id,
    };
  }
}
