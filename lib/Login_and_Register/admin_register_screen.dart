import 'package:charity_hope/Login_and_Register/admin_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class admin_register extends StatefulWidget {
  const admin_register({Key? key}) : super(key: key);

  @override
  State<admin_register> createState() => _admin_registerState();
}

class _admin_registerState extends State<admin_register> {

  final GlobalKey <FormState> formKey = GlobalKey <FormState> ();

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
                          style: GoogleFonts.eduNswActFoundation(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 35,),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Admin Register",
                          style: GoogleFonts.eduNswActFoundation(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
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
                        padding: EdgeInsets.only(top: 80, left: 15, right: 15),
                        child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: Text(
                                      "Username",
                                      style: GoogleFonts.merienda(fontSize: 18, color: HexColor("#000000"),fontWeight: FontWeight.w600),
                                    ),
                                    suffixIcon: Icon(Icons.person,color: HexColor("#7F8C8D"),),
                                  ),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: Text(
                                      "Email",
                                      style: GoogleFonts.merienda(fontSize: 18, color: HexColor("#000000"),fontWeight: FontWeight.w600),
                                    ),
                                    suffixIcon: Icon(Icons.email_outlined,color: HexColor("#7F8C8D"),),
                                  ),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: Text(
                                      "Mobile",
                                      style: GoogleFonts.merienda(fontSize: 18, color: HexColor("#000000"),fontWeight: FontWeight.w600),
                                    ),
                                    suffixIcon: Icon(Icons.phone_android_outlined,color: HexColor("#7F8C8D"),),
                                  ),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    label: Text(
                                      "Password",
                                      style: GoogleFonts.merienda(fontSize: 18, color: HexColor("#000000"),fontWeight: FontWeight.w600),
                                    ),
                                    suffixIcon: Icon(Icons.visibility_off,color: HexColor("#7F8C8D"),),
                                  ),
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
                        padding: EdgeInsets.only(left: 15,right: 15,top: 10),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: HexColor("#65B741"),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent
                            ),
                            child: Text("Signup",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20,left: 90,),
                        child: Row(
                          children: [
                            Text(
                                "Already a admin ?",
                                style: GoogleFonts.merienda(fontSize: 13, color: HexColor("#000000"))
                            ),
                            SizedBox(),
                            TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>admin_login()));
                                },
                                child: Text(
                                    "SignIn",
                                    style: GoogleFonts.merienda(fontSize: 13, color: HexColor("#000000"),fontWeight: FontWeight.bold)
                                )
                            )
                          ],
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
}
