
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro4/ui/component/Dahboard/DetailsEvent.dart';


class EventTile extends StatelessWidget{
  DocumentSnapshot document;
  EventTile(this.document);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<NetworkImage> images = List<NetworkImage>();
    for(int i = 0;i < this.document['images'].length;i++){
      images.add(NetworkImage(this.document['images'][i]));
    }
    return new Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(4,4.5,4,4.5),
              child: InkWell(
                onTap: (){
                   Navigator.of(context).push(_detailsEventRoute(this.document.documentID));
                },
                child: new Card(
                clipBehavior: Clip.antiAlias,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(4))
                ),
                semanticContainer: true,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Stack(
                        children: <Widget>[
                                SizedBox(
                                  height: 230,
                                  width: double.infinity,
                                  child: Carousel(
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
                            Positioned(
                              left: 6,
                              bottom: 10,
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: Container(
                                  width: 1000,
                                  child: Text('Rp '+document["price"].toString(),style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'RobotoMono',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              )
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Badge(
                                badgeColor: Colors.lightBlue,
                                elevation: 0,
                                shape: BadgeShape.square,
                                badgeContent: Text('Sepeda / XC',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),),
                                borderRadius: 0,
                              ),
                            ),
                        ],
                      )
                    ),
                    Padding(
                        padding: new EdgeInsets.fromLTRB(10, 6, 0, 6),
                        child: Row(
                        children: <Widget>[
                          Text(document["name"],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),)
                        ],
                      ),
                    ),
                    Padding(
                        padding: new EdgeInsets.fromLTRB(10, 0, 3, 10),
                        child: Row(
                        children: <Widget>[
                            Icon(FontAwesomeIcons.mapMarkerAlt,size: 14.5,color: Colors.orangeAccent,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 10, 0),
                              child: Text(document["location"].toString(),style: TextStyle(color: Colors.grey,fontSize: 12),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                    Padding(
                      padding: new EdgeInsets.fromLTRB(10, 0, 3, 10),
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.calendarTimes,size: 14.5,color: Colors.red,),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
                                child: Text('Sunday, 16 April 2020',style: TextStyle(color: Colors.grey,fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                    
                ],
          )
        ),
              ),
      ),
    );
  }
  
}

Route _detailsEventRoute(String id) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DetailsEvent(id),
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


/*
SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      child: Text("Order",style: TextStyle(color:Colors.white),),
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(0))
                      ),
                      onPressed: (){
                        print(this.document["name"]);
                      },
                    ),
                    
                  ),

                  
*/