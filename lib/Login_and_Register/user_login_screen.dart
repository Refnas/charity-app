import 'dart:convert';

import 'package:charity_hope/Login_and_Register/admin_login_screen.dart';
import 'package:charity_hope/Login_and_Register/forgot_password.dart';
import 'package:charity_hope/Login_and_Register/user_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:charity_hope/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../User_Screens/home_screen.dart';

class user_login extends StatefulWidget {
  const user_login({Key? key}) : super(key: key);

  @override
  State<user_login> createState() => _user_loginState();
}


class _user_loginState extends State<user_login> {

  late bool _passwordVisible;

  final GlobalKey <FormState> formKey = GlobalKey <FormState> ();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    username = TextEditingController();
    password = TextEditingController();
    _passwordVisible = false;
    super.initState();
  }

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
                          "Hello Welcome,",
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
                                      return "Please enter username";
                                    }
                                  }),
                                ),
                                TextFormField(
                                  controller: password,
                                  obscureText: !_passwordVisible,
                                  decoration: InputDecoration(
                                    label: Text(
                                      "Password",
                                      style: GoogleFonts.merienda(fontSize: 18, color: HexColor("#000000"),fontWeight: FontWeight.w600),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible ?
                                        Icons.visibility :
                                        Icons.visibility_off,
                                        color: HexColor("#7F8C8D"),
                                      ),
                                      onPressed: (){
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                  ),
                                  validator: ((value) {
                                    if(value!.isEmpty){
                                      return "Please enter password";
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
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => forgot_password()));
                            },
                            child: Text(
                                "Forgot Password ?",
                                style: GoogleFonts.merienda(fontSize: 12, color: HexColor("#000000"),fontWeight: FontWeight.w600)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15,right: 15,top: 10),
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
                                backgroundColor: HexColor("#65B741")
                            ),
                            child: Text("Signin",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20,left: 90,),
                        child: Row(
                          children: [
                            Text(
                                "Don't have any account ?",
                                style: GoogleFonts.merienda(fontSize: 13, color: HexColor("#000000"),)
                            ),
                            SizedBox(),
                            TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>user_register()));
                                },
                                child: Text(
                                    "SignUp",
                                    style: GoogleFonts.merienda(fontSize: 13, color: HexColor("#000000"),fontWeight: FontWeight.bold)
                                )
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 150,top: 90),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>admin_login()));
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                child: Image.asset("assets/login_register/admin_icon.png"),
                              ),
                              SizedBox(width: 5,),
                              Text(
                                  "Administrator",
                                  style: GoogleFonts.merienda(fontSize: 15, color: HexColor("#000000"),)
                              )
                            ],
                          ),
                        ),
                      )
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
    var url = Uri.parse("http://$IP_Address/Charity_Hope/hope_user_login.php");
    var response = await http.post(url,headers: {
      'Accept' : "application/Json"
    },
        body: {
          "username" : username.text,
          "password" : password.text
        }
    );
    var data = json.decode(response.body);

    print(data);
    if(data != null){
      for(var singleUser in data){
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString('get-id', singleUser["id"]);
        userId = singleUser["id"];
        setUid();
        user_name= singleUser['username'];
        setName();
        user_phone = singleUser['phone'];
        setPhone();
      }
      final snackBar = await SnackBar(
        content: Text("Login successfull"),
        action: SnackBarAction(
            label: "Ok",
            onPressed: (){}
        ),);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login successfull")));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => home_screen()));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid username or password")));
    }
  }

  setName() async{
    final shadepref = await SharedPreferences.getInstance();
    await shadepref.setString('get-name', user_name);
  }

  setPhone() async{
    final shadepref = await SharedPreferences.getInstance();
    await shadepref.setString('get-phone', user_phone);
  }

  setUid() async{
    final shadepref = await SharedPreferences.getInstance();
    await shadepref.setString('get-uid', userId);
  }

}
