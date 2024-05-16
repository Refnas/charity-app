import 'package:charity_hope/Login_and_Register/user_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class user_register extends StatefulWidget {
  const user_register({Key? key}) : super(key: key);

  @override
  State<user_register> createState() => _user_registerState();
}

class _user_registerState extends State<user_register> {

  final GlobalKey <FormState> formKey = GlobalKey <FormState> ();

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    username = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();
    password = TextEditingController();
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
                  gradient: LinearGradient(
                      colors: [
                        HexColor("#000000"),
                        HexColor("#7F8C8D"),
                      ]
                  )
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
                          "SignUp",
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
                                controller: email,
                                decoration: InputDecoration(
                                  label: Text(
                                    "Email",
                                    style: GoogleFonts.merienda(fontSize: 18, color: HexColor("#000000"),fontWeight: FontWeight.w600),
                                  ),
                                  suffixIcon: Icon(Icons.email_outlined,color: HexColor("#7F8C8D"),),
                                ),
                                validator: ((value) {
                                  if(value!.isEmpty){
                                    return "Please enter email";
                                  }
                                }),
                              ),
                              TextFormField(
                                controller: phone,
                                decoration: InputDecoration(
                                  label: Text(
                                    "Mobile",
                                    style: GoogleFonts.merienda(fontSize: 18, color: HexColor("#000000"),fontWeight: FontWeight.w600),
                                  ),
                                  suffixIcon: Icon(Icons.phone_android_outlined,color: HexColor("#7F8C8D"),),
                                ),
                                validator: ((value) {
                                  if(value!.isEmpty){
                                    return "Please enter mobile number";
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
                            gradient: LinearGradient(
                                colors: [
                                  HexColor("#000000"),
                                  HexColor("#7F8C8D"),
                                ]
                            ),
                          borderRadius: BorderRadius.circular(5)
                        ),
                        child: ElevatedButton(
                          onPressed: () async{
                            register();
                          },
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
                                "Already have an account ?",
                                style: GoogleFonts.merienda(fontSize: 13, color: HexColor("#000000"),)
                            ),
                            SizedBox(),
                            TextButton(
                                onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>user_login()));
                                },
                                child: Text(
                                    "SignIn",
                                    style: GoogleFonts.merienda(fontSize: 13, color: Colors.black,fontWeight: FontWeight.bold)
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

  Future register() async{

    final uri = Uri.parse("http://$IP_Address/Charity_Hope/hope_user_registration.php");
    var request = http.MultipartRequest('POST',uri);
    request.fields['username'] = username.text;
    request.fields['email'] = email.text;
    request.fields['phone'] = phone.text;
    request.fields['password'] = password.text;
    var response = await request.send();
    print(response);
    if(response.statusCode == 200){
      username.clear();
      email.clear();
      phone.clear();
      password.clear();

      final snackBar = await SnackBar(
        content: Text("Registered successfully"),
        action: SnackBarAction(
            label: "Ok",
            onPressed: (){}
        ),);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registered successfully")));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration failed")));
    }
  }

}
