import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro4/ui/component/Dahboard/Filter/filterMenu.dart';
import 'package:pro4/utils/firebase_auth.dart';
import 'package:provider/provider.dart';

class DashboardMain extends StatefulWidget {
  @override
  _DashboardMainState createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  List<DropdownMenuItem<int>> _listDropdown = [];

  void LoadData(){
    _listDropdown.add(
      new DropdownMenuItem(
        child: new Text("1"),
        value: 1,
      )
    );
    _listDropdown.add(
      new DropdownMenuItem(
        child: new Text("2"),
        value: 2,
      )
    );
    
  }
  final category = [
    "Breakfast",
    "Lunch",
    "2nd Snack",
    "Dinner",
    "3rd Snack",
  ];

  int selectedCategory = 0;
  final scrollController = ScrollController(initialScrollOffset: 0);
  List<Widget> _buildCategory(){
    return category.map((val)=>MySelectionItem(title: val)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    LoadData();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Explore",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.shoppingCart,color: Colors.white,size: 18,),
            onPressed: (){
              print("shoping cart");
            },
          ),
          

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  child: Column(
                    children: <Widget>[
                      
                      DirectSelect(
                        itemExtent: 50.0,
                        selectedIndex: selectedCategory,
                        child: MySelectionItem(

                          isForList: false,
                          title: category[selectedCategory],
                        ),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedCategory = index;
                          });
                        },
                        items: _buildCategory()
                      ),

                    ],
                  ),
                ),
              )
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.plus),
                    onPressed: (){
                      Navigator.of(context).push(_filterMenuRoute());
                    }
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.plus),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.plus),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.plus),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      
    );
  }
  
}

Route _filterMenuRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => FilterMenu(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title,style: TextStyle(fontSize: 12),),
    );
  }
}
