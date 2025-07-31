import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems({
    required String token,
    required String userId,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.getCartItems,
        method: HttpMethods.post,
        headers: {'X-Parse-Session-Token': token
    },
    body: {
      'user': userId
      },
    );


    if(result['result'] != null){
      print(result['result']);

      List<CartItemModel> data = 
        List<Map<String, dynamic>>.from(result['result'])
          .map(CartItemModel.fromJson).toList();

      return CartResult<List<CartItemModel>>.success(data);
    }else {
      return CartResult.error('Ocorreu um erro ao recuperar os items do carrinho');
    }  
  }

  Future<CartResult<String>> addItemToCard({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.addItemToCard, 
      method: HttpMethods.post,
      body: {
        'user': userId,
        'quantity': quantity,
        'productId': productId,
      },
      headers: {
        'X-Parse-Session-Token': token
      }
    );

    if(result['result'] != null){
      //print(result['result']);
      
      return CartResult<String>.success(result['result']['id']);
    }else {      
      return CartResult.error('Não foi possivel add o item no carrinho');
    } 
  }


  Future<bool> changeItemQuantity({
    required String token,
    required String cartItemId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.changeItemQuantity, 
      method: HttpMethods.post,
      body:{
        'cartItemId': cartItemId,
        'quantity': quantity,
      },
      headers: { 'X-Parse-Session-Token': token},
    );

     return result.isEmpty;
  }
}
