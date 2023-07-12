import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layouts/home_layout.dart';
import 'package:shopapp/modules/register_screen/registerScreen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/cubit/login_shop_cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/local/shared_preferences.dart';

class loginScreen extends StatelessWidget {
  var emailAddressController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>shopLoginCubit(),
      child:BlocConsumer<shopLoginCubit,ShopStates>(
        listener: (context,state)
        {
          if(state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
             CacheHelper.putData('token',state.loginModel.data!.token).then((value) {
               Token=state.loginModel.data!.token!;
               Fluttertoast.showToast(
                   msg: state.loginModel.message!,
                   toastLength: Toast.LENGTH_LONG,
                   gravity: ToastGravity.BOTTOM,
                   timeInSecForIosWeb: 1,
                   backgroundColor: Colors.green,
                   textColor: Colors.white,
                   fontSize: 16.0
               );
               navigatToAndFinish(context, homeLayout());
             });

            }
            else {
              Fluttertoast.showToast(
                  msg: state.loginModel.message!,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }
          },
        builder:(context,state)=> Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Login now for our hot offers',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.grey,

                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      defaultTextFormField(
                        controller: emailAddressController,
                        type: TextInputType.emailAddress,
                        preIcon: Icon(
                          Icons.email_outlined
                        ),
                        label: 'Email Address',
                        validate: (value)
                        {
                         if(value!.isEmpty)
                           {
                             return'Email Address Must Be not empty';
                           }
                        },

                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextFormField(
                        controller: passwordController,
                       sufIcon: IconButton(
                         onPressed: () {
                           shopLoginCubit.get(context).onSecureMethod();
                         },
                            icon: Icon(
                              shopLoginCubit.get(context).onSecure ? Icons.visibility_outlined :Icons.visibility_off_outlined
                            ),
                        ),
                        label: 'Password',
                        secure: shopLoginCubit.get(context).onSecure,
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return'Password Must Be not empty';
                          }
                        },
                        onSubmit: (value) {
                          if(formKey.currentState!.validate())
                          {
                            shopLoginCubit.get(context).userLogin(email: emailAddressController.text, password: passwordController.text);
                            CacheHelper.putData('token', shopLoginCubit.get(context).loginModel!.data!.token).then((value)
                            {
                              Token= shopLoginCubit.get(context).loginModel!.data!.token!;
                            } );
                          }
                        }
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is ShopLoginLoadingState,
                        builder: (context)=>Center(child: const CircularProgressIndicator()),
                        fallback:(context)=> defaultButton(
                          text: 'login',
                          upper: true,
                          width: double.infinity,
                          backgroundColor: Colors.blue,
                          onPressed: ()
                          {
                            if(formKey.currentState!.validate())
                              {
                                  shopLoginCubit.get(context).userLogin(email: emailAddressController.text, password: passwordController.text);
                              }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Don\`t Have an account ?',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          defaultButton(
                            onPressed: (){
                              navigatTo(context, registerScreen());
                            },
                            colorOfText: Colors.blue,
                            upper: true,
                            text: 'register'
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
