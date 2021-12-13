
class UserModel {
  String? email;
  String? name;
  String? address;
  String? uId;
  String? phone;
  String? image;
  bool? admin;
  bool? hasProfileImage;


  UserModel({
    this.email,
    this.name,
    this.address,
    this.uId,
    this.phone,
    this.image,
    this.admin,
    this.hasProfileImage,
});

  UserModel.fromJson(Map<String,dynamic>json){
    email = json['email'];
    name = json['name'];
    address = json['address'];
    uId = json['uId'];
    phone = json['phone'];
    image = json['image'];
    admin = json['admin'];
    hasProfileImage = json['hasProfileImage'];
  }
  Map<String,dynamic> toMap(){
    return{
      'email':email,
      'name':name,
      'uId':uId,
      'phone':phone,
      'image':image,
      'admin':admin,
      'hasProfileImage':hasProfileImage,
      'address':address,
    };
  }
}