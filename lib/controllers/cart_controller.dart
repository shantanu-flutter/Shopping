import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/constants/controllers.dart';
import 'package:untitled/models/cart_item.dart';
import 'package:untitled/models/product.dart';
import 'package:untitled/models/user.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController{
  static CartController instance = Get.find();
  RxDouble totalCartPrice = 0.0.obs;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(authController.userModel ,  changeCartTotalPrice);
  }

  void addProductToCart(ProductModel product){
    print("before ${authController.userModel.value}");
    try{
      if(_isItemAlreadyAddedToCart(product)){
        Get.snackbar("Check Your cart", "${product.name} is already added");
      }else{
        String itemId = Uuid().v1();
        authController.updateUserData({
          "cart":FieldValue.arrayUnion([
            {
            "id": itemId,
            "image": product.image,
            "name":product.name ,
            "quantity": 1,
            "cost" : product.price,
            'productId': product.id,
              "price" : product.price,

            }
          ])


        });
        Get.snackbar("Item added", "${product.name} was added to your cart");

      }
    }catch(e,stack){
      Get.snackbar("Error", "cammon add to cart");
      debugPrint(stack.toString());
    }

  }

  void removeCartItem(CartItemModel cartItem){
    try{

      authController.updateUserData({
        "cart":FieldValue.arrayRemove([cartItem.toJson()])
      });

      Get.snackbar("Item Removed", "${cartItem.name} successfully removed");
    }catch(e){
      Get.snackbar("Error", "cammon remove to cart");
      debugPrint(e.toString());
    }

  }

  bool _isItemAlreadyAddedToCart(ProductModel product){
    print(authController.userModel.value);
    return authController.userModel.value.cart.where((item) => item.productId==product.id).isNotEmpty;

  }
  changeCartTotalPrice(UserModel userModel){
    totalCartPrice.value = 0.0;
    if(userModel.cart.isNotEmpty){
      userModel.cart.forEach((element) {  totalCartPrice.value += element.cost; });

    }
  }

  void decreaseQuantity(CartItemModel item){
    if(item.quantity==1){
      removeCartItem(item);
    }else{
      removeCartItem(item);
      item.quantity--;
      authController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });

    }

    }

  void increaseQuantity(CartItemModel item){
    removeCartItem(item);
    item.quantity++;
    logger.i({"quantity": item.quantity});
    authController.updateUserData({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });



  }

}