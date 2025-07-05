import 'package:deu_cis/feature/home/home_view.dart';
import 'package:deu_cis/feature/login/login_view.dart';
import 'package:deu_cis/product/cache/app_cache.dart';
import 'package:deu_cis/product/models/user.dart';
import 'package:deu_cis/product/services/model_service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthViewModel extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  IUserService _userService = UserService();

  Future<void> checkUserAuth(BuildContext context) async {
    String? jwtToken = await AppCache().getCachedValue(CacheTitles.jwtToken);
    if (jwtToken == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return LoginView();
        },
      ));
    } else {
      _user = await _userService.loginUserJWT(jwtToken);
      if (_user == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return LoginView();
          },
        ));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return HomeView();
          },
        ));
      }
      notifyListeners();
    }
  }

  Future<bool> loginUser(
      BuildContext context, String email, String password) async {
    _user = await _userService.loginUser(email, password);
    if (_user != null) {
      AppCache().saveValue(CacheTitles.jwtToken, _user!.jwtToken);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
