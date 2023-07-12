import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/cubit/states.dart';

import 'package:shopapp/models/categoriesModel/categoryModel.dart';
import 'package:shopapp/models/homeModel/homeDataModel.dart';
import 'package:shopapp/models/user_model/user_model.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/local/shared_preferences.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

import '../../models/FavoriteModel/FavoriteModel.dart';
import '../../models/addDeleteFavoriteModel/addDeleteFavoriteModel.dart';

class homeShopCubit extends Cubit<ShopHomeStates>
{
  homeShopCubit() : super (IntialHomeState());

 static homeShopCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;
  void changeBottomNav (int index)
  {
    currentIndex=index;
    emit(ChangeNavHomeState());
  }
  
  homeModel? HomeData;
  CategoriesModel? categoriesModel;
  Map<int?,bool?> favorites={};

  addDeleteFavoriteModel? addDeletefavoriteModel;
  void getHomeData()
  {
    emit(HomeLoadingState());
   DioHelper.getData(
        url: Home,
     token:Token ,
    ).then(
        (value)
        {
          HomeData=homeModel.fromJason(value.data);
          emit(HomeSucsessState());
          HomeData!.data!.products.forEach((element) { 
            favorites.addAll(
              {
                element.id : element.inFavorite
              }
            );
          });

        }
    ).catchError(
            (error)
    {
      emit(HomeErrorState());
      print(error.toString());

    });



  }
  void getCategoriesData()
  {
   DioHelper.getData(
        url: Categories,
    ).then(
            (value)
        {
          categoriesModel= CategoriesModel.fromjason(value.data);
          emit(getCategoriesSucsessState());
        }
            ).catchError((error)
    {
      emit(getCategoriesErrorState());
    }
    );
  }

  void changeFavoriteButton(int productId)
  {
    favorites[productId]= ! favorites[productId]!;
emit(changeFavoriteButtonOnAppState());
    DioHelper.postData
      (url: Favorite,
        data:{
        'product_id': productId
        },
        token: Token,
    ).then((value) {
      addDeletefavoriteModel=addDeleteFavoriteModel.fromJason(value.data);
      emit(ChangeFavoritesSucsessState(addDeletefavoriteModel!));
      if(!addDeletefavoriteModel!.status)
      {
        favorites[productId]= ! favorites[productId]!;
      }
      else
        {
          getFavoriteData();
        }
    }).catchError((error)
    {
    emit(ChangeFavoritesErrorState());
    }
    );
  }

   FavoriteModel? favoriteModel ;

  void getFavoriteData()
  {
    emit(getFavoritesLoadingState());
    DioHelper.getData(
        url: Favorite,
      token: Token,
    ).then((value)
    {
      favoriteModel = FavoriteModel.fromjason(value.data);
      emit(getFavoritesSucsessState());
    }
    ).catchError(
            (error)
        {
          print(error.toString());
          emit(getFavoritesErrorState());
        }
        );
  }

  ShopLoginModel? shopLoginModel;

  void getProfileInfo()
  {
    getProfileLoadingState();
    DioHelper.getData(
        url: Profile,
      token: Token,
    ).then(
            (value)
        {
         shopLoginModel=ShopLoginModel.fromJason(value.data);
         emit(getProfileSucsesState());
        }
        ).catchError(
        (error)
            {
              print(error.toString());
              emit(getProfileErrorState());
            }
    );
  }

  bool enabled = false;
  void editSetting()
  {
    enabled = !enabled;
    emit(editSettingState());
  }

}
