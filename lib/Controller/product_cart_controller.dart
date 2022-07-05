
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Models/Product.dart';
import '../Utils/shared_preference.dart';

class CartController extends GetxController {
  // TODO Add a dictionary to store the products in the cart
  final _products = {}.obs;
  var cartItems = <Product>[].obs;
  var mySubsidyAmount = {}.obs;
  var discountFee = {}.obs;
  var totalAmount = {}.obs;
  var subsidy = Constants.preferences?.getInt('SubsidyPercentage').obs;
  get products => _products;



  // TODO For Calculating Sub Total of Products
  get productSubTotal => _products.entries.map((product) => product.key.price
      * product.value);
  get cartSubTotal => _products.entries.map((product) => product.key.price
      * product.value).toList()
      .reduce((value, element) => value + element);

  sumCart(){
    return _products.entries.map((product) => product.key.price
        * product.value);
  }

  discountFeeFunction() {
    return discountFee = (sumCart() * subsidy)/100;
  }

    getFinalTotal() {
      return sumCart() - discountFeeFunction();
    }


    // TODO For Calculating Total Price of Products After Discount
    // get productTotal => _products.entries.map((product) => product.key.price
    //     * product.value * subsidy);
    // get cartTotal => _products.entries.map((product) => product.key.price
    //     * product.value * subsidy).toList()
    //     .reduce((value, element,) => value + element);

    // TODO Add Product in the Dictionary
    void addProduct(Product product) {
      if (_products.containsKey(product)) {
        _products[product] += 1;
      } else {
        _products[product] = 1;
      }
      Get.snackbar(
          "Product Added", "You have added the ${product.name} to the cart",
          duration: const Duration(milliseconds: 700),
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

