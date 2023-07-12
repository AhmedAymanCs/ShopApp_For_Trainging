class addDeleteFavoriteModel
{
 late bool status;
 late String message;
 addDeleteFavoriteModel.fromJason(Map<String,dynamic> jason)
 {
   status=jason['status'];
   message=jason['message'];
 }
}