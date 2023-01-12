// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_chat/models/person_model.dart';

class MessageModel {
  final PersonModel person;
  final String message;
  MessageModel({
    required this.person,
    required this.message,
  });
}
