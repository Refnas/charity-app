import 'dart:convert';

import 'package:charity_hope/Admin_Screens/Update_craft.dart';
import 'package:charity_hope/Admin_Screens/add_craft.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

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

class admin_craft_details extends StatefulWidget {
  const admin_craft_details({Key? key}) : super(key: key);

  @override
  State<admin_craft_details> createState() => _admin_craft_detailsState();
}

class _admin_craft_detailsState extends State<admin_craft_details> {

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => add_craft()));
                  },
                  icon: const Icon(Icons.add_circle_outline)
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
                padding: EdgeInsets.only(bottom: 80),
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
                              Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 10,top: 10),
                                      width: 110,
                                      height: 35,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          setState(() {
                                            removeCraft(snapshot.data[index].id);
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red
                                        ),
                                        child: Text("Remove",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                      )
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 10,top: 10),
                                      width: 110,
                                      height: 35,
                                      child: ElevatedButton(
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => update_craft(craftData: snapshot.data[index])));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black
                                        ),
                                        child: Text("Update",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                                      )
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

  Future <void> removeCraft(String id) async{
    String URL = "http://$IP_Address/Charity_Hope/admin_delete_craft.php";
    var res = await http.post(Uri.parse(URL),body: {"id":id});
    var response = jsonDecode(res.body);
    if(response["success"]==true){
      print("success");
    }
  }

}
