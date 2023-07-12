import '../../models/addDeleteFavoriteModel/addDeleteFavoriteModel.dart';

abstract class ShopHomeStates {}


class IntialHomeState extends ShopHomeStates{}

class ChangeNavHomeState extends ShopHomeStates{}

class HomeLoadingState extends ShopHomeStates {}

class HomeSucsessState extends ShopHomeStates {}

class HomeErrorState extends ShopHomeStates {}

class getCategoriesSucsessState extends ShopHomeStates {}

class getCategoriesErrorState extends ShopHomeStates {}

class FavoritesSucsessState extends ShopHomeStates {}

class ChangeFavoritesSucsessState extends ShopHomeStates {
  addDeleteFavoriteModel favoriteModel;
  ChangeFavoritesSucsessState(this.favoriteModel);
}

class ChangeFavoritesErrorState extends ShopHomeStates {}

class getFavoritesLoadingState extends ShopHomeStates {}

class getFavoritesSucsessState extends ShopHomeStates {}

class getFavoritesErrorState extends ShopHomeStates {}

class getProfileSucsesState extends ShopHomeStates {}
class getProfileLoadingState extends ShopHomeStates {}
class getProfileErrorState extends ShopHomeStates {}

class editSettingState extends ShopHomeStates{}



class changeFavoriteButtonOnAppState extends ShopHomeStates{}
