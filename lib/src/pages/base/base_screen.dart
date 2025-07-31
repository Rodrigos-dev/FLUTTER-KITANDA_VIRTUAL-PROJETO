
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/base/controller/navigation_controller.dart';
import 'package:greengrocer/src/pages/cart/cart_tab.dart';
import 'package:greengrocer/src/pages/profile/profile_tab.dart';

import '../home/view/home_tab.dart';
import '../orders/orders_tab.dart';


class BaseScreen extends StatefulWidget {
  BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  final pageController = PageController();


  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: navigationController.pageController,
        children: [
          HomeTab(),
          CartTab(),
          OrdersTab(),
          ProfileTab(),
        ],
      ),

      bottomNavigationBar: Obx(() => BottomNavigationBar(
        
        currentIndex: navigationController.currentIndex,
        onTap: (index) {          
            navigationController.navigatePageView(index);         
        },

        type: BottomNavigationBarType.fixed,//acima de 3 itens temos que colocar essa linha
        backgroundColor: Colors.green,//backgorund do bottombar
        selectedItemColor: Colors.white,//cor do icone selecionado
        unselectedItemColor: Colors.white.withAlpha(100),//cor dos itens que nao estao selecionados

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Carrinho',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pedidos',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'perfil',
          ),
        ],
      ),)
    );
  }
}

