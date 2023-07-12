import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/cubit/app_cubit.dart';
import 'package:shopapp/shared/cubit/states.dart';

class registerScreen extends StatelessWidget {
  const registerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state)=> Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: (){
                AppCubit.get(context).changeAppMode();
              },
                icon:Icon(
                  Icons.brightness_4_outlined
                ),
            )
          ],
        ),
        body: Center(
          child: Text(
            'REGISTER SCREEN',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }
}
