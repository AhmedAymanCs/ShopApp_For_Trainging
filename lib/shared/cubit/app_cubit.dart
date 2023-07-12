import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/local/shared_preferences.dart';

class AppCubit extends Cubit<ShopStates>
{
  AppCubit() : super (ShopInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark =false;
  void changeAppMode({@required bool? fromShared})
  {
    if(fromShared != null)
      {
        isDark=fromShared;
        emit(ShopChangeAppModeState());
      }
    else {
      isDark = !isDark;
      CacheHelper.putData('isDark', isDark).then((value) {
        emit(ShopChangeAppModeState());
      });
    }
  }
}