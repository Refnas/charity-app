
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import 'cart_display_screen.dart';
import 'home_screen.dart';


class craft_details extends StatefulWidget {
  // const craft_details({Key? key}) : super(key: key);

  craft_details({required this.craft_data});

  final Datamodel craft_data;

  @override
  State<craft_details> createState() => _craft_detailsState();

}

class _craft_detailsState extends State<craft_details> {

  int qty = 1;

  @override
  void initState() {
    qty = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double totalPrice = double.parse(widget.craft_data.price) * qty;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.craft_data.name),
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(5),
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.craft_data.image,fit: BoxFit.contain,),
            ),
            Container(
              padding: EdgeInsets.only(top: 10,right: 10),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 20,left: 20,bottom: 10),
                      child: Text(
                        "₹ ${totalPrice}",
                        style: GoogleFonts.acme(fontSize: 30, color: Colors.green,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          child: ElevatedButton(
                            onPressed: (){
                              qtyDecreraseBtn();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(10),
                              backgroundColor: Colors.black
                            ),
                            child: Text("-",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          child: Text(
                            "$qty",
                            style: GoogleFonts.domine(fontSize: 20,fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                            onPressed: (){
                              qtyIncreaseBtn();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(10),
                                backgroundColor: Colors.black
                            ),
                            child: Text("+",style: TextStyle(fontSize: 15),),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      widget.craft_data.description,
                      style: GoogleFonts.lora(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(height: 20,width: 20,child: Image.asset("assets/label.png",color: Colors.blue,),),
                        SizedBox(width: 5,),
                        Text(
                          "10 % offer on credit cards",
                          style: GoogleFonts.josefinSlab(fontSize: 20, color: Colors.blue,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              // padding: EdgeInsets.all(),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: OutlinedButton(
                      onPressed: (){
                      },
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 2, color: HexColor("#FB6D48")),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text("BUY",style: TextStyle(color: HexColor("#FB6D48")),),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.add_shopping_cart,color: Colors.black,),
                      label: Text("ADD TO CART",style: TextStyle(color: Colors.black),),
                      onPressed: (){
                        add_to_cart();
                      },
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 2, color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future add_to_cart() async{

    final uri = Uri.parse("http://$IP_Address/Charity_Hope/user_add_to_cart.php");
    var request = http.MultipartRequest('POST',uri);
    request.fields['craft_id'] = widget.craft_data.craft_id;
    request.fields['uid'] = userId;
    request.fields['qty'] = qty.toString();
    var response = await request.send();
    print(response);
    if(response.statusCode == 200){
      final snackBar = await SnackBar(
        content: Text("Registered successfully"),
        action: SnackBarAction(
            label: "Ok",
            onPressed: (){}
        ),);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to cart")));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("item not added")));
    }
  }

  qtyIncreaseBtn() {
    if(qty < 20) {
      setState(() {
        qty += 1;
      });
    }
  }


  qtyDecreraseBtn(){
    if(qty > 1){
      setState(() {
        qty -= 1;
      });
    }
  }

}
