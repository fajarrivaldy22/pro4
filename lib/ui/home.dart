import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro4/utils/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'component/Account/Account.dart';
import 'component/Dahboard/Dashboard.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  int _initialIndex = 0;
  final styleForText = TextStyle(color: Colors.white);
  final List<Widget> _widgetOption = <Widget>[
    DashboardMain(),
    Text("Inbox wid" ),
    Text("News wid"),
    Text("Order wid"),
    AccountMain()
  ];
  static const List<String> _titles = <String>[
    "Dashboard",
    "Inbox",
    "News",
    "Order",
    "Account"
  ];
  void _onItemTapped(int index){
    setState(() {
      _initialIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      
      body: Center(
        child: _widgetOption.elementAt(_initialIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey[400],
        currentIndex: _initialIndex,
        onTap: _onItemTapped,
        
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.compass),title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
            child: Text(
              'Explore',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.mailBulk),title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
            child: Text(
              'Inbox',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.newspaper),title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
            child: Text(
              'News',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.listAlt),title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
            child: Text(
              'Order',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ),
          BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userAlt),title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 0),
            child: Text(
              'Account',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ),
        ]
      ),
    );
  }
}





