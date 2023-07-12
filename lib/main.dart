import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/cubit/shop_cubit.dart';
import 'package:shopapp/layouts/home_layout.dart';
import 'package:shopapp/modules/login/loginscreen.dart';
import 'package:shopapp/modules/on_boarding/on_boarding.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/cubit/app_cubit.dart';
import 'package:shopapp/shared/cubit/login_shop_cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';
import 'package:shopapp/shared/network/local/shared_preferences.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/styles/bloc_observer.dart';

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget? widget;
 String? Token=CacheHelper.getData('token');
  bool? isDark=CacheHelper.getData('isDark');
  print(Token);
  if(CacheHelper.getData('onboarding') !=null)
    {
      if( Token !=null)
        {
          widget=homeLayout();
        }
      else
      widget= loginScreen();
    }
  else
    {
      widget=onBoradingScrren();
    }

  runApp( MyApp(isDark,widget));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? widget;
  const MyApp(this.isDark,this.widget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
          providers: [
            BlocProvider(
                create:(context)=>AppCubit()..changeAppMode(fromShared: isDark)
            ),
            BlocProvider(
                create:(context)
                {
                  return homeShopCubit()..getHomeData()..getCategoriesData()..getFavoriteData()..getProfileInfo();
                },
            ),

          ],
          child: BlocConsumer<AppCubit,ShopStates>(
            listener: (context,state){},
            builder:(context,state)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: primaryColor,
            )
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.grey,
          ),
        ),
        themeMode: AppCubit.get(context).isDark ?ThemeMode.light : ThemeMode.dark,
        darkTheme: ThemeData(),
        home: widget,
      ),
          ),
    );
  }
}
