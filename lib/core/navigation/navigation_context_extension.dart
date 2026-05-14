import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(
    String routeName, {
    Object? arguments,
    bool rootNavigator = false,
  }) {
    return Navigator.of(
      this,
      rootNavigator: rootNavigator,
    ).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(
      this,
    ).pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
    required RoutePredicate predicate,
  }) {
    return Navigator.of(
      this,
    ).pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void popUntil({required String routeName}) {
    final navigator = Navigator.of(this, rootNavigator: false);

    if (!navigator.canPop()) {
      debugPrint('⚠️ لا يمكن الرجوع، لا توجد صفحات في المكدس.');
      return;
    }

    bool routeExists = false;

    navigator.popUntil((route) {
      if (route.settings.name == routeName) {
        routeExists = true;
        debugPrint('✅ تم العثور على الصفحة المطلوبة: $routeName.');
        return true;
      }
      return false;
    });

    if (!routeExists) {
      debugPrint(
        '⚠️ لا يمكن الرجوع، لم يتم العثور على الصفحة المطلوبة: $routeName.',
      );
    }
  }

  void pop() {
    if (canPop()) {
      Navigator.of(this).pop();
    } else {
      debugPrint('⚠️ لا يمكن الرجوع، أنت في الشاشة الرئيسية.');
    }
  }

  bool canPop() => Navigator.of(this).canPop();
}
