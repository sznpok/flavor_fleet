// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'address': instance.address,
      'email': instance.email,
      'password': instance.password,
    };
