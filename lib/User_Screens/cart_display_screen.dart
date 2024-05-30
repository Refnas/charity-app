import 'dart:convert';
import 'package:charity_hope/User_Screens/Payment_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'Craft_display_screen.dart';

class CartData{
  final String id;
  final String name;
  final String image;
  final String price;
  late final String qty;

  CartData({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
  });
}

class cart_display extends StatefulWidget {
  const cart_display({Key? key}) : super(key: key);

  @override
  State<cart_display> createState() => _cart_displayState();
}

class _cart_displayState extends State<cart_display> {

  double totalCartPrice = 0.0;

  @override
  void initState() {
    super.initState();
    totalCartPrice = 0.0;
    calculateTotalPrice();
  }

  void calculateTotalPrice() async {
    List<CartData> cartItems = await cartData();
    double total = 0.0;
    for (var item in cartItems) {
      total += double.parse(item.price) * double.parse(item.qty);
    }
    setState(() {
      totalCartPrice = total;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
        centerTitle: true,
        backgroundColor: HexColor("#FB6D48"),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => craft_display()));
              },
              icon: Icon(Icons.add)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: cartData(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null || snapshot.data == false) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 300),
                    const Text("Cart empty"),
                  ],
                ),
              );
            }
            else {
              return Container(
                padding: EdgeInsets.only(bottom: 80),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) {
                    double price = double.parse(snapshot.data[index].price);
                    double totalPrice = price * double.parse(snapshot.data[index].qty);
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2,color: HexColor("#FB6D48"))
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 25,left: 10),
                            width: 120, // Adjust the width of the image container
                            height: 150, // Adjust the height of the image container
                            child: Image.network(snapshot.data[index].image,fit: BoxFit.fill,),
                          ), // Add space between the image and text
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 12,top: 10),
                                        width: 200,
                                        child: Text(
                                          snapshot.data[index].name,
                                          style: GoogleFonts.acme(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10,top: 10),
                                        height: 30,
                                        width: 30,
                                        child: ElevatedButton(
                                          onPressed: (){
                                            setState(() {
                                              deleteCartItem(snapshot.data[index].id, price * double.parse(snapshot.data[index].qty));
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              shape: CircleBorder(),
                                              padding: EdgeInsets.all(0),
                                              backgroundColor: HexColor("#FB6D48")
                                          ),
                                          child: Icon(Icons.delete_outline_outlined,size: 20,)
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 12,top: 10),
                                    width: 200,
                                    child: Text(
                                      "₹ ${snapshot.data[index].price}",
                                      style: GoogleFonts.domine(fontSize: 18, color: Colors.green,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 12,top: 10,bottom: 5),
                                    width: 230,
                                    child: Text(
                                      "Qty : ${snapshot.data[index].qty}",
                                      overflow: TextOverflow.visible,
                                      style: GoogleFonts.lora(fontSize: 18, color: Colors.blue,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 12,top: 10),
                                    width: 230,
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Total Price : ",
                                          overflow: TextOverflow.visible,
                                          style: GoogleFonts.lora(fontSize: 20, color: Colors.red),
                                        ),
                                        Text(
                                          "₹ $totalPrice",
                                          overflow: TextOverflow.visible,
                                          style: GoogleFonts.lora(fontSize: 20, color: Colors.green,fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: HexColor("#FB6D48"),
        items: [
          BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(top: 15),
                child: Text(
                  "₹ $totalCartPrice",
                  style: GoogleFonts.lora(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
              label: ""
          ),
          BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(top: 15),
                child: TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Payment_User(total_amount: totalCartPrice)));
                  },
                  child: Text(
                    "Buy",
                    style: GoogleFonts.acme(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            label: ""
          )
        ],
      ),
    );
  }

  Future<List<CartData>> cartData() async {
    final response = await http.get(Uri.parse("http://$IP_Address/Charity_Hope/user_view_cart.php?uid=$userId"));
    var responseData = jsonDecode(response.body);
    List<CartData> users = [];
    for (var singleuser in responseData) {
      CartData user = CartData(
        id: singleuser["cart_id"].toString(),
        name: singleuser["name"].toString(),
        image: singleuser["image"].toString(),
        price: singleuser["price"].toString(),
        qty: singleuser["qty"].toString()
      );
      users.add(user);
    }
    return users;
  }


  Future<void> deleteCartItem(String id, double itemTotalPrice) async {
    String URL = "http://$IP_Address/Charity_Hope/cart_delete.php";
    var res = await http.post(Uri.parse(URL), body: {"id": id});
    var response = jsonDecode(res.body);
    if (response["success"] == true) {
      setState(() {
        totalCartPrice -= itemTotalPrice;
      });
      print("success");
    }
  }

}
