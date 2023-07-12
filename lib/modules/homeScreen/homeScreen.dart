import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layouts/cubit/shop_cubit.dart';
import 'package:shopapp/layouts/cubit/states.dart';
import 'package:shopapp/models/categoriesModel/categoryModel.dart';
import 'package:shopapp/models/homeModel/homeDataModel.dart';
import 'package:shopapp/models/homeModel/homeDataModel.dart';
import 'package:shopapp/models/homeModel/homeDataModel.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/cubit/states.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeShopCubit,ShopHomeStates>(
      listener: (context,state) {
        if(state is ChangeFavoritesSucsessState)
          {
            if(!state.favoriteModel.status)
              {
                Fluttertoast.showToast(msg: state.favoriteModel.message,
                backgroundColor: Colors.red,
                );
              }
          }

      },
      builder:(context,state)=> ConditionalBuilder(
          condition:homeShopCubit.get(context).HomeData != null && homeShopCubit.get(context).categoriesModel !=null,
          fallback:(context)=>Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => productsModel(homeShopCubit.get(context).HomeData!,
             homeShopCubit.get(context).categoriesModel!,context)
      ),
    );
  }


  Widget productsModel ( homeModel model,  CategoriesModel? categoriesModel ,context)
  {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: model.data!.banners.map((e)=> Image(
                  image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
              )
              ).toList(),
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                initialPage: 0,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayInterval: Duration( seconds: 3),
                reverse: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 1,

              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index)=>categoriesmodel(categoriesModel.data!.data[index]),
                    separatorBuilder: (context,index)=>SizedBox(width: 10,),
                    itemCount:categoriesModel!.data!.data.length,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'New Product',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              clipBehavior: Clip.hardEdge,
              childAspectRatio: 1/1.58,
              children: List.generate(model.data!.products.length,
                      (index) => gridProductModel(model.data!.products[index],context),
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget gridProductModel(ProductsModel model,context)
  {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                  image:NetworkImage(
                    '${model.image}',
                  ),
                height: 200,
                //fit: BoxFit.cover,
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
          Padding(
            padding: const EdgeInsets.all(2.0),
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
                      '${model.oldPrice}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough
                      ),


                    ),
                    Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                        onPressed: () {
                       homeShopCubit.get(context).changeFavoriteButton(model.id);

                        },
                        icon: CircleAvatar(
                          backgroundColor: homeShopCubit.get(context).favorites[model.id]! ? Colors.red : Colors.grey.withOpacity(0.6) ,
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
    );
  }

  Widget categoriesmodel(DateModel Model)
  {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${Model.image}'),
          height:100,
          width: 100,
        ),
        Container(
          color: Colors.black.withOpacity(0.7),
          width: 100,
          child: Text(
            '${Model.name}',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ],
    );
  }
}
