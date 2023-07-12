class ShopLoginModel
{
  late bool status;
   String? message;
  UserModel? data;

  ShopLoginModel.fromJason(Map<String,dynamic> jason)
  {
    status=jason['status'];
    message=jason['message'];
    data=jason['data'] != null ? UserModel.fromJason(jason['data']) : null;
  }


}

class UserModel
{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? point;
  int? credit;
  String? token;

  UserModel.fromJason(Map<String,dynamic> jason)
  {
    id=jason['id'];
    name=jason['name'];
    email=jason['email'];
    phone=jason['phone'];
    image=jason['image'];
    point=jason['point'];
    credit=jason['credit'];
    token=jason['token'];
  }
}