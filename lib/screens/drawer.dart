import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {

  Widget buildListTile(String title, IconData icon, Function handlingTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: handlingTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20,100,20,20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Navigate",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: Colors.deepOrange,
              ),
            ),
          ),
          SizedBox(
            height: 20
          ),
          buildListTile("Home", Icons.home, (){
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile("Quick Guide", Icons.collections_bookmark,(){
            Navigator.of(context).pushNamed('/quickGuide');
          }),
          buildListTile("My Booking", Icons.account_circle,(){
            Navigator.of(context).pushNamed('/myBooking');
          }),
        ],
      ),
    );
  }
}
