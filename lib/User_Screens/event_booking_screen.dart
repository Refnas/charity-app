import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'home_screen.dart';

class event_booking extends StatefulWidget {
  const event_booking({Key? key}) : super(key: key);

  @override
  State<event_booking> createState() => _event_bookingState();
}

class _event_bookingState extends State<event_booking> {

  late String period = '';
  final GlobalKey <FormState> formKey = GlobalKey <FormState> ();

  TextEditingController name = TextEditingController();
  TextEditingController chooseDate = TextEditingController();
  var chooseTime;
  TextEditingController description = TextEditingController();

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
                          controller: chooseDate,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.date_range,color: HexColor("#FB6D48"),size: 25,),
                            labelText: "Event Date",
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
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 12),
                                child: Row(
                                  children: [
                                    Icon(
                                        Icons.access_time,
                                      color: HexColor("#FB6D48"),
                                      size: 25,
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      "Choose Time :",
                                      style: TextStyle(color: HexColor("#FB6D48"),fontSize: 20),

                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 120,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.time,
                                        onDateTimeChanged: (DateTime newTime) {
                                          setState(() {
                                            period = newTime.hour < 12 ? 'AM' : 'PM';
                                            chooseTime = "${newTime.hour} : ${newTime.minute} ${period}";
                                          });
                                          print(chooseTime);
                                        },
                                        use24hFormat: true,
                                        minuteInterval: 1,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20,left: 5),
                                      child: Text(
                                        "${period}",
                                        style: TextStyle(color: HexColor("#FB6D48"),fontSize: 20),

                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: description,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person,color: HexColor("#FB6D48"),size: 25,),
                            labelText: "Description",
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
                              return "please fill this field";
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
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirmation"),
                              content: Text(
                                  "Confirmation Event :\nName : ${name.text}\nBooked Date : ${chooseDate.text}\nBooked Time : ${chooseTime}\nDescrption : ${description.text}"
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
                                        foodBooking();
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
                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#FB6D48")
                    ),
                    child: Text("Book Event",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                  )
              ),
            ],
          )
        ),
      ),
    );
  }

  Future foodBooking() async{
    final uri = Uri.parse("http://$IP_Address/Charity_Hope/user_event_registration.php");
    var request = http.MultipartRequest('POST',uri);
    request.fields['name'] = name.text;
    request.fields['event_date'] = chooseDate.text;
    request.fields['event_time'] = chooseTime.toString();
    request.fields['description'] = description.text;
    request.fields['uid'] = userId.toString();
    var response = await request.send();

    print(response);

    if (response.statusCode == 200) {
      name.clear();
      chooseDate.clear();
      description.clear();

      final snackBar = SnackBar(
        content: Text("Event booking success"),
        action: SnackBarAction(
          label: "Ok",
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text("Event booking failed, try again"),
        action: SnackBarAction(
          label: "Ok",
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}
