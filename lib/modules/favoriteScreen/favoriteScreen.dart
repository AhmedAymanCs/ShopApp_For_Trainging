import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layouts/cubit/shop_cubit.dart';
import 'package:shopapp/layouts/cubit/states.dart';
import 'package:shopapp/models/FavoriteModel/FavoriteModel.dart';

import '../../shared/components/constants.dart';

class FavoriteScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeShopCubit,ShopHomeStates>(
      listener: (context,state){
      },
      builder:(context,state)=> ConditionalBuilder(
        condition: state is !getFavoritesLoadingState,
        fallback:(context)=> Center(child: CircularProgressIndicator()),
        builder:(context)=> ListView.separated(
          itemCount: homeShopCubit.get(context).favoriteModel!.data!.data!.length,
          separatorBuilder:(context, index) =>  Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),
          itemBuilder:(context, index) => FavoriteItemBuilder(homeShopCubit.get(context).favoriteModel!.data!.data![index].product,context),
        ),
      ),
    );
  }

  Widget FavoriteItemBuilder ( FavoriteProductModel model,context)
  {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image:NetworkImage(
                      '${model.image}',
                    ),
                    height:150,

                  ),
                  if(model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'Discount',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    child: Text(
                      '${model.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),

                      ),
                      SizedBox(
                        width: 10,
                      ),
                      if(model.discount != 0)
                        Text(
                          '${model.oldprice}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough
                          ),


                        ),
                      Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){
                             homeShopCubit.get(context).changeFavoriteButton(model.id!);
                          },
                          icon: CircleAvatar(
                             backgroundColor: homeShopCubit.get(context).favorites[model.id]! ? Colors.red : Colors.grey.withOpacity(0.6) ,//id in favorite
                            radius: 15,
                            child: Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                              size: 15,
                              //size: 15,
                            ),
                          ))

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
