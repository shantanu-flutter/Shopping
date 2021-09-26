import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/constants/controllers.dart';
import 'package:untitled/models/cart_item.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const CART = "cart";


   String id;
   String name;
   String email;
   List<CartItemModel> cart;

  UserModel({this.id, this.name, this.email});


  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, cart: $cart}';
  }

  UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> snapshot) {
    name = snapshot.data()[NAME];
    email = snapshot.data()[EMAIL];
    id = snapshot.data()[ID];
    cart = _convertCartItemModel(snapshot.data()[CART]??[]);
  }
  List<CartItemModel> _convertCartItemModel(List cartFromDb){
    List<CartItemModel> _result =[];
    logger.i("length is ${cartFromDb.length}");
    cartFromDb.forEach((element) {
      _result.add(CartItemModel.fromMap(element));
    });

    return _result;

  }
}
