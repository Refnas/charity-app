import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class DataModel{
  final String order_id;
  final String uid;
  final String order_date;
  final String total_amt;

  DataModel({
    required this.order_id,
    required this.uid,
    required this.order_date,
    required this.total_amt
  });
}

class my_orders extends StatefulWidget {
  const my_orders({Key? key}) : super(key: key);

  @override
  State<my_orders> createState() => _my_ordersState();
}

class _my_ordersState extends State<my_orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Donations"),
        centerTitle: true,
        backgroundColor: HexColor("#FB6D48"),
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
                            Text("Order on ",style: TextStyle(fontSize: 18),),
                            Text(
                              snapshot.data[index].order_date,
                              style: GoogleFonts.inter(color:Colors.red,fontSize: 18,fontWeight: FontWeight.w600),
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
                                Text("Order Id : ",style: TextStyle(fontSize: 18),),
                                Text("#",style: TextStyle(color:Colors.black,fontSize: 18)),
                                Text(
                                  snapshot.data[index].order_id,
                                  style: GoogleFonts.acme(fontSize: 22,color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Paid : ",style: TextStyle(fontSize: 18),),
                                Text(
                                  "₹ ${snapshot.data[index].total_amt}",
                                  style: GoogleFonts.acme(fontSize: 18,color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // trailing: TextButton(
                        //   onPressed: ()async{
                        //     showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return AlertDialog(
                        //           title: Text("Cancel"),
                        //           content: Text(
                        //               "Canceling Order :\nOrder Id : #${snapshot.data[index].order_id}\nOrder Date : ${snapshot.data[index].order_date}\nPaid : ${snapshot.data[index].total_amt}"
                        //           ),
                        //           actions: [
                        //             TextButton(
                        //                 onPressed: (){
                        //                   Navigator.pop(context);
                        //                 },
                        //                 child: Text("Back")
                        //             ),
                        //             TextButton(
                        //                 onPressed: (){
                        //                   setState(() {
                        //                     cancelOrder(snapshot.data[index].order_id);
                        //                     Navigator.pop(context);
                        //                   });
                        //                 },
                        //                 child: Text("Proceed")
                        //             ),
                        //           ],
                        //         );
                        //       },
                        //     );
                        //   },
                        //   child: Text(
                        //       "Cancel",
                        //       style: TextStyle(color: HexColor("#FB6D48"),fontSize: 18)
                        //   ),
                        // ),
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
    final response = await http.get(Uri.parse("http://$IP_Address/Charity_Hope/oreder_display.php?uid=$userId"));
    var responseData = jsonDecode(response.body);
    List<DataModel> users = [];
    for (var singleuser in responseData) {
      DataModel user = DataModel(
        order_id: singleuser["order_id"].toString(),
        uid: singleuser["uid"].toString(),
        order_date: singleuser["order_date"].toString(),
        total_amt: singleuser["total_amt"].toString(),
      );
      users.add(user);
    }
    return users;
  }

  Future<void> cancelOrder(String id) async {
    String URL = "http://$IP_Address/Charity_Hope/cancel_order.php";
    try {
      var res = await http.post(Uri.parse(URL), body: {"order_id": id});
      var response = jsonDecode(res.body);
      if (response["error"] == false) {
        print("Order cancellation was successful");
      } else {
        print("Order cancellation failed: ${response['message']}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }



}
