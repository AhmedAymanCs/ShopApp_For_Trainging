import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/user_model/user_model.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class shopLoginCubit extends Cubit<ShopStates> {

  shopLoginCubit() : super (ShopLoginInitialState());

  static shopLoginCubit get(context) => BlocProvider.of(context);

  bool onSecure = true;

  void onSecureMethod() {
    onSecure = !onSecure;
    emit(ShopLoginOnSecureState());
  }

  ShopLoginModel? loginModel;

  void userLogin({
    @required String? email,
    @required String? password,

  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData
      (
        url: Login,
        data: {
          'email': '$email',
          'password': '$password',
        }).then((value) {
      loginModel = ShopLoginModel.fromJason(value.data);
      print(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      emit(ShopLoginErrorState(error: error));
      print(error.toString());
    });
  }

}