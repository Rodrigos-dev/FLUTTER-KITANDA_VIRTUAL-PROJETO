import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/cart/controller/cart_controller.dart';
import 'package:greengrocer/src/pages/components_geral_apk/app_name_widget.dart';
import 'package:greengrocer/src/pages/home/controller/home_controller.dart';
import 'package:greengrocer/src/pages/home/view/components/category_tile.dart';
import 'package:greengrocer/src/services/utils_services.dart';

import 'package:greengrocer/src/config/app_data.dart' as appData;

import 'components/item_tile.dart';

class HomeTab extends StatefulWidget {
  HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCardAnimation;

  void itemSelectedCartAnimation(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  final UtilsServices utilsServices = UtilsServices();

  //final controller = Get.find<HomeController>();

  final searchController = TextEditingController();

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const AppNameWidget(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 15,
              ),
              child: GestureDetector(
                onTap: () {},
                // child: Badge(
                //   badgeColor: CustomColors.customContrastColor,
                //   badgeContent: Text(controller.getCartTotalItems().toString(),
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 12,
                //     ),
                //   ),
                //   child: AddToCartIcon(
                //     key: globalKeyCartItems,
                //     icon: Icon(
                //       Icons.shopping_cart,
                //       color: CustomColors.customSwatchColor,
                //     ),
                //   ),
                // ),
              ),
            ),
          ],
        ),
        body: AddToCartAnimation(
          gkCart: globalKeyCartItems, //chave de identificacao desse widget
          previewDuration:
              const Duration(milliseconds: 100), //duracao da animacao
          previewCurve: Curves.ease, //tipo de curva

          receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
            // You can run the animation by addToCardAnimationMethod, just pass trough the the global key of  the image as parameter
            runAddToCardAnimation = addToCardAnimationMethod;
          },

          child: Column(
            children: [
              //input search
              GetBuilder<HomeController>(
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        controller.searchTitle.value = value;
                        //print(value);
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        hintText: 'Pesquise aqui...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: CustomColors.customContrastColor,
                          size: 21,
                        ),
                        suffixIcon: controller.searchTitle.value.isNotEmpty 
                        ? IconButton(
                          onPressed: () {
                            searchController.clear();
                            controller.searchTitle.value = '';
                            FocusScope.of(context).unfocus();
                          }, 
                          icon: Icon(
                            Icons.close,
                            color: CustomColors.customContrastColor,
                            size: 21,
                          ),
                        )
                        : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),

              //menu das categorias
              GetBuilder<HomeController>(
                builder: (controller) {
                  return Container(
                    padding: const EdgeInsets.only(left: 25),
                    height: 40,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return CategoryTile(
                              category: controller.allCategories[index].title,
                              isSelected: controller.allCategories[index] ==
                                  controller.currentCategory,
                              onpressed: () {
                                controller.selectCategory(
                                    controller.allCategories[index]);
                              });
                        },
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 10),
                        itemCount: controller.allCategories.length),
                  );
                },
              ),

              GetBuilder<HomeController>(builder: (controller) {
                return Expanded(
                  child: Visibility(
                    visible: (controller.currentCategory?.items ?? []).isNotEmpty,

                    child: GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 9 / 11.5,
                        ),
                        itemCount: controller.allProducts.length,
                        itemBuilder: (_, index) {
                  
                          if(((index + 1) == controller.allProducts.length) && !controller.isLastPage){//
                            controller.loadMoreProducts();
                           
                          }
                  
                          return ItemTile(
                              item: controller.allProducts[index],
                              cartAnimationMethod: itemSelectedCartAnimation);
                        }),
                  
                    replacement: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,
                        size: 40,
                        color: CustomColors.customSwatchColor,
                        ),
                        const Text('Não há items para apresentar'),
                      ]
                    ),
                  
                  ),
                );
              })
            ],
          ),
        ));
  }
}
