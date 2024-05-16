// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
//
// import '../../main.dart';
//
// class Payment_User extends StatefulWidget {
//   final cart_data;
//
//   const Payment_User({this.cart_data});
//
//   @override
//   _Payment_UserState createState() => _Payment_UserState();
// }
//
// class _Payment_UserState extends State<Payment_User> {
//   TextEditingController name = new TextEditingController();
//   TextEditingController bank = new TextEditingController();
//   TextEditingController phone = new TextEditingController();
//   TextEditingController ac_no = new TextEditingController();
//   TextEditingController total_amt = new TextEditingController();
//   TextEditingController uid = new TextEditingController();
//
//   final GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
//
//   late bool status;
//   late String message;
//
//   @override
//   void initState() {
//     name = TextEditingController();
//     bank = TextEditingController();
//     phone = TextEditingController();
//     ac_no = TextEditingController();
//     total_amt = TextEditingController(text: widget.cart_data);
//     uid = new TextEditingController();
//
//     status = false;
//     message = "";
//
//     super.initState();
//   }
//
//   Future<void> submitData() async {
//     var send = await http.post(
//         Uri.parse("http://$ip/MySampleApp/Charity_Hope/payment.php"),
//         body: {
//           "name": name.text,
//           "bank": bank.text,
//           "phone": phone.text,
//           "ac_no": ac_no.text,
//           "total_amt": total_amt.text,
//           "uid":uid_user,
//         });
//
//     if (send.statusCode == 200) {
//       var data = json.decode(send.body);
//       var responseMessage = data["message"];
//       var responseError = data["error"];
//       if (responseError) {
//         setState(() {
//           status = false;
//           message = responseMessage;
//         });
//       } else {
//         name.clear();
//         bank.clear();
//         phone.clear();
//         ac_no.clear();
//         total_amt.clear();
//
//         setState(() {
//           status = true;
//           message = responseMessage;
//         });
//       }
//     } else {
//       setState(() {
//         message = "Error:Server error";
//         status = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           "Payment",
//           style: GoogleFonts.prompt(color: Colors.pink.shade300),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back_rounded, color: Colors.pink.shade300,
//             size: 35, // add custom icons also
//           ),
//         ),
//       ),
//       body: Container(
//         child: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.all(30),
//             child: Form(
//               key: _formkey,
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//                     child: TextFormField(
//                       textCapitalization: TextCapitalization.words,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Name Should not empty!";
//                         }
//
//                         return null;
//                       },
//                       controller: name,
//                       decoration: InputDecoration(
//                         labelText: "Enter your name",
//                         border: new OutlineInputBorder(
//                           borderSide: new BorderSide(color: Colors.teal),
//                         ),
//                       ),
//                       keyboardType: TextInputType.text,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                     child: TextFormField(
//                       controller: bank,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Date Should not empty!";
//                         }
//
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: "Enter bank name",
//                         border: new OutlineInputBorder(
//                           borderSide: new BorderSide(color: Colors.teal),
//                         ),
//                       ),
//                       keyboardType: TextInputType.text,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                     child: TextFormField(
//                       controller: phone,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Phone number Should not empty!";
//                         }
//
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: "Enter your phone number",
//                         border: new OutlineInputBorder(
//                           borderSide: new BorderSide(color: Colors.teal),
//                         ),
//                       ),
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     //  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                     child: TextFormField(
//                       controller: ac_no,
//                       validator: (value) {
//                         if (value!.isEmpty || value!.length > 10) {
//                           return "Please enter  valid account number";
//                         }
//                         if (value.length < 10) {
//                           return "account number should be 10 digit";
//                         }
//                         return null;
//                       },
//                       onSaved: (phone) {},
//                       decoration: InputDecoration(
//                         labelText: "Enter account no",
//                         border: new OutlineInputBorder(
//                           borderSide: new BorderSide(color: Colors.teal),
//                         ),
//                       ),
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     //  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                     child: TextFormField(
//                       controller: total_amt,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Description Should not empty!";
//                         }
//
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         //  labelText: "Enter n",
//                         label: Text("Total amount"),
//                         border: new OutlineInputBorder(
//                           borderSide: new BorderSide(color: Colors.teal),
//                         ),
//                       ),
//                       keyboardType: TextInputType.text,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: StadiumBorder(),
//                       backgroundColor: Colors.blueGrey.shade600,
//                       padding: EdgeInsets.only(
//                           left: 110, right: 110, top: 20, bottom: 20),
//                     ),
//                     onPressed: () {
//                       if (_formkey.currentState!.validate()) {
//                         setState(() {
//                           submitData();
//                         });
//                         showDialog(
//                             context: context,
//                             builder: (_) {
//                               return AlertDialog(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                                 title: Text("Payment",style: TextStyle(color: Colors.pink.shade500),),
//                                 content: Text(
//                                     "your payment of Rs. $access_total_amt successfull"),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.pushReplacement(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   Payment_User()));
//                                     },
//                                     child: Text("ok",style: TextStyle(color: Colors.pink.shade500,)),),
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     child: Text("cancel",style: TextStyle(color: Colors.pink.shade500)),),
//                                 ],
//                               );
//                             });
//                         name.clear();
//                         bank.clear();
//                         phone.clear();
//                         ac_no.clear();
//                         total_amt.clear();
//                       }
//                     },
//                     child: Text('Submit'),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   Text(
//                     status ? message : message,
//                     style: GoogleFonts.adamina(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
