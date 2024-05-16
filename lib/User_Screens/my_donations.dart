import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class DataModel{
  final String id;
  final String name;
  final String place;
  final String phone;
  final String amount;
  final String bank;
  final String account;
  final String uid;

  DataModel({
    required this.id,
    required this.name,
    required this.place,
    required this.phone,
    required this.amount,
    required this.bank,
    required this.account,
    required this.uid
  });
}

class my_donations extends StatefulWidget {
  const my_donations({Key? key}) : super(key: key);

  @override
  State<my_donations> createState() => _my_donationsState();
}

class _my_donationsState extends State<my_donations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Money Donations"),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.person,color: HexColor("#41B06E"),size: 30,),
                                ),
                                Container(
                                  child: Text(
                                    snapshot.data[index].name,
                                    style: GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.place,color: HexColor("#41B06E"),size: 30,),
                                ),
                                Container(
                                  child: Text(
                                    snapshot.data[index].place,
                                    style: GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.person,color: HexColor("#41B06E"),size: 30,),
                                ),
                                Container(
                                  child: Text(
                                    "+91 ${snapshot.data[index].phone}",
                                    style: GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.currency_rupee,color: HexColor("#41B06E"),size: 30,),
                                ),
                                Container(
                                  child: Text(
                                    snapshot.data[index].amount,
                                    style: GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.account_balance,color: HexColor("#41B06E"),size: 25,),
                                ),
                                Container(
                                  child: Text(
                                    "Bank : ${snapshot.data[index].bank}",
                                    style: GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 35),
                                  child: Row(
                                    children: [
                                      Text(
                                        "A/C No : ",
                                        style: GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        snapshot.data[index].account,
                                        style: GoogleFonts.inter(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.red),
                                      )
                                    ],
                                  ),
                                )
                              ],
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
      ),
    );
  }

  Future<List<DataModel>> getData() async {
    final response = await http.get(Uri.parse("http://$IP_Address/Charity_Hope/user_display_money_donation.php?uid=$userId"));
    var responseData = jsonDecode(response.body);
    List<DataModel> users = [];
    for (var singleuser in responseData) {
      DataModel user = DataModel(
          id: singleuser["id"].toString(),
          name: singleuser["name"].toString(),
          place: singleuser["place"].toString(),
          phone: singleuser["phone"].toString(),
          amount: singleuser["amount"].toString(),
          bank: singleuser["bank"].toString(),
          account: singleuser["account"].toString(),
          uid: singleuser["uid"].toString()
      );
      users.add(user);
    }
    return users;
  }


}
