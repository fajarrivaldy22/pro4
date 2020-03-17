
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro4/ui/component/Dahboard/EventTile.dart';

class FilterMenu extends StatefulWidget {

  @override
  _FilterMenuState createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: Text("Trail Adventure",style: TextStyle(fontSize: 18,fontFamily: 'Roboto Mono',fontWeight: FontWeight.w600),),
        
      ),
      backgroundColor: Colors.white,
      body:new StreamBuilder(
          stream: Firestore.instance.collection("Event").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
            try {
              print("filterMenu connectionState: "+snapshot.connectionState.toString());
              if(snapshot.hasError){
                print('Data has error');
                return Text('ERROR');
              }
              if(snapshot.data == null){
                print("Loading event...");
                return Center(child: CircularProgressIndicator(),);
              }
              switch(snapshot.connectionState){
                case ConnectionState.waiting: {
                  return CircularProgressIndicator();
                } 
                default : {
                  return Container(
                    child:  ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (BuildContext context,int index){
                                DocumentSnapshot documentSnapshot = snapshot.data.documents[index];
                                return EventTile(documentSnapshot);
                              },
                              itemCount: snapshot.data.documents.length,
                            ),
                  );
                }
              }
              
            } catch (e) {
              print("FilterMEnu :"+e.toString());
            }
          },
        ),
        floatingActionButton: 
               SizedBox(
                width: 90,
                height: 30,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.grey[50].withOpacity(0.7),
                  label: Text("Filter",style: TextStyle(color: Colors.blueAccent,fontSize: 12),),
                  icon: Icon(FontAwesomeIcons.filter,size: 12,color: Colors.blueAccent,),
                  onPressed: (){
                    print("filter pressed");
                  },
            ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}



/*Container(
        
        child: SingleChildScrollView(
          child: Column(
            
            children: <Widget>[
              
            ],
          ),
        )
      )
*/