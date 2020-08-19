import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class PatientForm extends StatefulWidget {

  final String hospital;
//  final bool freeVnts;
  PatientForm(
      this.hospital,
//      this.freeVnts
      );

  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {

  String name, status = '', id, address;
  bool wrongStatus = false, enable = true;
//  bool vnts = false;
  final _key = GlobalKey<FormState>();

  Future<void> popUp(){
    return Alert(
      context: context,
      type: AlertType.success,
      title: "Success",
      desc: "Bed has been booked for $name at ${widget.hospital}",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Colors.green, Colors.lime
          ]),
        )
      ],
    ).show();
  }

  Widget primaryButton(newContext) {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.deepOrange,
            child: new Text('BOOK',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed:() async{
              if(enable){
                if(status.isEmpty)
                  setState(() {
                    wrongStatus = true;
                  });
                else
                  setState(() {
                    wrongStatus = false;
                  });
                if(_key.currentState.validate() && !wrongStatus){
                  _key.currentState.save();
                  enable = false;
                  String url = 'https://venbedapi.azurewebsites.net/mobileapi/booking/bookBed';
                  Map<String, String> header = { 'Content-Type' : 'application/json'};
                  Map<String, String> body = { "patientCode": id, "patientName": name, "address": address, "hospital": widget.hospital, "currentStatus": status };
                  var response = await http.post(url, headers: header, body: jsonEncode(body));
                  if(response.statusCode == 200){
                    print('sent');
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString('patientID', id);
                    popUp().then((value){
                      _key.currentState.reset();
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
                    });
                  }
                  else{
                    print('error');
                    Scaffold.of(newContext).showSnackBar(SnackBar(content: Text('Could not book bed. TRY LATER.'), duration: Duration(seconds: 1),));
                    enable = true;
                  }
                }
              }
            },
          ),
        ));
  }

  @override
  void initState() {
    Random rd = Random();
    id = (rd.nextInt(89999)+10000).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var ht = MediaQuery.of(context).size.height;
    var wd = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Patient Registration Form'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Builder(
        builder: (newContext){
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20,30,20,0),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Patient ID', style: TextStyle(fontSize: 20),),
                    SizedBox(height: 5,),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.black45),
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        ),
                      ),
                      child: Text(id, style: TextStyle(fontSize: 20),),
                    ),
                    SizedBox(height: 30,),
                    Text('Patient Name', style: TextStyle(fontSize: 20),),
                    SizedBox(height: 5,),
                    TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
                      onSaved: (value) => name = value,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Text('Patient Address', style: TextStyle(fontSize: 20),),
                    SizedBox(height: 5,),
                    TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      validator: (value) => value.isEmpty ? 'Address can\'t be empty' : null,
                      onSaved: (value) => address = value,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                        labelStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Text('Current Status', style: TextStyle(fontSize: 20),),
                    SizedBox(height: 5,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.0, style: BorderStyle.solid, color: wrongStatus ? Colors.red.shade800 : Colors.black45),
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          underline: null,
                          isExpanded: true,
                          value: status,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 27,
                          elevation: 16,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          onChanged: (String newValue) {
                            setState(() {
                              status = newValue;
                            });
                          },
                          items: ['', 'Mild', 'Moderate', 'Severe']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    wrongStatus ? Padding(
                      padding: const EdgeInsets.only(left: 15, top: 8),
                      child: Text('Status can\'t be empty', style: TextStyle(color: Colors.red.shade800, fontSize: 12)),
                    ) : SizedBox(),
                    SizedBox(height: 10,),
                    primaryButton(newContext),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
