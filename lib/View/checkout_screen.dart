import 'package:flutter/material.dart';
import 'package:fnf_project/View/product_list.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Controller/product_cart_controller.dart';
import 'cart_total.dart';
import 'checkout_cataglog.dart';

class CheckoutScreen extends StatelessWidget {
  final CartController controller = Get.find();
  CheckoutScreen({Key? key}) : super(key: key);
  
  
  // Prevent For Closing the App When click on Back Button
  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm'),
      content: const Text('Do you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text('Yes'),
        ),
      ],
    );
  }
  
  
  

  @override
  Widget build(BuildContext context) {
    double subsidyPercentage;
    subsidyPercentage = (controller.subsidy! / 100)! as double;
    // controller.mySubsidyPercentage = subsidyPercentage;
    var subsidyAmount = controller.cartSubTotal * subsidyPercentage;
    // controller.mySubsidyAmount = subsidyAmount;
    var totalBill = controller.cartSubTotal - subsidyAmount;

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade500,
          leading: IconButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductListScreen()));
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
              Expanded(
                child: Obx(() =>
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
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


