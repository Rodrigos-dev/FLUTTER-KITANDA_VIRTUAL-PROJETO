import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer/src/pages/cart/repository/cart_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();

  final utilsServices = UtilsServices();
  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;

    for (final item in cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
            token: authController.user.token!, userId: authController.user.id!);

    result.when(success: (data) {
      cartItems = data;
      update();

      //print(data);
    }, error: (message) {
      utilsServices.showToast(
        message: message,
        isError: true,
      );
    });
  }

  int getItemIndex(ItemModel item) {
    //pegando o index do elemento na lista de itens da compra
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);

  }

  Future<void> addItemToCard(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);

    if (itemIndex >= 0) {
      //entro aki sinal que exsite esse item na array ele soma a qtd com a qtd recebida

      final product = cartItems[itemIndex];

      final result = await changeItemQuantity(
        item: product, 
        quantity: (product.quantity + quantity)
      );         
      
    } else {
      //entro aki sinal que nao existe na lista ele adiciona o produto

      final CartResult<String> result = await cartRepository.addItemToCard(
        userId: authController.user.id!, 
        token: authController.user.token!, 
        productId: item.id, 
        quantity: quantity
      );

      result.when(
        success: (cartItemId) {
          cartItems.add(
        CartItemModel(
          id: cartItemId,
          item: item,
          quantity: quantity,
        ),
      );
        },
        error: (message) {
          utilsServices.showToast(
            message: message,
            isError: true
          );
        },
      );

      
    }

    update();
  }

  Future<bool> changeItemQuantity({
    required CartItemModel item,
    required int quantity,
  }) async {
    final result = await cartRepository.changeItemQuantity(
      token: authController.user.token!,
      cartItemId: item.id,
      quantity: quantity,
    );

    if(result){
      if(quantity == 0){
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      }else{
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity = quantity;
      }

      update();
    }else{
        utilsServices.showToast(
          message: 'Erro ao alterar quantidade do produto',
          isError: true,
        );
      }  

     return result;
  }


  int getCartTotalItems() {  
    return cartItems.isEmpty
                ? 0 
                : cartItems.map((e) => e.quantity).reduce((a, b) => a + b);
}


}
