
import 'package:store_app/helper/api.dart';
import 'package:store_app/model/product_model.dart';

class CalledCategoryServices{
  Future<List<ProductModel>> getCalledCategoryProducts(String categoryName) async{

    List<dynamic> data = await Api().get(url: 'https://fakestoreapi.com/products/category/$categoryName');

    List<ProductModel> calledProductList = [];
    for(int i =0; i < data.length ; i++){
      calledProductList.add(ProductModel.fromjson(data[i]));
    }

    return calledProductList;

  }
}