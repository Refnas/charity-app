import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class DataModel{
  final String id;
  final String name;
  final String date;
  final String time;
  final String description;
  final String uid;

  DataModel({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
    required this.description,
    required this.uid,
  });
}

class admin_view_event extends StatefulWidget {
  const admin_view_event({Key? key}) : super(key: key);

  @override
  State<admin_view_event> createState() => _admin_view_eventState();
}

class _admin_view_eventState extends State<admin_view_event> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Donations"),
        centerTitle: true,
        backgroundColor: HexColor("#FB6D48"),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor("#FB6D48"),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => add_food_donation()));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                    const SizedBox(height: 300),
                    const Text("No Donations"),
                  ],
                ),
              );
            }
            else {
              return Container(
                padding: EdgeInsets.only(bottom: 100),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (ctx, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: HexColor("#D2E0FB"),
                      ),
                      child: ListTile(
                        title: Row(
                          children: [
                            Text("Donor : ",style: TextStyle(fontSize: 20),),
                            Text(
                              snapshot.data[index].donor,
                              style: GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Booked date : ",style: TextStyle(fontSize: 18),),
                                Text(
                                  snapshot.data[index].date,
                                  style: GoogleFonts.acme(fontSize: 18,color: Colors.red),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Food : ",style: TextStyle(fontSize: 18),),
                                Text(
                                  snapshot.data[index].food,
                                  style: GoogleFonts.acme(fontSize: 18,color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: TextButton(
                          onPressed: ()async{
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Cancel"),
                                  content: Text(
                                      "Canceling food donation :\nDonor : ${snapshot.data[index].donor}\nBooked Date : ${snapshot.data[index].date}\nFood : ${snapshot.data[index].food}"
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Text("Back")
                                    ),
                                    TextButton(
                                        onPressed: (){
                                          setState(() {
                                            cancelDonation(snapshot.data[index].id);
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text("Proceed")
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                              "Cancel",
                              style: TextStyle(color: HexColor("#FB6D48"),fontSize: 16)
                          ),
                        ),
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

  Future<List<DataModel>> getData() async {
    final response = await http.get(Uri.parse("http://$IP_Address/Charity_Hope/admin_food_donation_display.php"));
    var responseData = jsonDecode(response.body);
    List<DataModel> users = [];
    for (var singleuser in responseData) {
      DataModel user = DataModel(
        id: singleuser["id"].toString(),
        name: singleuser["donor"].toString(),
        date: singleuser["date"].toString(),
        time: singleuser["time"],
        description: singleuser["food"].toString(),
        uid: singleuser["uid"].toString(),
      );
      users.add(user);
    }
    return users;
  }

  Future <void> cancelDonation(String id) async{
    String URL = "http://$IP_Address/Charity_Hope/admin_cancel_food_bookings.php";
    var res = await http.post(Uri.parse(URL),body: {"id":id});
    var response = jsonDecode(res.body);
    if(response["success"]==true){
      print("success");
    }
  }
}
