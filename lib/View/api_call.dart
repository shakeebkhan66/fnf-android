import 'package:fnf_project/Models/Product.dart';
import 'package:fnf_project/Utils/shared_preference.dart';
import 'package:http/http.dart' as http;


class RemoteServices{

  var token = Constants.preferences?.getString('Token');

  static var client = http.Client();
  static Future<Product?> fetchProducts() async{
    var response = await client.get(
        Uri.parse(
            "http://192.168.10.3:8844/api/products/",
        ),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
        'Authorization': 'Token token'
      },
    );
    if(response.statusCode==200){
      var jsonString = response.body;
      return Product.fromJson(jsonString);
    }else{
      return null;
    }
  }
}