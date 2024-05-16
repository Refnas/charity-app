
import 'dart:async';
import 'dart:convert';
import 'package:charity_hope/Login_and_Register/user_login_screen.dart';
import 'package:charity_hope/User_Screens/donate_food.dart';
import 'package:charity_hope/User_Screens/donate_money.dart';
import 'package:charity_hope/User_Screens/my_donations.dart';
import 'package:charity_hope/User_Screens/my_food_bookings.dart';
import 'package:charity_hope/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Craft_display_screen.dart';
import 'cart_display_screen.dart';
import 'craft_details_display_screen.dart';
import 'event_booking_screen.dart';

class Datamodel{
  final String id;
  final String name;
  final String craft_id;
  final String price;
  final String description;
  final String image;

  Datamodel({
    required this.id,
    required this.name,
    required this.craft_id,
    required this.price,
    required this.description,
    required this.image
  });
}

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                        color: HexColor("#65B741")
                    ),
                    child: UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                          color: HexColor("#65B741")
                      ),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: Icon(Icons.person,color: HexColor("#FB6D48"),),
                      ),
                      margin: EdgeInsets.only(top: 0),
                      currentAccountPictureSize: Size.square(40),
                      accountName:Text("$user_name",style: GoogleFonts.acme(color: Colors.white,fontSize: 20),) ,
                      accountEmail: Text("+91 - $user_phone",style: GoogleFonts.merienda(color: Colors.white,fontSize: 18),),
                    )
                ),
                SizedBox(height: 20,),
                ListTile(
                  leading: Icon(Icons.person,color: Colors.black,),
                  title: Text("My profile",style: GoogleFonts.marcellus(fontWeight: FontWeight.w600,color: Colors.black),),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart,color: Colors.black,),
                  title: Text("My Cart",style: GoogleFonts.marcellus(fontWeight: FontWeight.w600,color: Colors.black)),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => cart_display()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.event,color: Colors.black,),
                  title: Text("Events",style: GoogleFonts.marcellus(fontWeight: FontWeight.w600,color: Colors.black)),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.currency_rupee_rounded,color: Colors.black,),
                  title: Text("My Donations",style: GoogleFonts.marcellus(fontWeight: FontWeight.w600,color: Colors.black)),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => my_donations()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.food_bank_outlined,color: Colors.black,),
                  title: Text("My Food Bookings",style: GoogleFonts.marcellus(fontWeight: FontWeight.w600,color: Colors.black)),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => my_food_bookings()));
                  },
                ),
                SizedBox(height: 20,),
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                      color: Colors.black
                  ),
                ),
                SizedBox(height: 20,),
                ListTile(
                  leading: Icon(Icons.call,color: Colors.black),
                  title: Text("Contact for enquiry",style: GoogleFonts.marcellus(fontWeight: FontWeight.w600,color: Colors.black),),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.group,color: Colors.black),
                  title: Text("About Us",style: GoogleFonts.marcellus(fontWeight: FontWeight.w600,color: Colors.black),),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.help_outline,color: Colors.black),
                  title: Text("Help",style: GoogleFonts.marcellus(fontWeight: FontWeight.w600,color: Colors.black),),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout,color: Colors.black),
                  title: Text("Logout",style: GoogleFonts.marcellus(fontWeight: FontWeight.w600,color: Colors.black),),
                  onTap: (){
                    logOut();
                  },
                ),
              ],
            ),
          ),
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                color: HexColor("#FB6D48"),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)
                )
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 40),
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: Icon(Icons.dashboard, size: 30, color: Colors.white),
                            onPressed: () => scaffoldKey.currentState?.openDrawer(),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.notifications, size: 30, color: Colors.white),
                                  onPressed: () {
                                    print(userId);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.logout, size: 30, color: Colors.white),
                                  onPressed: (){
                                    logOut();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10,left: 10,bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: GestureDetector(
                            onTap: (){},
                            child: CircleAvatar(
                              backgroundColor: Colors.yellow,
                              child: Image.asset("assets/user_icon.png",width: 40,),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(),
                              child: Text(
                                "Welcome to Hope",
                                style: GoogleFonts.philosopher(fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text(
                                "Hii, $user_name",
                                style: GoogleFonts.philosopher(fontSize: 20,color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 10),
                    child: Container(
                      height: 50,
                      width: 360,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: TextField(
                        autofocus: false,
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.black),
                          filled: true,
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 6.0,top: 12),
                          prefixIcon: Icon(Icons.search_outlined,color: Colors.black,)
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 20,left: 20,right: 10,bottom: 10),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Need to Help",
                                style: GoogleFonts.acme(fontSize: 23, color: Colors.black, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: 200,
                            width: 180,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 180,
                                  height: 100,
                                  child: Image.asset("assets/donate_banner_img.jpg",fit: BoxFit.fill,),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text(
                                      "Donate for poor kids",
                                    style: GoogleFonts.acme(fontSize: 18, color: Colors.black),
                                  ),
                                ),
                                Container(
                                  width: 160,
                                  height: 50,
                                  padding: EdgeInsets.only(top: 10,left: 15),
                                  child: ElevatedButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => donate_money()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: HexColor("#65B741")
                                    ),
                                    child: Text("Donate",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,left: 20),
                          child: Container(
                            height: 200,
                            width: 180,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black,width: 1)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 180,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Image.asset("assets/need_food.jpg",fit: BoxFit.fill,),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10,left: 10),
                                  child: Text(
                                    "Need Food",
                                    style: GoogleFonts.acme(fontSize: 18, color: Colors.black),
                                  ),
                                ),
                                Container(
                                    width: 160,
                                    height: 50,
                                    padding: EdgeInsets.only(top: 10,left: 15),
                                    child: ElevatedButton(
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => donate_food()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor("#65B741")
                                      ),
                                      child: Text("Donate food",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                    )
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20,left: 20,right: 10),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Buy a craft",
                              style: GoogleFonts.acme(fontSize: 23, color: Colors.black, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => craft_display()));
                              },
                              child: Text("View All",style: TextStyle(color: HexColor("#FB6D48")),)
                          ),
                        )
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: getData(),
                    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      if (snapshot.data == null || snapshot.data == false) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 20),
                              Text("Loading..."),
                            ],
                          ),
                        );
                      }
                      else {
                        return Container(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                width: 150,
                                margin: EdgeInsets.all(10), // Add margin between items
                                decoration: BoxDecoration(
                                  border: Border.all(width: 2,color: HexColor("#FB6D48")),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 150, // Adjust the width of the image container
                                      height: 100, // Adjust the height of the image container
                                      child: Image.network(snapshot.data[index].image,fit: BoxFit.fill,),
                                    ),
                                    SizedBox(height: 10), // Add space between the image and text
                                    Text(
                                        snapshot.data[index].name,
                                      style: GoogleFonts.acme(fontSize: 16, color: Colors.black),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container(
                                          width: 120,
                                          height: 35,
                                          margin: EdgeInsets.only(),
                                          child: OutlinedButton(
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => craft_details(craft_data: snapshot.data[index])));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              side: BorderSide(width: 2, color: HexColor("#65B741")),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                            ),
                                            child: Text("Buy",style: TextStyle(color: HexColor("#65B741")),),
                                          ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 20,left: 20,right: 10),
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Events",
                                style: GoogleFonts.acme(fontSize: 23, color: Colors.black, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Image.asset("assets/Events/event_book_img.gif"),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                                width: 160,
                                height: 50,
                                padding: EdgeInsets.only(top: 10,left: 15),
                                child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => event_booking()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: HexColor("#10439F")
                                  ),
                                  child: Text("Book Event",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                )
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                width: 160,
                                height: 50,
                                padding: EdgeInsets.only(top: 10,left: 15),
                                child: ElevatedButton(
                                  onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: HexColor("#FB6D48")
                                  ),
                                  child: Text("View Event",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]
        ),
      )
    );
  }

  logOut () async{
    final SharedPreferences sharedpreference = await SharedPreferences.getInstance();
    sharedpreference.remove('get-id');
    setState(() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>user_login()));
    });
  }


  Future<List<Datamodel>> getData() async {
    final response = await http.get(Uri.parse("http://$IP_Address/Charity_Hope/admin_craft_display.php"));
    var responseData = jsonDecode(response.body);
    List<Datamodel> users = [];
    for (var singleuser in responseData) {
      Datamodel user = Datamodel(
        id: singleuser["id"].toString(),
        name: singleuser["name"].toString(),
        craft_id: singleuser["craft_id"].toString(),
        price: singleuser["price"].toString(),
        description: singleuser["description"].toString(),
        image: singleuser["image"].toString(),
      );
      users.add(user);
    }
    return users;
  }


}
