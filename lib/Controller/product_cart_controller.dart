
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Models/Product.dart';
import '../Utils/shared_preference.dart';

class CartController extends GetxController {
  // TODO Add a dictionary to store the products in the cart
  final _products = {}.obs;
  var mySubsidyAmount = {}.obs;
  // var myTotalBill = {}.obs;
  // var mySubsidyPercentage = {}.obs;
  get products => _products;
  var subsidy = Constants.preferences?.getInt('SubsidyPercentage').obs;
  // Rx<double?> subsidyPercentage = (subsidy! / 100).obs as Rx<double?>;



  // TODO For Calculating Sub Total of Products
  get productSubTotal => _products.entries.map((product) => product.key.price
      * product.value);
  get cartSubTotal => _products.entries.map((product) => product.key.price
      * product.value).toList()
      .reduce((value, element) => value + element);

  // TODO For Calculating Total Price of Products After Discount
  get productTotal => _products.entries.map((product) => product.key.price
      * product.value ).toList();
  get cartTotal => _products.entries.map((product) => product.key.price
      * product.value).toList()
      .reduce((value, element,) => value + element);

  // TODO Add Product in the Dictionary
  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }
    Get.snackbar(
        "Product Added", "You have added the ${product.name} to the cart",
        duration: Duration(milliseconds: 1000),
        snackPosition: SnackPosition.BOTTOM
    );
  }

  // TODO Remove Product From The Dictionary
  void removeProduct(Product product){
    if(_products.containsKey(product) && _products[product] == 1){
      _products.removeWhere((key, value) => key == product);
    }else{
      _products[product] --;
    }
  }

}