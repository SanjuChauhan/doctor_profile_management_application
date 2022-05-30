// To parse this JSON data, do
//
//     final gaiaDirectory = gaiaDirectoryFromJson(jsonString);

import 'dart:convert';

List<ContactsData> contactsDataFromJson(String str) =>
    List<ContactsData>.from(
        json.decode(str).map((x) => ContactsData.fromJson(x)));

String contactsDataToJson(List<ContactsData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactsData {
  ContactsData({
    this.id,
    this.first_name,
    this.last_name,
    this.profile_pic,
    this.favorite,
    this.primary_contact_no,
    this.rating,
    this.email_address,
    this.qualification,
    this.description,
    this.specialization,
    this.languagesKnown,
  });

  int id;
  String first_name;
  String last_name;
  String profile_pic;
  bool favorite;
  String primary_contact_no;
  String rating;
  String email_address;
  String qualification;
  String description;
  String specialization;
  String languagesKnown;

  factory ContactsData.fromJson(Map<String, dynamic> json) => ContactsData(
        id: json["id"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        profile_pic: json["profile_pic"],
        favorite: json["favorite"],
        primary_contact_no: json["primary_contact_no"],
        rating: json["rating"],
        email_address: json["email_address"],
        qualification: json["qualification"],
        description: json["description"],
        specialization: json["specialization"],
        languagesKnown: json["languagesKnown"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": first_name,
        "last_name": last_name,
        "profile_pic": profile_pic,
        "favorite": favorite,
        "primary_contact_no": primary_contact_no,
        "rating": rating,
        "email_address": email_address,
        "qualification": qualification,
        "description": description,
        "specialization": specialization,
        "languagesKnown": languagesKnown,
      };
}
