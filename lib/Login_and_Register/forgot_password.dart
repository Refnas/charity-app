import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class DataModel {
  final String password;

  DataModel({required this.password});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      password: json['password'].toString(),
    );
  }
}


class forgot_password extends StatefulWidget {
  const forgot_password({Key? key}) : super(key: key);

  @override
  State<forgot_password> createState() => _forgot_passwordState();
}

class _forgot_passwordState extends State<forgot_password> {

  final GlobalKey <FormState> formKey = GlobalKey <FormState> ();

  TextEditingController email = TextEditingController();

  String retrievedPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
        backgroundColor: HexColor("#FB6D48"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.height))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 150,left: 15,right: 15),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined,color: HexColor("#FB6D48"),size: 25,),
                            labelText: "Enter Your Email",
                            labelStyle: TextStyle(color: HexColor("#FB6D48"),fontSize: 20),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2
                              ),
                            ),
                          ),
                          validator: ((value) {
                            if(value!.isEmpty){
                              return "please give your email";
                            }
                          }),
                        ),
                      ],
                    )
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 50,bottom: 40),
                  width: 220,
                  height: 60,
                  padding: EdgeInsets.only(top: 10,left: 15),
                  child: ElevatedButton(
                    onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      List<DataModel> data = await getData(email.text);
                      if (data.isNotEmpty) {
                        setState(() {
                          retrievedPassword = data[0].password;
                        });
                      }
                    }
                  },

                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#FB6D48")
                    ),
                    child: Text("Submit",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                  )
              ),
              Container(
                height: 100,
                width: 300,
                margin: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Text(
                  retrievedPassword.isEmpty ? "" : "Password: $retrievedPassword",
                  style: GoogleFonts.josefinSans(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<DataModel>> getData(data) async {
    final response = await http.post(Uri.parse("http://$IP_Address/Charity_Hope/forgott_password.php?email=$data"));
    var responseData = jsonDecode(response.body);
    List<DataModel> users = [];
    for (var singleuser in responseData) {
      DataModel user = DataModel(
        password: singleuser["password"].toString(),
      );
      users.add(user);
    }
    return users;
  }

}


