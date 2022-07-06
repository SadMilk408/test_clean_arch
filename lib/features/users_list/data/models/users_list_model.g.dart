// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersListModel _$UsersListModelFromJson(Map<String, dynamic> json) =>
    UsersListModel(
      results: (json['results'] as List<dynamic>)
          .map((e) => UsersListResultsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UsersListModelToJson(UsersListModel instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

UsersListResultsModel _$UsersListResultsModelFromJson(
        Map<String, dynamic> json) =>
    UsersListResultsModel(
      name: UsersListResultsNameModel.fromJson(
          json['name'] as Map<String, dynamic>),
      location: UsersListResultsLocationModel.fromJson(
          json['location'] as Map<String, dynamic>),
      picture: UsersListResultsPictureModel.fromJson(
          json['picture'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UsersListResultsModelToJson(
        UsersListResultsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'location': instance.location,
      'picture': instance.picture,
    };

UsersListResultsNameModel _$UsersListResultsNameModelFromJson(
        Map<String, dynamic> json) =>
    UsersListResultsNameModel(
      title: json['title'] as String,
      first: json['first'] as String,
      last: json['last'] as String,
    );

Map<String, dynamic> _$UsersListResultsNameModelToJson(
        UsersListResultsNameModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'first': instance.first,
      'last': instance.last,
    };

UsersListResultsLocationModel _$UsersListResultsLocationModelFromJson(
        Map<String, dynamic> json) =>
    UsersListResultsLocationModel(
      street: json['street'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      postcode: json['postcode'] as String,
      coordinates: UsersListResultsLocationCoordinatesModel.fromJson(
          json['coordinates'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UsersListResultsLocationModelToJson(
        UsersListResultsLocationModel instance) =>
    <String, dynamic>{
      'street': instance.street,
      'city': instance.city,
      'state': instance.state,
      'postcode': instance.postcode,
      'coordinates': instance.coordinates,
    };

UsersListResultsLocationCoordinatesModel
    _$UsersListResultsLocationCoordinatesModelFromJson(
            Map<String, dynamic> json) =>
        UsersListResultsLocationCoordinatesModel(
          latitude: json['latitude'] as String,
          longitude: json['longitude'] as String,
        );

Map<String, dynamic> _$UsersListResultsLocationCoordinatesModelToJson(
        UsersListResultsLocationCoordinatesModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

UsersListResultsPictureModel _$UsersListResultsPictureModelFromJson(
        Map<String, dynamic> json) =>
    UsersListResultsPictureModel(
      large: json['large'] as String,
      medium: json['medium'] as String,
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$UsersListResultsPictureModelToJson(
        UsersListResultsPictureModel instance) =>
    <String, dynamic>{
      'large': instance.large,
      'medium': instance.medium,
      'thumbnail': instance.thumbnail,
    };
