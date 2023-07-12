class FavoriteModel
{
   bool? status;
   FavoriteDataModel? data;
FavoriteModel.fromjason(Map<String,dynamic> jason)
{
  status = jason['status'];
  data = FavoriteDataModel.fromjason(jason['data']);
}
}

class FavoriteDataModel
{

  int? currentPage;
List<DataModel>? data=[];
  FavoriteDataModel.fromjason(Map<String,dynamic> jason)
  {
    currentPage=jason['current_page'];
    jason['data'].forEach(
        (element)
            {
              data!.add(DataModel.fromjason(element));
            }
    );
  }

}

class DataModel
{
int? id;
late FavoriteProductModel product;
DataModel.fromjason(Map<String,dynamic> jason)
{
  id=jason['id'];
  product = FavoriteProductModel.fromjason(jason['product']);
}

}

class FavoriteProductModel
{
  int? id;
   dynamic price;
   dynamic oldprice;
   int? discount;
   String? image;
   String? name;

   FavoriteProductModel.fromjason(Map<String,dynamic> jason)
   {
     id=jason['id'];
     price=jason['price'];
     oldprice=jason['old_price'];
     discount=jason['discount'];
     image=jason['image'];
     name=jason['name'];
   }

}