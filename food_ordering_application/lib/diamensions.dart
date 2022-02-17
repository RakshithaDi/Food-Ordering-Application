import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Diamesions {
  //gets height of screen on any phone
  static double screenHeight = Get.context.height;
  //gets width of screen on any phone
  static double screenWidth = Get.context.width;
  //screen height devided according to phone screen
  static double appBarViewContainer = screenHeight / 4.6;
  static double addViewContainer = screenHeight / 5.12;
}
