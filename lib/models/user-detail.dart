import 'package:flutter/cupertino.dart';

class UserDetail {
  int id;
  String name;
  String email;
  String phone;
  String website;
  String address;
  String company;

  UserDetail({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.website,
    @required this.address,
    @required this.company
  });
}