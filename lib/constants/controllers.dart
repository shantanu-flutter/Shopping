
 import 'package:logger/logger.dart';
import 'package:untitled/controllers/appController.dart';
import 'package:untitled/controllers/authController.dart';
import 'package:untitled/controllers/cart_controller.dart';
import 'package:untitled/controllers/product_controller.dart';

AppController appController = AppController.instance;
 AuthController authController = AuthController.instance;
 ProductController productsController = ProductController.instance;
 CartController cartController = CartController.instance;

 var logger = Logger();