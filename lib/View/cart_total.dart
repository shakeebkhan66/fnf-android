import 'package:flutter/material.dart';
import 'package:fnf_project/Utils/shared_preference.dart';
import 'package:fnf_project/Controller/product_cart_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CartTotal extends StatelessWidget {
  final CartController controller = Get.find();
  CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double subsidyPercentage;
    subsidyPercentage = (controller.subsidy! / 100)! as double;
    // controller.mySubsidyPercentage = subsidyPercentage;
    var subsidyAmount = controller.cartSubTotal * subsidyPercentage;
    // controller.mySubsidyAmount = subsidyAmount;
    var totalBill = controller.cartSubTotal - subsidyAmount;
    return Obx(() =>
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 75),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "SubTotal",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(
                    "${controller.cartSubTotal}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discount",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(
                    "${subsidyAmount}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(
                    "${totalBill}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
              const SizedBox(height: 25.0),
              MaterialButton(
                onPressed: (){},
                color: Colors.blue.shade500,
                child: const Text("Confirm Order", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ),
    );
  }
}
