

import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/result/home_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllCategories, 
      method: HttpMethods.post,
    );

    if(result['result'] != null){
      //lista

      List<CategoryModel> data = 
      (List<Map<String, dynamic>>.from(result['result']))
      .map(CategoryModel.fromJson).toList();

      return HomeResult<CategoryModel>.success(data);

    }else {
      //erro
      return HomeResult.error(
        'Ocorreu um erro inesperado ao recuperar as categorias'
      );

    }
  }


  Future<HomeResult<ItemModel>> getAllProducts(
    Map<String, dynamic> body) async {
      final result = await _httpManager.restRequest(
        url: Endpoints.getAllProducts, 
        method: HttpMethods.post,
        body: body
      );

      if(result['result'] != null){
      //lista

      List<ItemModel> data = 
      (List<Map<String, dynamic>>.from(result['result']))
      .map(ItemModel.fromJson).toList();

      //print('$data, teste all products repositorio');

      return HomeResult<ItemModel>.success(data);

    }else {
      //erro
      return HomeResult.error(
        'Ocorreu um erro inesperado ao recuperar as categorias'
      );

    }
  }
  
}