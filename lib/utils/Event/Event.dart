
class Event{
  
  String id;
  String ownerId;
  String name;
  String type;
  int price;
  String location;
  DateTime scheduled;
  var images = new List(5);


  String getId(){
    return this.id;
  }

  String getOwnerId(){
    return this.ownerId;
  }

  String getName(){
    return this.name;
  }

  String getType(){
    return this.type;
  }

  int getPrice(){
    return this.price;
  }

  String getLocation(){
    return this.location;
  }

  DateTime getScheduled(){
    return this.scheduled;
  }

  String getImagesUri(int position){
    return this.images[position];
  }
   
}