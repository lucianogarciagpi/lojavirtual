import 'package:cloud_firestore/cloud_firestore.dart';

class Product {

  Product.fromDocument(DocumentSnapshot document){
    /// Pegando os dados do documento e atribuindo aos campos do produto
    id = document.documentID;
    name = document["name"] as String;
    description = document["description"] as String;
    images = List<String>.from(document.data["images"] as List<dynamic>);
  }

  String id;
  String name;
  String description;
  List<String> images;

}