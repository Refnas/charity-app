import 'dart:convert';

import 'package:charity_hope/Admin_Screens/admin_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class admin_login extends StatefulWidget {
  const admin_login({Key? key}) : super(key: key);

  @override
  State<admin_login> createState() => _admin_loginState();
}

class _admin_loginState extends State<admin_login> {

  final GlobalKey <FormState> formKey = GlobalKey <FormState> ();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: HexColor("#FB6D48")
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 70,left: 20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Admin Panel,",
                          style: GoogleFonts.ebGaramond(fontSize: 25, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 35,),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "SignIn",
                          style: GoogleFonts.ebGaramond(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Container(
                  height: MediaQuery.of(context).size.height * .742,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)
                      ),
                      color: Colors.white
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 120, left: 15, right: 15),
                        child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: username,
                                  decoration: InputDecoration(
                                    label: Text(
                                      "Username",
                                      style: GoogleFonts.merienda(fontSize: 18, color: HexColor("#000000"),fontWeight: FontWeight.w600),
                                    ),
                                    suffixIcon: Icon(Icons.person,color: HexColor("#7F8C8D"),),
                                  ),
                                  validator: ((value) {
                                    if(value!.isEmpty){
                                      return "please enter username";
                                    }
                                  }),
                                ),
                                TextFormField(
                                  controller: password,
                                  decoration: InputDecoration(
                                    label: Text(
                                      "Password",
                                      style: GoogleFonts.merienda(fontSize: 18, color: HexColor("#000000"),fontWeight: FontWeight.w600),
                                    ),
                                    suffixIcon: Icon(Icons.visibility_off,color: HexColor("#7F8C8D"),),
                                  ),
                                  validator: ((value) {
                                    if(value!.isEmpty){
                                      return "please enter password";
                                    }
                                  }),
                                ),
                              ],
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,right: 10),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: (){},
                            child: Text(
                                "Forgot Password ?",
                                style: GoogleFonts.merienda(fontSize: 12, color: HexColor("#000000"),fontWeight: FontWeight.w600)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15,right: 15,top: 20),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: HexColor("#65B741"),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: ElevatedButton(
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                setState(() {
                                  logIn();
                                  username.clear();
                                  password.clear();
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent
                            ),
                            child: Text("Signin",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  Future logIn() async{
    var url = Uri.parse("http://$IP_Address/Charity_Hope/hope_admin_login.php");
    var response = await http.post(
      url,
      headers: {
        'Accept' : "application/Json"
      },
      body: {
        "username" : username.text,
        "password" : password.text
      }
    );

    var data = jsonDecode(response.body);

    if(data != null){
      final snackBar = await SnackBar(
        content: Text("Login successfull"),
        action: SnackBarAction(
            label: "Ok",
            onPressed: (){}
        ),);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login successfull")));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => admin_home()));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid username or password")));
    }
  }

}

