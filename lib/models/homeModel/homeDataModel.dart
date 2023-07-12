import 'package:shopapp/shared/components/constants.dart';

class homeModel
{
 late bool status;
 homeDataModel? data;

 homeModel.fromJason(Map<String,dynamic> jason)
 {
    status=jason['status'];
    data= homeDataModel.fromJason(jason['data']);
 }

}

class homeDataModel
{

  List<bannersModel> banners =[];

  List<ProductsModel> products=[];

  homeDataModel.fromJason(Map <String,dynamic> jason)
  {
    jason['banners'].forEach(
            (element)
            {
              banners.add(bannersModel(element)) ;
            }
        ) ;
    jason['products'].forEach(
            (element)
        {
          products.add(ProductsModel.fromJason(element));
        }
    );
  }

}

class bannersModel
{
 int? id;
 String? image;

  bannersModel(Map <String,dynamic> jason)
  {
    id = jason['id'];
    image = jason['image'];
  }
}

class ProductsModel
{
 late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? name;
  String? image;
  bool? inFavorite;
  bool? inCart;


  ProductsModel.fromJason(Map<String,dynamic> jason)
  {
    id = jason['id'];
    price= jason['price'];
    oldPrice= jason['old_price'];
    discount= jason['discount'];
    name= jason['name'];
    inFavorite= jason['in_favorites'];
    inCart= jason['in_cart'];
    image = jason['image'];

  }

}