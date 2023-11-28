import 'package:data_lager/database_service.dart';
import 'package:flutter/cupertino.dart';

class Provider extends InheritedWidget {
  const Provider({super.key, required super.child, required this.data});
  final DbService? data;

  static Provider? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>();
  }

  static DbService of(BuildContext context) {
    final DbService? result = maybeOf(context)!.data;
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
