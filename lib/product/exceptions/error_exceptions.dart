import 'package:flutter/foundation.dart';

@immutable
class ErrorExceptions {
  const ErrorExceptions._();

  static void printError(Object e) {
    if (kDebugMode) {
      if (e is Exception) {
        debugPrint('Hata: ${e.toString()}');
      } else if (e is Error) {
        debugPrint('Ciddi Hata: ${e.toString()}');
      } else {
        debugPrint('Bilinmeyen Hata: ${e.toString()}');
      }
    }
  }
}
