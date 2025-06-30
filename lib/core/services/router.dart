import 'package:flutter/material.dart';
import 'package:template_project/main.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return _pageBuilder((context) => MyHomePage(title: 'InitialPage'),
          settings: settings);

    default:
      return _pageBuilder((context) => MyHomePage(title: 'InitialPage'),
          settings: settings);
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
    settings: settings,
  );
}
