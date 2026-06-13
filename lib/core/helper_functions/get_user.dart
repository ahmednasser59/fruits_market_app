import 'dart:convert';

import 'package:fruits_hub/constants.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';
import 'package:fruits_hub/features/auth/data/models/user_model.dart';
import 'package:fruits_hub/features/auth/domain/entites/user_entity.dart';

UserEntity getUser() {
  var jsonString = Prefs.getString(kUserData);
  if (jsonString.isEmpty) {
    return UserEntity(name: '', email: '', uId: '');
  }
  try {
    var userEntity = UserModel.fromJson(jsonDecode(jsonString));
    return userEntity;
  } catch (e) {
    return UserEntity(name: '', email: '', uId: '');
  }
}
