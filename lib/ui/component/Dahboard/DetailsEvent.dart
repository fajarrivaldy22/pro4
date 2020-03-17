import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsEvent extends StatefulWidget {

  String documentId;
  
  DetailsEvent(this.documentId);

  @override
  _DetailsEventState createState() => _DetailsEventState();
}

class _DetailsEventState extends State<DetailsEvent> {
  @override
  Widget build(BuildContext context) {

    String _titleEvent = "Event Details"; 

    

    return  new StreamBuilder(
        stream: Firestore.instance.collection("Event").document(this.widget.documentId).snapshots(),
        builder:  (context,AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasError){
            print('Data has error');
            return Scaffold(
              body: Center(child: Text("Error occure"),),
            );
          }
          if(snapshot.data == null){
            print("Loading event...");
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          switch(snapshot.connectionState){
            case ConnectionState.waiting:{
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            default:{
              List<NetworkImage> images = List<NetworkImage>();
              for(int i = 0;i < snapshot.data['images'].length;i++){
                images.add(NetworkImage(snapshot.data['images'][i]));
              }
              return Scaffold(
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                    expandedHeight: 220.0,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(snapshot.data['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),
                        background: Carousel(
                          defaultImage: AssetImage("assets/images/event_tile_default.png"),
                          dotSpacing: 10,
                          boxFit: BoxFit.fitHeight,
                          autoplay: false,
                          animationCurve: Curves.fastOutSlowIn,
                          animationDuration: Duration(milliseconds: 1000),
                          dotSize: 4,
                          dotIncreaseSize: 2,
                          dotIncreasedColor: Colors.white,
                          dotColor: Colors.white24,
                          dotBgColor: Colors.transparent,
                          dotPosition: DotPosition.bottomCenter,
                          dotVerticalPadding: 2,
                          showIndicator: true,
                          indicatorBgPadding: 2,
                          overlayShadow: true,
                          overlayShadowColors: Color.fromRGBO(140, 143, 137, 0.1),
                          overlayShadowSize: 0.7,
                          images: images,
                      ),
                    ),
                  ),
                  ],
                )
              );
            }
          }
        },
    );
  }
}