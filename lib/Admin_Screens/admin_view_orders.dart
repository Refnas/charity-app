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
    required this.total_amt,
  });
}

class admin_view_orders extends StatefulWidget {
  const admin_view_orders({Key? key}) : super(key: key);

  @override
  State<admin_view_orders> createState() => _admin_view_ordersState();
}

class _admin_view_ordersState extends State<admin_view_orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
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
                    const Text("No Events"),
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
                            Text("Order Id : ",style: TextStyle(fontSize: 20),),
                            Text(
                              "#${snapshot.data[index].order_id}",
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
                                Text("Uid : ",style: TextStyle(fontSize: 18),),
                                Text(
                                  snapshot.data[index].uid,
                                  style: GoogleFonts.acme(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Ordered date : ",style: TextStyle(fontSize: 18),),
                                Text(
                                  snapshot.data[index].order_date,
                                  style: GoogleFonts.acme(fontSize: 18,color: Colors.red),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Paided : ",style: TextStyle(fontSize: 18),),
                                Text(
                                  snapshot.data[index].total_amt,
                                  style: GoogleFonts.acme(fontSize: 18,color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
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
    final response = await http.get(Uri.parse("http://$IP_Address/Charity_Hope/admin_view_orders.php"));
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

}
