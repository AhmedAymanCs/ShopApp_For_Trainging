import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/shared/network/local/shared_preferences.dart';

import '../../models/categoriesModel/categoryModel.dart';

Color primaryColor= HexColor('d16b17');

String Token = CacheHelper.getData('token');


void printFull(String text) {
  final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((RegExpMatch match) =>
      print(match.group(0)));
}






