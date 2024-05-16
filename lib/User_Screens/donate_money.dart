import 'package:charity_hope/User_Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

class donate_money extends StatefulWidget {
  const donate_money({Key? key}) : super(key: key);

  @override
  State<donate_money> createState() => _donate_moneyState();
}

class _donate_moneyState extends State<donate_money> {

  final GlobalKey <FormState> formKey = GlobalKey <FormState> ();

  TextEditingController name = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController phone = TextEditingController();
  var bank;
  TextEditingController account = TextEditingController();
  TextEditingController amount = TextEditingController();

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
                          validator: ((value) {
                            if(value!.isEmpty){
                              return "please give your name";
                            }
                          }),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: phone,
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
                          validator: ((value) {
                            if(value!.isEmpty){
                              return "please enter phone number";
                            }
                          }),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: place,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on,color: HexColor("#FB6D48"),size: 25,),
                            labelText: "Place",
                            hintText: "City, State",
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
                              return "please enter your place";
                            }
                          }),
                        ),
                        SizedBox(height: 15,),
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
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: account,
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
                          validator: ((value) {
                            if(value!.isEmpty){
                              return "please enter account number";
                            }
                          }),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: amount,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.currency_rupee,color: HexColor("#FB6D48"),size: 25,),
                            labelText: "Amount",
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
                          validator: ((value) {
                            if(value!.isEmpty){
                              return "please enter amount";
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
                        addDonation();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home_screen()),);
                      }
                    },

                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#FB6D48")
                    ),
                    child: Text("Add Donation",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                  )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 3,left: 15),
                          width: 100,
                          height: 50,
                          child: SvgPicture.asset("assets/Razorpay_logo.svg"),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 3),
                          width: 100,
                          height: 50,
                          child: SvgPicture.asset("assets/PhonePe-Logo.svg"),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 3),
                          width: 80,
                          height: 50,
                          child: SvgPicture.asset("assets/paytm.svg"),
                        ),
                        Container(
                          width: 100,
                          height: 50,
                          child: SvgPicture.asset("assets/visa.svg"),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 3,left: 15),
                          width: 100,
                          height: 50,
                          child: SvgPicture.asset("assets/bhim.svg"),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 3),
                          width: 80,
                          height: 50,
                          child: SvgPicture.asset("assets/upi.svg"),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 3),
                          width: 80,
                          height: 50,
                          child: SvgPicture.asset("assets/google-pay.svg"),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 3),
                          width: 80,
                          height: 50,
                          child: SvgPicture.asset("assets/mastercard.svg"),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future addDonation() async{

    final uri = Uri.parse("http://$IP_Address/Charity_Hope/user_money_donation.php");
    var request = http.MultipartRequest('POST',uri);
    request.fields['name'] = name.text;
    request.fields['place'] = place.text;
    request.fields['phone'] = phone.text;
    request.fields['amount'] = amount.text;
    request.fields['bank'] = bank.toString();
    request.fields['account'] = account.text;
    request.fields['uid'] = userId.toString();
    var response = await request.send();
    print(response);
    if(response.statusCode == 200){
      name.clear();
      phone.clear();
      place.clear();
      account.clear();
      amount.clear();

      final snackBar = await SnackBar(
        content: Text("Donation added successfully"),
        action: SnackBarAction(
            label: "Ok",
            onPressed: (){}
        ),);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Donation added successfully")));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Donation failed try again")));
    }
  }

}
