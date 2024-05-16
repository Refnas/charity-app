import 'package:charity_hope/Admin_Screens/view_food_donation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class add_food_donation extends StatefulWidget {
  const add_food_donation({Key? key}) : super(key: key);

  @override
  State<add_food_donation> createState() => _add_food_donationState();
}

class _add_food_donationState extends State<add_food_donation> {

  final GlobalKey <FormState> formKey = GlobalKey <FormState> ();

  TextEditingController donor = TextEditingController();
  var food;
  TextEditingController chooseDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Donation"),
        centerTitle: true,
        backgroundColor: HexColor("#FB6D48"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: donor,
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
                          validator: ((value) {
                            if(value!.isEmpty){
                              return "please give your name";
                            }
                          }),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: chooseDate,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.date_range,color: HexColor("#FB6D48"),size: 25,),
                            labelText: "Donating Date",
                            labelStyle: TextStyle(color: HexColor("#FB6D48"),fontSize: 20),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2
                              ),
                            ),
                          ),
                          onTap: () async{
                            DateTime? date = DateTime(1900);
                            FocusScope.of(context).requestFocus(new FocusNode());

                            date = await showDatePicker(
                                context: context,
                                initialDate:DateTime.now(),
                                firstDate:DateTime(1900),
                                lastDate: DateTime(2100)
                            );
                            if (date != null) {
                              chooseDate.text = "${date.day}/${date.month}/${date.year}";
                            }
                            },
                          validator: ((value) {
                            if(value!.isEmpty){
                              return "please choose date";
                            }
                          }),
                        ),
                        SizedBox(height: 15,),
                        DropdownButtonFormField(
                          menuMaxHeight: 300,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.food_bank_outlined,color: HexColor("#FB6D48"),size: 25,),
                            labelStyle: TextStyle(color: HexColor("#FB6D48"),fontSize: 20),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 2
                              ),
                            ),
                          ),
                          hint: Text('Select food',style: TextStyle(color: HexColor("#FB6D48"),fontSize: 20),),
                          items: <String>[
                            'Breakfast',
                            'Dinner',
                            'Drinks, Tea & Snacks',
                            'Lunch',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              food = value;
                              print(food);
                            });
                          },
                          validator: ((value) {
                            if(value!.isEmpty){
                              return "please choose food";
                            }
                          }),
                        ),
                      ],
                    )
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10,bottom: 40),
                  width: 220,
                  height: 60,
                  padding: EdgeInsets.only(top: 10,left: 15),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        foodBooking();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => view_food_donation()),);
                      }
                    },

                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#FB6D48")
                    ),
                    child: Text("Add Donation",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future foodBooking() async{

    final uri = Uri.parse("http://$IP_Address/Charity_Hope/addmin_food_donation_bookings.php");
    var request = http.MultipartRequest('POST',uri);
    request.fields['date'] = chooseDate.text;
    request.fields['donor'] = donor.text;
    request.fields['food'] = food;
    request.fields['uid'] = "Admin";
    var response = await request.send();

    print(response);

    if (response.statusCode == 200) {
      donor.clear();
      chooseDate.clear();

      final snackBar = SnackBar(
        content: Text("Food booking success"),
        action: SnackBarAction(
          label: "Ok",
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text("Food booking failed, try again"),
        action: SnackBarAction(
          label: "Ok",
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}
