import 'dart:convert';

import 'package:clean_arch/features/users_list/domain/entities/users_list_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users_list_model.g.dart';

@JsonSerializable()
class UsersListModel extends UsersListEntity {
  const UsersListModel({
    required List<UsersListResultsModel> results,
  }) : super(results: results);

  factory UsersListModel.fromJson(Map<String, dynamic> json) =>
      _$UsersListModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersListModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UsersListResultsModel extends UsersListResults {
  const UsersListResultsModel({
    required UsersListResultsNameModel name,
    required UsersListResultsLocationModel location,
    required UsersListResultsPictureModel picture,
  }) : super(name: name, location: location, picture: picture);

  factory UsersListResultsModel.fromJson(Map<String, dynamic> json) =>
      _$UsersListResultsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersListResultsModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UsersListResultsNameModel extends UsersListResultsName {
  const UsersListResultsNameModel({
    required String title,
    required String first,
    required String last,
  }) : super(title: title, first: first, last: last);

  factory UsersListResultsNameModel.fromJson(Map<String, dynamic> json) =>
      _$UsersListResultsNameModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersListResultsNameModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UsersListResultsLocationModel extends UsersListResultsLocation {
  const UsersListResultsLocationModel({
    required String street,
    required String city,
    required String state,
    required String postcode,
    required UsersListResultsLocationCoordinatesModel coordinates,
  }) : super(
            street: street,
            city: city,
            state: state,
            postcode: postcode,
            coordinates: coordinates);

  factory UsersListResultsLocationModel.fromJson(Map<String, dynamic> json) =>
      _$UsersListResultsLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersListResultsLocationModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UsersListResultsLocationCoordinatesModel
    extends UsersListResultsLocationCoordinates {
  const UsersListResultsLocationCoordinatesModel({
    required String latitude,
    required String longitude,
  }) : super(latitude: latitude, longitude: longitude);

  factory UsersListResultsLocationCoordinatesModel.fromJson(
          Map<String, dynamic> json) =>
      _$UsersListResultsLocationCoordinatesModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UsersListResultsLocationCoordinatesModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class UsersListResultsPictureModel extends UsersListResultsPicture {
  const UsersListResultsPictureModel({
    required String large,
    required String medium,
    required String thumbnail,
  }) : super(large: large, medium: medium, thumbnail: thumbnail);

  factory UsersListResultsPictureModel.fromJson(Map<String, dynamic> json) =>
      _$UsersListResultsPictureModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersListResultsPictureModelToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
