import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/cubit/shop_cubit.dart';
import 'package:shopapp/layouts/cubit/states.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/login_shop_cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';

import '../../shared/network/local/shared_preferences.dart';
import '../login/loginscreen.dart';

class SettingScreen extends StatelessWidget {

  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeShopCubit,ShopHomeStates>(
      listener: (context,state) {},
      builder:(context,state) {
        nameController.text=homeShopCubit.get(context).shopLoginModel!.data!.name!;
        phoneController.text=homeShopCubit.get(context).shopLoginModel!.data!.phone!;
        emailController.text=homeShopCubit.get(context).shopLoginModel!.data!.email!;
        return  Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                defaultTextFormField(
                  enabled: homeShopCubit.get(context).enabled,
                  type: TextInputType.name,
                  controller: nameController,
                  label: 'Name',
                  preIcon: Icon(
                    Icons.person,
                  ),
                  border: 10,
                  validate: (value)
                  {
                    if(value!.isEmpty)
                      return 'Name Must Be not empty';
                  },

                ),
                SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  enabled: homeShopCubit.get(context).enabled,
                  type: TextInputType.emailAddress,
                  controller: emailController,
                  label: 'Email Address',
                  preIcon: Icon(
                    Icons.mail_outline,
                  ),
                  border: 10,
                  validate: (value)
                  {
                    if(value!.isEmpty)
                      return 'Email Address Must Be not empty';
                  },

                ),
                SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  enabled: homeShopCubit.get(context).enabled,
                  type: TextInputType.phone,
                  controller: phoneController,
                  label: 'Phone',
                  preIcon: Icon(
                    Icons.phone,
                  ),
                  border: 10,
                  validate: (value)
                  {
                    if(value!.isEmpty)
                      return 'Phone Must Be not empty';
                  },

                ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton
                    (
                    text: 'Edit',
                    onPressed: (){
                      homeShopCubit.get(context).editSetting();
                    },
                    backgroundColor:homeShopCubit.get(context).enabled ? Colors.grey : Colors.deepOrange,
                  ),
               SizedBox(
                 height: 20,
               ),
                defaultButton(
                    text: 'Sign out',
                    width: double.infinity,
                    backgroundColor: Colors.deepOrange,
                    onPressed: (){
                      CacheHelper.removeData('token').then((value) {
                        navigatToAndFinish(context, loginScreen());
                      });
                    }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
