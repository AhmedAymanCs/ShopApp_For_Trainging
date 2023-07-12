import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/cubit/shop_cubit.dart';
import 'package:shopapp/layouts/cubit/states.dart';
import 'package:shopapp/modules/categoriesScreen/categoriesScreen.dart';
import 'package:shopapp/modules/favoriteScreen/favoriteScreen.dart';
import 'package:shopapp/modules/homeScreen/homeScreen.dart';
import 'package:shopapp/modules/login/loginscreen.dart';
import 'package:shopapp/modules/settingScreen/settingScreen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/local/shared_preferences.dart';

class homeLayout extends StatelessWidget {

  List<Widget> HomeScreens =
  [
    HomeScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var cubit = homeShopCubit.get(context);
    return BlocConsumer<homeShopCubit,ShopHomeStates>(
      listener: (context,state){},
      builder: (context,state)=>Scaffold(
        appBar: AppBar(
          title: Text(
            'Salla',
            style: TextStyle(
              color: Colors.black,
            ),

          ),
          actions: [

          ],
        ),
        body: HomeScreens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon:Icon(
                  Icons.home
                ) ,
              label: 'Home'
            ),
            BottomNavigationBarItem(
                icon:Icon(
                  Icons.apps
                ) ,
              label: 'Categories'
            ),
            BottomNavigationBarItem(
                icon:Icon(
                  Icons.favorite
                ) ,
              label: 'Favorites'
            ),
            BottomNavigationBarItem(
                icon:Icon(
                  Icons.settings
                ) ,
              label: 'Settings'
            ),
          ],
          onTap: (index)
          {
            cubit.changeBottomNav(index);
          },
          currentIndex: cubit.currentIndex,
        ),
      ),
    );
  }
}
