class CategoriesModel
{
  late bool status;
  CategoriesDataModel? data;
  CategoriesModel.fromjason(Map<String,dynamic> jason)
  {
    status=jason['status'];
    data=CategoriesDataModel.fromJason(jason['data']);
  }

}

class CategoriesDataModel
{
  int? currentPage;
  List<DateModel> data=[];
  CategoriesDataModel.fromJason(Map<String,dynamic> jason)
  {
    currentPage=jason['current_page'];
    jason['data'].forEach(
        (element){
          data.add(DateModel.fromJason(element));
        }
    );
  }
}

class DateModel
{
  int? id;
  String? name;
  String? image;

  DateModel.fromJason(Map<String,dynamic> jason)
  {
    id=jason['id'];
    name=jason['name'];
    image=jason['image'];
  }
}