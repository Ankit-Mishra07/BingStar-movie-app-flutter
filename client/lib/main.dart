import 'package:client/pages/main_page.dart';
import 'package:client/pages/splash_page.dart';
import 'package:client/provider/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () => null,
    ),
  );
}

// Pages
