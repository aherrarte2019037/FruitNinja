import 'package:flutter/material.dart';
import 'package:fruit_ninja/src/ui/pages/game/game_page.dart';
import 'package:fruit_ninja/src/ui/pages/home/home_page.dart';

class RouterUtil {

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case 'game':
        return MaterialPageRoute(builder: (_) => const GamePage());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }

}
