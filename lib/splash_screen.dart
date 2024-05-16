import 'dart:async';
import 'package:charity_hope/Login_and_Register/user_login_screen.dart';
import 'package:charity_hope/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'User_Screens/home_screen.dart';

var session_key;

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {

  @override
  void initState() {
    // TODO: implement initState
    getValidationData();
    getName();
    getPhone();
    getUid();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: HexColor("#FBF6EE")
        ),
        child: Stack(
          children: [
            Positioned(
                child: Container(
                  width: 450,
                  height: 500,
                  child: Image.asset("assets/splash.png"),
                )
            ),
            Positioned(
              top: 180,
                left: 110,
                child: Container(
                    height: 150,
                    width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(width: 2,color: Colors.purple)
                  ),
                  child: Image.asset("assets/charity_splash.jpg",fit: BoxFit.fill,)
                )
            ),
            Positioned(
              top: 450,
                left: 20,
                child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                        "We rise by\nlifting others",
                      style: GoogleFonts.patuaOne(fontSize: 40,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "You have two hands, One to help your self, the\nsecond to help others.",
                      style: GoogleFonts.cardo(fontSize: 20),
                    ),
                  ),
                ],
                ),
              )
            ),
            Positioned(
              top: 680,
                left: 20,
                child: Container(
                  child: Stack(
                    children: [
                      Container(
                        height: 40,
                          width: 370,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.black,
                            color: HexColor("#FBF6EE"),
                          )
                      ),
                      Positioned(
                        left: 150,
                          top: 7,
                          child: Text("Loading",style: GoogleFonts.merienda(fontSize: 20,fontWeight: FontWeight.bold,color: HexColor("#FBF6EE")))
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

  Future getValidationData() async{
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    var obtainedId = await sharedPrefs.getString('get-id');
    setState(() {
      session_key = obtainedId;
    });
    Timer(
        Duration(seconds: 5),
            () {
          session_key == null ?
          Navigator.push(context, MaterialPageRoute(builder: (context) => user_login())) :
          Navigator.push(context, MaterialPageRoute(builder: (context) => home_screen()));
        }
    );
    print("this is sessionvalue $session_key");
  }

  getName() async{
    final SharedPreferences shadepref = await SharedPreferences.getInstance();
    var obtainedName = await shadepref.getString('get-name');
    setState(() {
      user_name = obtainedName;
    });
  }

  getPhone() async{
    final SharedPreferences shadepref = await SharedPreferences.getInstance();
    var obtainedPhone = await shadepref.getString('get-phone');
    setState(() {
      user_phone = obtainedPhone;
    });
  }

  getUid() async{
    final SharedPreferences shadepref = await SharedPreferences.getInstance();
    var obtainedUserId = await shadepref.getString('get-uid');
    setState(() {
      userId = obtainedUserId;
    });
  }

}
