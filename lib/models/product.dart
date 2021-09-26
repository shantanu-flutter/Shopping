class ProductModel{
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const BRAND = "brand";
  static const PRICE = "price";
  static const title = "title";

   int id;
   String image;
   String name;
   String brand;
   double price;

  ProductModel({this.id, this.image, this.name, this.brand, this.price});

  ProductModel.fromMap(Map<String, dynamic> data){
    print(data);
    id = data[ID];
    image = data[IMAGE];
    name = data[title];
    brand = data[BRAND];
    price = data[PRICE].toDouble();
  }

}