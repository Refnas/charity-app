
import 'dart:io';
import 'package:charity_hope/Admin_Screens/admin_craft_details.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../main.dart';

class update_craft extends StatefulWidget {

  update_craft({required this.craftData});

  final Datamodel craftData;

  @override
  State<update_craft> createState() => _update_craftState();
}

class _update_craftState extends State<update_craft> {

  final GlobalKey <FormState> formKey = GlobalKey <FormState> ();

  var craftImage;
  var recImg;
  final picker = ImagePicker();
  TextEditingController name = TextEditingController();
  TextEditingController craftId = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    name = TextEditingController(text: widget.craftData.name);
    craftId = TextEditingController(text: widget.craftData.craft_id);
    description = TextEditingController(text: widget.craftData.description);
    price = TextEditingController(text: widget.craftData.price);
    recImg = "${widget.craftData.image}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Craft"),
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
                            prefixIcon: Icon(Icons.drive_file_rename_outline,color: HexColor("#FB6D48"),size: 25,),
                            labelText: "Craft Name",
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
                              return "please give craft name";
                            }
                          }),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: craftId,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.numbers,color: HexColor("#FB6D48"),size: 25,),
                            labelText: "Craft Id",
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
                              return "please give craft Id";
                            }
                          }),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: description,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.description,color: HexColor("#FB6D48"),size: 25,),
                            labelText: "Craft Description",
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
                              return "please give craft description";
                            }
                          }),
                        ),
                        SizedBox(height: 15,),
                        TextFormField(
                          controller: price,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.currency_rupee,color: HexColor("#FB6D48"),size: 25,),
                            labelText: "Craft Price",
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
                              return "please give craft Price";
                            }
                          }),
                        ),
                        SizedBox(height: 15,),
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.image,color: HexColor("#FB6D48")),
                                  SizedBox(width: 10,),
                                  Text(
                                    "Craft Image :",
                                    style: TextStyle(color: HexColor("#FB6D48"),fontSize: 20),
                                  ),
                                  SizedBox(width: 10,),
                                  TextButton(
                                      onPressed: (){
                                        setState(() {
                                          craft_image_choose();
                                          craftImage = null;
                                        });
                                      },
                                      child: Text("Choose from device")
                                  )
                                ],
                              ),
                              SizedBox(height: 15,),
                              Container(
                                child: recImg != null && craftImage == null ?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(left: 10,top: 10),
                                        height: 150,
                                        width: 150,
                                        child: Image.network(recImg)
                                    ),
                                  ],
                                ) :
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(left: 10,top: 10),
                                        height: 150,
                                        width: 100,
                                        child: Image.asset(craftImage)
                                    ),
                                  ],
                                )
                              )
                            ],
                          ),
                        )
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
                      print(craftImage);
                      if (formKey.currentState!.validate()) {
                        updateData();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => admin_craft_details()),);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: HexColor("#FB6D48")
                    ),
                    child: Text("Update",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future craft_image_choose() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null)  return;
      final File imageTemporary = File(image.path);
      String fileName = imageTemporary.path;
      setState(() {
        craftImage = fileName;
        recImg = null;
      });
    } catch(error) {
      print("error: $error");
    }
  }

    Future updateData() async{

    final uri = Uri.parse("http://$IP_Address/Charity_Hope/admin_update_craft.php");
    var request = http.MultipartRequest('POST',uri);
    request.fields['id'] = widget.craftData.id;
    request.fields['name'] = name.text;
    request.fields['craft_id'] = craftId.text;
    request.fields['price'] = price.text;
    request.fields['description'] = description.text;
    if(craftImage != null){
      var pic = await http.MultipartFile.fromPath("image", craftImage);
      request.files.add(pic);
    }
    var response = await request.send();

    print(response);

    if (response.statusCode == 200) {
      name.clear();
      craftId.clear();
      description.clear();
      price.clear();

      final snackBar = SnackBar(
        content: Text("Craft updated successfully"),
        action: SnackBarAction(
          label: "Ok",
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text("Craft updating failed, try again"),
        action: SnackBarAction(
          label: "Ok",
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}
