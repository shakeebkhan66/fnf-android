import 'package:flutter/material.dart';
import 'package:fnf_project/View/product_list.dart';
import 'dart:convert';
import 'package:http/http.dart';
import '../Utils/shared_preference.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}


class _SignInScreenState extends State<SignInScreen> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  login(String username, password)async{
    try{
      var response = await post(
          Uri.parse('http://192.168.10.7:8844/api/login/'),
          body: {
            "username": username,
            "password": password,
          });
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        // print(data);
        data["username"];
        print(data["name"]);
        print(data["phone_number"]);
        print(data["address"]);
        print(data["token"]);
        print("Login Successfully");
        setState(() => isLoading = true);
        Constants.preferences!.setBool("loggedIn", true);
        Constants.preferences?.setString('Token', data['token']);
        Constants.preferences?.setInt('SubsidyPercentage', data['subsidy_percentage']);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductListScreen(
        )));

      }else{
        print("Failed");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Failed")));
      }
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  // kPrimaryColor = Color(0XFF6A62B7);
  // kBackgroundColor = Color(0XFFE5E5E5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE5E5E5),
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.deepPurple,
        backgroundColor: Colors.blue.shade500,
        title: const Text("Login Screen"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120.0, left: 20),
              child: Text(
                "Here You Can",
                style: TextStyle(
                  color: Colors.blue.shade500,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 20),
              child: Text(
                "Login !",
                style: TextStyle(
                  color: Colors.blue.shade500,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(
              height: 55.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: usernameController,
                validator: (val) {
                  if(val.toString().isEmpty){
                    return "Please Enter Your Name";
                  } else if(val.toString().length < 3){
                    return "Name is too small";
                  } else{
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  hintText: "Enter Your Username",
                  labelText: "Username",
                  prefixIcon: Icon(Icons.email),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                validator: (val) {
                  if(val.toString().isEmpty){
                    return "Please Enter Your Password";
                  } else if(val.toString().length < 4){
                    return "Password is too small";
                  } else{
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  hintText: "Enter Your Password",
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10.0,),
            GestureDetector(
              onTap: (){},
              child: Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 1.0),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.blue.shade500,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            GestureDetector(
              onTap: (){
                if(formKey.currentState!.validate()){
                  // ignore: void_checks
                  return login(
                    usernameController.text.toString(),
                    passwordController.text.toString(),
                  );
                } else{
                  return null;
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade500,
                          Color(0XFF89CFF0),
                        ]
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "LOG IN",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 45.0),
              child: Text(
                "If you don't have account! Register Yourself",
                style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 25.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: RadialGradient(
                      radius: 3.0,
                      colors: [
                        Colors.blue.shade500,
                        // Colors.deepPurple,
                        Colors.black87,
                      ]
                  ),
                ),
                child: const Center(
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}