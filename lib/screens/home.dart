import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'form.dart';
import 'drawer.dart';

class HospitalTile extends StatelessWidget {

  final String hospital;
  final Color color;
  final bool insurance;
  final int freeBeds, occupiedBeds, freeVentilators, occupiedVentilators;

  HospitalTile({this.hospital, this.color, this.insurance, this.freeBeds,
  this.occupiedBeds, this.freeVentilators, this.occupiedVentilators});

  @override
  Widget build(BuildContext context) {

    double wd = MediaQuery.of(context).size.width;

    return InkWell(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        color: color,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: wd/22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: wd/2,
                    child: Text(
                      hospital,
                      style: TextStyle(
                        fontFamily: 'Rowdies',
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5, right: 3),
                            child: Icon(Icons.security, color: insurance ? Colors.green.shade600 : Colors.grey, size: 30),
                          ),
                          insurance ? SizedBox() :
                          Icon(Icons.close, color: Colors.red, size: 20,)
                        ],
                      ),
                      Text(
                        'Insurance',
                        style: TextStyle(
                          fontFamily: 'Lobster',
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Beds',
                        style: TextStyle(
                          fontFamily: 'Rowdies',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.local_hotel, size: 35,),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Ventilators',
                        style: TextStyle(
                          fontFamily: 'Rowdies',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Image.asset('images/ventilator.png', width: 26),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Free: ' + freeBeds.toString(),
                    style: TextStyle(
                      fontFamily: 'Lobster',
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Free: ' + freeVentilators.toString(),
                    style: TextStyle(
                      fontFamily: 'Lobster',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Occupied: ' + occupiedBeds.toString(),
                    style: TextStyle(
                      fontFamily: 'Lobster',
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Occupied: ' + occupiedVentilators.toString(),
                    style: TextStyle(
                      fontFamily: 'Lobster',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if((prefs.getString('patientID'))!=null)
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('You have already booked a bed. Cannot book more than 1 bed.'), duration: Duration(seconds: 1, milliseconds: 500),));
        else{
          if(freeBeds>0)
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PatientForm(hospital)));
          else
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('No Empty Beds at this Hospital! Try Another.'), duration: Duration(seconds: 1),));
        }
      },
    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double initial1 = 0, initial2 = 0;
  List<Color> color = [Colors.yellowAccent, Colors.orangeAccent, Colors.cyanAccent, Colors.green.shade200, Colors.blueGrey.shade200];
  final _controller = PanelController();
  List<dynamic> data;
  List<HospitalTile> allHospitals = List();
  List<HospitalTile> items = List();
  bool _isLoading = true;
  List<bool> filterValues = [false, false,false];
  String panelType = 'filter';
  List<bool> sortValues = [false, false,false, false];
  double ht,wd;

