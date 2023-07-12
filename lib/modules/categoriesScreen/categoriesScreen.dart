import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/cubit/shop_cubit.dart';
import 'package:shopapp/layouts/cubit/states.dart';
import 'package:shopapp/shared/components/constants.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var model = homeShopCubit.get(context).categoriesModel;
    return BlocConsumer<homeShopCubit,ShopHomeStates>(
        builder: (context,state) =>ListView.separated
          (
            itemBuilder:(context,index)=> Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(
                    image: NetworkImage('${model.data!.data[index].image}'),
                    height:100,
                    width: 100,
                  ),
                ),
                Container(
                  width: 200,
                  child: Text(
                    '${model.data!.data[index].name!.toUpperCase()}',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 20,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(.6)
                    ),
                  ),
                ),
              ],
            ),
            separatorBuilder:(context,index)=> Container(
              width: double.infinity,
              color: Colors.grey.withOpacity(0.7),
              height: 1,
            ),
            itemCount:model!.data!.data.length ),
        listener: (conext,state){}
        );
  }
}
