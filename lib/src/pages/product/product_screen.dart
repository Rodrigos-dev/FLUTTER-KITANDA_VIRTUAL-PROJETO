import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/base/controller/navigation_controller.dart';
import 'package:greengrocer/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocer/src/pages/components_geral_apk/quantity_widget.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class ProductScreen extends StatefulWidget {  

  ProductScreen({
    Key? key,   
  }) : super(key: key);

  final ItemModel item = Get.arguments;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final UtilsServices utilsServices = UtilsServices();

  final cartController = Get.find<CartController>();
  final navigationController = Get.find<NavigationController>();

  int cartItemQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),

      body: Stack(        
        children: [

          //Conteudo
          Column(
            children: [
              Expanded(
                child: Hero(
                  tag: widget.item.imgUrl,
                  child: Image.network(widget.item.imgUrl)),
              ),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [

                      //nome e quantidade na linha
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.item.itemName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          //componente quantidade de produto
                          QuantityWidget(
                            suffixText: widget.item.unit,
                            value: cartItemQuantity,
                            result: (quantity) {
                              setState(() {
                                cartItemQuantity = quantity;
                              });                              
                            },
                          ),
                        ],
                      ),

                      //Preco
                      Text(
                              utilsServices.priceToCurrency(widget.item.price),
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.customSwatchColor,
                              ),
                          ),


                      //DESCRICAO
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                            child: Text(
                                widget.item.description,
                                style: const TextStyle(
                                  height: 1.5,
                                ),
                            ),
                          ),
                        ),
                      ),

                      //botao
                      SizedBox(
                        height: 55,

                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            ),
                          ),

                          onPressed: () {
                            Get.back();

                            cartController.addItemToCard(item:widget.item);

                            navigationController.navigatePageView(NavigationTabs.cart);
                          }, 
                          label: const Text('Add no carrinho',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          icon: const Icon(Icons.shopping_cart_outlined,
                          color: Colors.white
                          ),

                        ),
                      )

                    ],
                  ),

                ),
              ),      
            
            ],
          ),

          Positioned(
                left: 10,
                top: 10,
                                
                child: SafeArea(
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),

          )

        ],
      ),
    );




  }
}