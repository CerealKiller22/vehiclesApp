import 'package:vehicles_app/models/documentType.dart';
import 'package:vehicles_app/models/user.dart';

class Token {
  String token = "";
  String expiration = "";
  User user = User(
    firstName: "", 
    lastName: "", 
    documentType: DocumentType(id: 0, description: ""), 
    document: "", 
    address: "", 
    imageId: "", 
    imageFullPath: "", 
    userType: 0, 
    fullName: "", 
    id: "", 
    userName: "", 
    email: "", 
    phoneNumber: ""
  );

  Token({required this.token, required this.expiration, required this.user});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiration = json['expiration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expiration'] = this.expiration;
    return data;
  }
}