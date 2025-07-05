import 'package:deu_cis/product/enums/end_points.dart';
import 'package:deu_cis/product/exceptions/error_exceptions.dart';
import 'package:deu_cis/product/models/public_profile.dart';
import 'package:deu_cis/product/models/user.dart';
import 'package:deu_cis/product/utility/http_helper.dart';
import 'package:http/http.dart' as http;

abstract class IUserService {
  Future<User?> loginUser(String email, String password);
  Future<User?> loginUserJWT(String? jwtToken);
  Future<User?> getUser();
  Future<PublicProfile?> getPublicProfile(int userID, int profileID);
  Future<bool> updateUser();
}

class UserService implements IUserService {
  @override
  Future<User?> getUser() async {
    return null;
  }

  @override
  Future<bool> updateUser() {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<User?> loginUser(
    String email,
    String password,
  ) async {
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.users.name, UsersEndpoints.login.name, {
        'email': email,
        'password': password,
      });
      if (response.statusCode < 300) {
        final user = User.fromJson(response.body);
        return user;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<User?> loginUserJWT(String? jwtToken) async {
    if (jwtToken == null) {
      return null;
    }
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.users.name, UsersEndpoints.loginJWT.name, {
        'jwt': jwtToken,
      });
      if (response.statusCode < 300) {
        final user = User.fromJson(response.body);
        return user;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<PublicProfile?> getPublicProfile(int userID, int profileID) async {
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.users.name, UsersEndpoints.public_profile.name, {
        "user_id": userID,
        "profile_id": profileID,
      });
      if (response.statusCode < 300) {
        final publicProfile = PublicProfile.fromJson(response.body);
        return publicProfile;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }
}
