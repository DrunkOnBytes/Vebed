import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyBooking extends StatefulWidget {
  @override
  _MyBookingState createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  String name, id, hospital, address, status, bed, vnts, treatment;
  bool _isLoading = true, noData = false;
  bool enable = true;

  Future<void> popUp(){
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "Cancel Booking",
      desc: "Are you sure you want to cancel booking?",
      buttons: [
        DialogButton(
          child: Text(
            "YES",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async{
            if(enable){
              enable = false;
              String url = 'https://venbedapi.azurewebsites.net/mobileapi/booking/withDraw?patientCode=$id';
              var response = await http.post(url, headers: <String, String>{'Content-Type': 'application/json',});
              if(response.statusCode==200){
                print('cancelled '+response.statusCode.toString());
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('patientID');
                refresh();
                Navigator.pop(context);
              }
              else{
                print('error '+response.statusCode.toString());
              }
            }
          },
          gradient: LinearGradient(colors: [
            Colors.green, Colors.lime
          ]),
        ),
        DialogButton(
          child: Text(
            "NO",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()=>Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Colors.red.shade700, Colors.orange
          ]),
        )
      ],
    ).show();
  }

  Widget primaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.deepOrange,
            child: new Text('Cancel Booking',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed:() {
              popUp();
            },
          ),
        ));
  }

  Future fetchData() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('patientID');
    if(id!=null){
      Map data;
      String url = 'https://venbedapi.azurewebsites.net/mobileapi/booking/booked?patientCode=$id';
      var response = await http.get(url, headers: <String, String>{'Content-Type': 'application/json',});
      if(response.statusCode==200){
        data = json.decode(response.body)[0];
        name = data['patientName'];
        status = data['status'];
        address = data['address'];
        hospital = data['hospital'];
        bed = data['bed'];
        vnts = data['ventilator'];
        treatment = data['underTreatment'];
        return true;
      }
    }
    return false;
  }

  void refresh(){
    fetchData().then((value){
      setState(() {
        _isLoading = false;
        if(!value)
          noData = true;
      });
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Booking'),
        backgroundColor: Colors.deepOrange,
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : ( noData ? Center(child: Text('No Booking Made Yet'),) :
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40,),
                Text(
                  'PATIENT DETAILS',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30,),
                DataTable(
                  headingRowHeight: 0,
                  columnSpacing: 20,
                  horizontalMargin: 10,
                  columns: [
                    DataColumn(label: SizedBox(),),
                    DataColumn(label: SizedBox(),),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(
                        Text(
                          'Patient Name',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text(
                          'Patient ID',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          id,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text(
                          'Patient Address',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          address,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text(
                          'Hospital',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          hospital,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text(
                          'Status',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          status,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text(
                          'Bed Alloted',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          bed,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text(
                          'Ventilator Alloted',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          vnts,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    ]),
                    DataRow(cells: [
                      DataCell(
                        Text(
                          'Under Treatment',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          treatment,
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    ]),
                  ],
                ),
                primaryButton(),
              ],
            ),
          )
      )
    );
  }
}
