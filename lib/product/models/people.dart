// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:deu_cis/product/models/education.dart';

class People {
  String id;
  String name;
  String email;
  String phoneNumber;
  String imageUrl;
  String affillations;
  List<Education?>? education;
  People({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.imageUrl,
    required this.affillations,
    required this.education,
  });
}
