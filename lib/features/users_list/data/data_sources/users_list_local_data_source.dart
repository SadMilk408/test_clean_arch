import 'dart:convert';

import 'package:clean_arch/core/errors/exceptions.dart';
import 'package:clean_arch/features/users_list/data/models/users_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UsersListLocalDataSource {
  /// Gets the cached [UsersListModel] which was gotten the last time
  /// the user had an internet connection
  ///
  /// Trows [CacheException] if no cached data is present.
  Future<UsersListModel>? getLastUsersList();

  Future<void>? cacheUsersList(UsersListModel? usersListToCache);
}

const CACHED_USERS_LIST = 'CACHED_USERS_LIST';

class UsersListLocalDataSourceImpl implements UsersListLocalDataSource {
  final SharedPreferences sharedPreferences;

  UsersListLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UsersListModel>? getLastUsersList() {
    final jsonString = sharedPreferences.getString(CACHED_USERS_LIST);
    if (jsonString != null) {
      return Future.value(UsersListModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheUsersList(UsersListModel? usersListToCache) {
    return sharedPreferences.setString(
      CACHED_USERS_LIST,
      jsonEncode(usersListToCache?.toJson()),
    );
  }
}