

class Incident {

  final String userId; 
  final String title; 
  final String description; 
  final String photoURL; 

  Incident({this.userId, this.title, this.description, this.photoURL}); 

  Map<String, dynamic> toMap() {
    return {
      "userId": userId, 
      "title": title, 
      "description": description, 
      "photoURL": photoURL
    };
  }

}