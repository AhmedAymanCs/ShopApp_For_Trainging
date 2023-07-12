import '../../models/user_model/user_model.dart';

abstract class ShopStates{}

class ShopLoginInitialState extends ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopLoginLoadingState extends ShopStates{}

class ShopLoginSuccessState extends ShopStates{
 final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopStates{
  final error;
  ShopLoginErrorState({
    this.error
});
}

class ShopLoginOnSecureState extends ShopStates{}

class ShopChangeAppModeState extends ShopStates{}











