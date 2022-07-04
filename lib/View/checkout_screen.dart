import 'package:flutter/material.dart';
import 'package:fnf_project/View/product_list.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'cart_total.dart';
import 'checkout_cataglog.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade500,
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProductListScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 25,),
        ),
        title: const Center(
          child: Text(
            "Checkout Screen",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            CheckoutCatalog(),
            CartTotal(),
          ],
        ),
      ),
    );
  }
}
