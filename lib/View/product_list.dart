import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnf_project/Auth/login_screen.dart';
import 'package:fnf_project/Models/Product.dart';
import 'package:fnf_project/Utils/shared_preference.dart';
import 'package:fnf_project/View/checkout_screen.dart';
import 'package:fnf_project/Controller/product_cart_controller.dart';
import 'package:fnf_project/View/my_drawer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class ProductListScreen extends StatefulWidget {
  ProductListScreen({Key? key}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  
  final CartController cartController = Get.put(CartController());
  var token = Constants.preferences?.getString('Token');



  var data;
  List<Product> productList = [];
  Future<List<Product>> getProductsList() async{
    final response = await http.get(
      Uri.parse('http://192.168.1.19:8000/api/products/'),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'Authorization': 'Token ${token}'
    },
    );
     data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      print("Data Get Successfully");
      for(Map i in data){
        productList.add(Product.fromJson(i));
      }
      return productList;
    }else{
      print("Failed");
      return productList;
    }
  }

  // Prevent From Closing the App Accidentally
  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  Future<bool?> _showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
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
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade500,
          title: const Text(
            "Product List",
            style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen()));
              },
              icon: const Icon(Icons.add_shopping_cart_outlined, color: Colors.white, size: 25,),
            ),
            IconButton(
              onPressed: (){
                Constants.preferences?.setBool("loggedIn", false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
              },
              icon: const Icon(Icons.logout, color: Colors.white, size: 25,),
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: getProductsList(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }else{
                      return ListView.builder(
                        itemCount: productList.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,  vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      productList[index].name.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 100,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        productList[index].price.toString() + " " +"Rs",
                                      ),
                                    ),
                                    const SizedBox(width: 180,),
                                    MaterialButton(
                                      onPressed: (){
                                        cartController.addProduct(productList[index]);
                                      },
                                      color: Colors.blue.shade500,
                                      child: const Text("Add to Cart", style: TextStyle(color: Colors.white),),
                                    )
                                  ],
                                ),
                                const Divider(thickness: 1.2, color: Colors.grey,),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
