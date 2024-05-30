import 'dart:convert';

import 'package:charity_hope/User_Screens/Craft_display_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'cart_display_screen.dart';

class direct_payment extends StatefulWidget {
  final double total_amount;
  final String qty;
  final String craftId;

  const direct_payment({
    required this.total_amount,
    required this.qty,
    required this.craftId
  });

  @override
  State<direct_payment> createState() => _direct_paymentState();
}

class _direct_paymentState extends State<direct_payment> {

  TextEditingController name = new TextEditingController();
  var bank;
  TextEditingController phone = new TextEditingController();
  TextEditingController ac_no = new TextEditingController();
  TextEditingController total_amt = new TextEditingController();
  TextEditingController uid = new TextEditingController();

  final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();

  late bool status;
  late String message;

  @override
  void initState() {
    name = TextEditingController();
    phone = TextEditingController();
    ac_no = TextEditingController();
    total_amt = TextEditingController(text: "${widget.total_amount}");
    uid = new TextEditingController();

    status = false;
    message = "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        centerTitle: true,
        backgroundColor: HexColor("#FB6D48"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name Should not empty!";
                        }
                        return null;
                      },
                      controller: name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: HexColor("#FB6D48"),size: 25,),
                        labelText: "Name",
                        labelStyle: TextStyle(color: HexColor("#FB6D48"),fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Colors.green,
                              width: 2
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  DropdownButtonFormField(
                    menuMaxHeight: 300,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_balance,color: HexColor("#FB6D48"),size: 25,),
                      labelStyle: TextStyle(color: HexColor("#FB6D48"),fontSize: 20),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2
                        ),
                      ),
                    ),
                    hint: Text('Choose bank',style: TextStyle(color: HexColor("#FB6D48"),fontSize: 20),),
                    items: <String>[
                      'Axis Bank',
                      'Bank of Baroda',
                      'Canara Bank',
                      'Fedaral Bank',
                      'HDFC Bank',
                      'ICICI Bank',
                      'IDBI Bank',
                      'Indian Bank',
                      'Induslnd Bank',
                      'Kerala Gramin Bank',
                      'Kerala One Bank',
                      'Kotak Mahindra Bank',
                      'Punjab National Bank',
                      'South Indian Bank',
                      'State Bank of India',
                      'Union Bank of India',
                      'Yes Bank'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        bank = value;
                        print(bank);
                      });
                    },
                    validator: ((value) {
                      if(value!.isEmpty){
                        return "please choose bank";
                      }
                    }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: TextFormField(
                      controller: phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone number Should not empty!";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android_sharp,color: HexColor("#FB6D48"),size: 25,),
                        labelText: "Mobile",
                        labelStyle: TextStyle(color: HexColor("#FB6D48"),fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Colors.green,
                              width: 2
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    //  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: TextFormField(
                      controller: ac_no,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter  valid account number";
                        }
                        return null;
                      },
                      onSaved: (phone) {},
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.book,color: HexColor("#FB6D48"),size: 25,),
                        labelText: "Account Number",
                        labelStyle: TextStyle(color: HexColor("#FB6D48"),fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Colors.green,
                              width: 2
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    //  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: TextFormField(
                      controller: total_amt,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Description Should not empty!";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.currency_rupee,color: HexColor("#FB6D48"),size: 25,),
                        labelText: "Total Amount",
                        labelStyle: TextStyle(color: HexColor("#FB6D48"),fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                              color: Colors.green,
                              width: 2
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10,bottom: 40),
                    width: 220,
                    height: 60,
                    padding: EdgeInsets.only(top: 10,left: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("#FB6D48")
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            submitData();
                          });
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: Text("Payment",style: TextStyle(color: HexColor("#FB6D48")),),
                                  content: Text(
                                      "your payment of Rs. ${widget.total_amount} successfull"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    craft_display()));
                                      },
                                      child: Text("ok",style: TextStyle(color: HexColor("#FB6D48"))),),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("cancel",style: TextStyle(color: HexColor("#FB6D48"))),),
                                  ],
                                );
                              });
                          name.clear();
                          phone.clear();
                          ac_no.clear();
                          total_amt.clear();
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    status ? message : message,
                    style: GoogleFonts.adamina(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitData() async {
    var send = await http.post(
        Uri.parse("http://$IP_Address/Charity_Hope/direct_payment.php"),
        body: {
          "name": name.text,
          "phone": phone.text,
          "bank": bank.toString(),
          "ac_no": ac_no.text,
          "total_amt": total_amt.text,
          "uid":userId,
          "craft_id": widget.craftId.toString(),
          "qty": widget.qty.toString()
        });

    if (send.statusCode == 200) {
      var data = json.decode(send.body);
      var responseMessage = data["message"];
      var responseError = data["error"];
      if (responseError) {
        setState(() {
          status = false;
          message = responseMessage;
        });
      } else {
        name.clear();
        phone.clear();
        ac_no.clear();
        total_amt.clear();

        setState(() {
          status = true;
          message = responseMessage;
        });
      }
    } else {
      setState(() {
        message = "Error:Server error";
        status = false;
      });
    }
  }

}
