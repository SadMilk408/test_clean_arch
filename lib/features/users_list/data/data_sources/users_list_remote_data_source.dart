import 'dart:convert';

import 'package:clean_arch/core/errors/exceptions.dart';
import 'package:clean_arch/features/users_list/data/models/users_list_model.dart';
import 'package:http/http.dart' as http;

abstract class UsersListRemoteDataSource {
  /// Calls the https://randomuser.me/api/ endpoint.
  ///
  /// Throws a [ServesException] for all error codes.
  Future<UsersListModel>? getUsersList(int? page, int? results);
}

class UsersListRemoteDataSourceImpl implements UsersListRemoteDataSource {
  final http.Client client;

  UsersListRemoteDataSourceImpl({required this.client});

  @override
  Future<UsersListModel>? getUsersList(int? page, int? results) =>
      _getUsersFromUrl(Uri.https('randomuser.me', '/api/', {
        'page': '$page',
        'results': '$results'
      }));

  Future<UsersListModel> _getUsersFromUrl(Uri uri) async {
    final response = await client.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return UsersListModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(message: 'Ошибка сервера');
    }
  }
}
