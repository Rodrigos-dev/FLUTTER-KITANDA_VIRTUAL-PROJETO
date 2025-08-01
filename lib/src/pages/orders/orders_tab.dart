import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/app_data.dart' as appData;
import 'package:greengrocer/src/pages/orders/components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: ListView.separated(
        separatorBuilder: (_, index) => const SizedBox(
          height: 10,
        ),
        itemCount: appData.orders.length,
        itemBuilder: (_, index) {
          return OrderTile(order: appData.orders[index],);
        },
      ),
    );
  }
}
