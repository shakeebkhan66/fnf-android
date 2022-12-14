
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../Models/Product.dart';
import '../Utils/shared_preference.dart';

class CartController extends GetxController {
  // TODO Add a dictionary to store the products in the cart
  final _products = {}.obs;
  var cartItems = <Product>[].obs;
  var subsidy = Constants.preferences?.getInt('SubsidyPercentage').obs;
  get products => _products;



  // TODO For Calculating Sub Total of Products
  get productSubTotal => _products.entries.map((product) => product.key.price
      * product.value);
  get cartSubTotal => _products.entries.map((product) => product.key.price
      * product.value).toList()
      .reduce((value, element) => value + element);


  var subTotal = 0.obs;
  var subsidyAmount = 0.0.obs;
  var totalAmount = 0.0.obs;


  sumCart(){
    subTotal.value = cartSubTotal;
    if(_products.isNotEmpty){
      return subTotal.value;
    }else{
      return 0;
    }
  }

  discountFeeFunction() {
    return subsidyAmount.value = sumCart() * 0.25;
  }

    getFinalTotal() {
     return totalAmount.value = sumCart() - discountFeeFunction();
    }

    // TODO Add Product in the Dictionary
    void addProduct(Product product, context) {
      if (_products.containsKey(product)) {
        cartItems.add(product);
        _products[product] += 1;
      } else {
        _products[product] = 1;
      }

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("You have add ${product.name} to cart" ),
            dismissDirection: DismissDirection.horizontal,
            duration: Duration(milliseconds: 600),
            backgroundColor: Colors.blue.shade500,
          )
      );
    }


    // TODO Remove Product From The Dictionary
    void removeProduct(Product product, context){
      if(_products.containsKey(product) && _products[product] == 1){
        _products.removeWhere((key, value) => key == product);
      }else{
        _products[product] --;
      }

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You have removed ${product.name} to cart" ),
            dismissDirection: DismissDirection.horizontal,
            duration: Duration(milliseconds: 600),
            backgroundColor: Colors.blue.shade500,
          )
      );

    }


  }

