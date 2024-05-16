import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'cart_display_screen.dart';
import 'craft_details_display_screen.dart';
import 'home_screen.dart';

class craft_display extends StatefulWidget {
  const craft_display({Key? key}) : super(key: key);

  @override
  State<craft_display> createState() => _craft_displayState();
}

class _craft_displayState extends State<craft_display> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crafts"),
        centerTitle: true,
        backgroundColor: HexColor("#FB6D48"),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => cart_display()));
                  },
                  icon: const Icon(Icons.shopping_cart)
              )
          )
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getData(),
          builder: (BuildContext ctx, AsyncSnapshot snapshot) {
            if (snapshot.data == null || snapshot.data == false) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    const Text("Loading..."),
                  ],
                ),
              );
            }
            else {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) {
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
                            margin: EdgeInsets.all(8),
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
                                  Container(
                                    margin: EdgeInsets.only(left: 10,top: 10),
                                    width: 230,
                                    child: Text(
                                      snapshot.data[index].name,
                                      style: GoogleFonts.acme(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10,top: 5),
                                    width: 230,
                                    height: 40,
                                    child: Text(
                                      snapshot.data[index].description,
                                      overflow: TextOverflow.visible,
                                      style: GoogleFonts.lora(fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10,top: 7),
                                    width: 200,
                                    child: Text(
                                      "₹ ${snapshot.data[index].price}",
                                      style: GoogleFonts.domine(fontSize: 18, color: Colors.green,fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 10,top: 10),
                                  width: 220,
                                  height: 35,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => craft_details(craft_data: snapshot.data[index])));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black
                                    ),
                                    child: Text("Buy Now",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                  )
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
    );
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
