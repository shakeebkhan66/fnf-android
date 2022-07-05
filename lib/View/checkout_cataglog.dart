import 'package:flutter/material.dart';
import 'package:fnf_project/Models/Product.dart';
import 'package:fnf_project/Controller/product_cart_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CheckoutCatalog extends StatelessWidget {
  final CartController controller = Get.find();
  CheckoutCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount:controller.products.length,
        itemBuilder: (context, index){
          return CheckoutCatalogCard(
            controller: controller,
            products: controller.products.keys.toList()[index],
            quantity: controller.products.values.toList()[index],
            index: index,
          );
        },
      ),
    )),
      ],
    );
  }
}


class CheckoutCatalogCard extends StatelessWidget {
  final CartController controller;
  final Product products;
  final int quantity;
  final int index;

  const CheckoutCatalogCard({Key? key, required this.controller,
    required this.products, required this.quantity, required this.index })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 20,),
          Expanded(
            child: Text(products.name.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          ),
          IconButton(
              onPressed: (){
                controller.removeProduct(products);
              },
              icon: const Icon(Icons.remove_circle)
          ),
          Text('${quantity}'),
          IconButton(
              onPressed: (){
                controller.addProduct(products);
              },
              icon: const Icon(Icons.add_circle)
          ),
        ],
      ),
    );
  }
}