  Widget filterPanel(){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(width: 3, color: Colors.lightGreen),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 60, top: 30),
            child: GestureDetector(
              child: Container(
                decoration: new BoxDecoration(
                    color: Colors.orange, //new Color.fromRGBO(255, 0, 0, 0.0),
                    borderRadius: new BorderRadius.only(
                        topLeft:  const  Radius.circular(40.0),
                        bottomLeft: const  Radius.circular(40.0))
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.lightGreen,
                        value: filterValues[0],
                        onChanged: (value){
                          setState(() {
                            filterValues[0]= value;
                            filter();
                          });
                        },
                      ),
                    ),
                    Text('Hospitals giving Insurance', style: TextStyle(fontSize: 15, color: Colors.white),),
                  ],
                )
              ),
              onTap: ()=>setState(() {
                filterValues[0]= !filterValues[0];
                filter();
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 60,top: 30),
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.only(right: 10),
                  decoration: new BoxDecoration(
                      color: Colors.orange, //new Color.fromRGBO(255, 0, 0, 0.0),
                      borderRadius: new BorderRadius.only(
                          topRight:  const  Radius.circular(40.0),
                          bottomRight: const  Radius.circular(40.0))
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.lightGreen,
                          value: filterValues[1],
                          onChanged: (value){
                            setState(() {
                              filterValues[1]= value;
                              filter();
                            });
                          },
                        ),
                      ),
                      Text('Hospitals with Free Beds', style: TextStyle(fontSize: 15, color: Colors.white),),
                    ],
                  )
              ),
              onTap: ()=>setState(() {
                filterValues[1]= !filterValues[1];
                filter();
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 60, top: 30),
            child: GestureDetector(
              child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.orange, //new Color.fromRGBO(255, 0, 0, 0.0),
                      borderRadius: new BorderRadius.only(
                          topLeft:  const  Radius.circular(40.0),
                          bottomLeft: const  Radius.circular(40.0))
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.lightGreen,
                          value: filterValues[2],
                          onChanged: (value){
                            setState(() {
                              filterValues[2]= value;
                              filter();
                            });
                          },
                        ),
                      ),
                      Text('Hospitals with Free Ventilators', style: TextStyle(fontSize: 15, color: Colors.white),),
                    ],
                  )
              ),
              onTap: ()=>setState(() {
                filterValues[2]= !filterValues[2];
                filter();
              }),
            ),
          ),
        ],
      ),
    );
  }

  void filter(){

    List<HospitalTile> dummyListData = List<HospitalTile>();

    dummyListData.addAll(allHospitals);

    if(filterValues[0]==false && filterValues[1]==false && filterValues[2]==false)
      setState(() {
        items.clear();
        items.addAll(allHospitals);
      });
    else{
      for(var i in allHospitals){
        if((filterValues[0] && i.insurance==false) || (filterValues[1] && i.freeBeds==0) || (filterValues[2] && i.freeVentilators==0))
          dummyListData.remove(i);
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
    }

  }

  Widget sortPanel(){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(width: 3, color: Colors.lightGreen),
      ),
      child: Table(
        columnWidths: {1: FractionColumnWidth(0.55)},
        border: TableBorder.symmetric(inside: BorderSide(color: Colors.black45, width: 0)),
        children: [
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 10,0,0),
                child: Text('Free Beds', style: TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold),),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Row(
                      children: [
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.deepOrange),
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.lightGreen,
                            value: sortValues[0],
                            onChanged: (value){
                              sortValues = [false,false,false,false];
                              setState(() {
                                sortValues[0]= value;
                                sort();
                              });
                            },
                          ),
                        ),
                        Text('Ascending Order', style: TextStyle(color: Colors.deepOrange, fontSize: 14, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    onTap: (){
                        setState(() {
                          if(sortValues[0] == false){
                            sortValues = [false,false,false,false];
                            sortValues[0]= true;
                          }
                          else
                            sortValues[0]= false;
                          sort();
                      });
                    },
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.deepOrange),
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.lightGreen,
                            value: sortValues[1],
                            onChanged: (value){
                              sortValues = [false,false,false,false];
                              setState(() {
                                sortValues[1]= value;
                                sort();
                              });
                            },
                          ),
                        ),
                        Text('Descending Order', style: TextStyle(color: Colors.deepOrange, fontSize: 14, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    onTap: (){
                      setState(() {
                        if(sortValues[1] == false){
                          sortValues = [false,false,false,false];
                          sortValues[1]= true;
                        }
                        else
                          sortValues[1]= false;
                        sort();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10,0,0),
                child: Text('Free Ventilators', style: TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold),),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Row(
                      children: [
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.deepOrange),
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.lightGreen,
                            value: sortValues[2],
                            onChanged: (value){
                              sortValues = [false,false,false,false];
                              setState(() {
                                sortValues[2]= value;
                                sort();
                              });
                            },
                          ),
                        ),
                        Text('Ascending Order', style: TextStyle(color: Colors.deepOrange, fontSize: 14, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    onTap: (){
                      setState(() {
                        if(sortValues[2] == false){
                          sortValues = [false,false,false,false];
                          sortValues[2]= true;
                        }
                        else
                          sortValues[2]= false;
                        sort();
                      });
                    },
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        Theme(
                          data: ThemeData(unselectedWidgetColor: Colors.deepOrange),
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: Colors.lightGreen,
                            value: sortValues[3],
                            onChanged: (value){
                              sortValues = [false,false,false,false];
                              setState(() {
                                sortValues[3]= value;
                                sort();
                              });
                            },
                          ),
                        ),
                        Text('Descending Order', style: TextStyle(color: Colors.deepOrange, fontSize: 14, fontWeight: FontWeight.w600),),
                      ],
                    ),
                    onTap: (){
                      setState(() {
                        if(sortValues[3] == false){
                          sortValues = [false,false,false,false];
                          sortValues[3]= true;
                        }
                        else
                          sortValues[3]= false;
                        sort();
                      });
                    },
                  ),
                  SizedBox(height: ht/3.35,),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void sort(){
    if(sortValues[0])
      allHospitals.sort((a, b) => (a.freeBeds).compareTo(b.freeBeds));
    if(sortValues[1])
      allHospitals.sort((a, b) => -(a.freeBeds).compareTo(b.freeBeds));
    if(sortValues[2])
      allHospitals.sort((a, b) => (a.freeVentilators).compareTo(b.freeVentilators));
    if(sortValues[3])
      allHospitals.sort((a, b) => -(a.freeVentilators).compareTo(b.freeVentilators));
    filter();
  }

  Future fetchData() async{
    List hospitals;
    int totalBeds=0, totalVnts=0, occupiedBeds=0, occupiedVnts=0;
    double freeBeds, freeVnts;
    String url = 'https://venbedapi.azurewebsites.net/mobileapi/dashboard/main';
    var response = await http.get(url, headers: <String, String>{'Content-Type': 'application/json',});
    if(response.statusCode==200){
      hospitals = json.decode(response.body);
      for(Map hospital in hospitals){
        totalBeds+=hospital['totalBeds'];
        totalVnts+=hospital['totalVentilators'];
        occupiedBeds+=hospital['occupiedBeds'];
        occupiedVnts+=hospital['occupiedVnts'];
      }
      freeBeds = (totalBeds-occupiedBeds)/totalBeds*100;
      print('Beds '+(totalBeds-occupiedBeds).toString()+' '+totalBeds.toString());
      freeVnts = (totalVnts-occupiedVnts)/totalVnts*100;
      print('Vnts '+(totalVnts-occupiedVnts).toString()+' '+totalVnts.toString());
    }
    return [hospitals, freeBeds, freeVnts];
  }

  void refresh(){
    fetchData().then((value){
      setState(() {
        _isLoading = false;
        data = List.from(value[0]);
        allHospitals.clear();
        items.clear();
        for(int i=0;i<data.length;i++){
          allHospitals.add(
            HospitalTile(
              hospital: data[i]['hospital'],
              insurance: (data[i]['insurance']=='Yes'),
              color: color[i%5],
              freeBeds: (data[i]['totalBeds']-data[i]['occupiedBeds']),
              occupiedBeds: data[i]['occupiedBeds'],
              freeVentilators: (data[i]['totalVentilators']-data[i]['occupiedVnts']),
              occupiedVentilators: data[i]['occupiedVnts'],
            ),
          );
        }
        sortValues[1] = true;
        allHospitals.sort((a, b) => -(a.freeBeds).compareTo(b.freeBeds));        items.addAll(allHospitals);
        Timer(
            Duration(seconds: 1, milliseconds: 300),
                (){
              setState(() {
                initial1 = value[1];
                initial2 = value[2];
              });
            }
        );
      });
    });
  }

  @override
  void initState(){
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    ht = MediaQuery.of(context).size.height;
    wd = MediaQuery.of(context).size.width;
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(8.0),
      topRight: Radius.circular(8.0),
    );

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade300, Colors.white],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepOrange,
          title: Text('VEBED', style: TextStyle(fontFamily: 'Rowdies'),),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: refresh,
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: SlidingUpPanel(
          controller: _controller,
          minHeight: 0,
          maxHeight: ht/1.65,
//          isDraggable: false,
          backdropEnabled: true,
          borderRadius: radius,
          body: _isLoading ? Center(child: CircularProgressIndicator(),) :
          Column(
            children: [
              Container(
                color: Colors.white,
                margin: EdgeInsets.all(0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SleekCircularSlider(
                            appearance: CircularSliderAppearance(
                              customWidths: CustomSliderWidths(progressBarWidth: 10),
                              size: 140,
                              spinnerDuration: 2000,
                              customColors: CustomSliderColors(progressBarColors: [Colors.lightGreen, Colors.yellow, Colors.lightBlue], trackColor: Colors.greenAccent),
                            ),
                            min: 0,
                            max: 100,
                            initialValue: initial1,
                            innerWidget: (value)=>Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(value.toInt().toString()+'%', style: TextStyle(fontSize: 30),),
                                Text('Beds Empty'),
                              ],
                            ),
                          ),
                          SleekCircularSlider(
                            appearance: CircularSliderAppearance(
                              customWidths: CustomSliderWidths(progressBarWidth: 10),
                              size: 140,
                              spinnerDuration: 2000,
                            ),
                            min: 0,
                            max: 100,
                            initialValue: initial2,
                            innerWidget: (value)=>Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(value.toInt().toString()+'%', style: TextStyle(fontSize: 30),),
                                Text('Ventilators'),
                                Text('Empty'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.deepOrange, height: 0, thickness: 0.7,),
//                    SizedBox(height: 10),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            child: Container(
                              width: wd/2.1,
                              height: 35,
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Text(
                                'Sort',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Lobster'
                                ),
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                panelType = 'sort';
                              });
                              _controller.open();
                            },
                          ),
                          VerticalDivider(color: Colors.deepOrange, width: 0, thickness: 0.7,),
                          GestureDetector(
                            child: Container(
                              width: wd/2.1,
                              height: 35,
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: Text(
                                'Filter',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Lobster'
                                ),
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                panelType = 'filter';
                              });
                              _controller.open();

                            },
                          )
                        ]
                      ),
                    ),
//                    SizedBox(height: 10),
                    Divider(color: Colors.deepOrange, height: 0, thickness: 0.7,),

                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index){
                    return items[index];
                  },
                ),
              ),
              SizedBox(height: ht/8,)
            ],
          ),
          panel: Padding(
            padding: const EdgeInsets.all(10),
            child: panelType=='filter' ? filterPanel() : sortPanel(),
          ),
        ),
      ),
    );
  }
}
