

import 'dart:convert';

import 'package:get/get.dart';
import 'package:untitled/constants/firebase.dart';
import 'package:untitled/models/product.dart';

class ProductController extends GetxController{

  static ProductController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  String collections = "products";


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print("Running Product Controller");
    ProductProvider ob = ProductProvider();
    products.bindStream(ob.getCases().asStream());
  }

  Future<List<ProductModel>> getAllProductsHTTP(){

    

  }

  Stream<List<ProductModel>> getAllProducts(){
    print("Getting Collections");
    return firebaseFirestore.collection(collections).snapshots().
    map(( query) => query.docs.map(( item) {

      return ProductModel.fromMap(item.data());
    }
      ).toList()




    );

  }



}

class ProductProvider extends GetConnect{

  // @override
  // void onInit() {
  //   httpClient.baseUrl = 'https://api.covid19api.com';
  //   // It's will attach 'apikey' property on header from all requests
  //   httpClient.addRequestModifier((request) {
  //     request.headers['apikey'] = '12345678';
  //     return request;
  //   });
  // }

  Future<List<ProductModel>> getCases()async  {
    const JsonCodec JSON = const JsonCodec();

      print("https://fakestoreapi.com/products?limit=6");
      Response res = await  get('https://fakestoreapi.com/products?limit=6');

    print("decoded json  ${res.body}");
       //var parsed = JSON.decode(res.body);


       List<ProductModel> obj =   res.body.map<ProductModel>((json) =>ProductModel.fromMap(json)).toList();
       return obj;

  }
}


