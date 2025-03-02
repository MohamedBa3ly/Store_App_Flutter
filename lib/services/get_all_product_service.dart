
import 'package:store_app/helper/api.dart';
import 'package:store_app/model/product_model.dart';

class AllProductServices{
  Future<List<ProductModel>> getAllProducts() async{

    List<dynamic> data = await Api().get(url: 'https://fakestoreapi.com/products');

    List<ProductModel> productList = [];
    for(int i =0; i < data.length ; i++){
      productList.add(ProductModel.fromjson(data[i]));
    }

    return productList;

  }
}