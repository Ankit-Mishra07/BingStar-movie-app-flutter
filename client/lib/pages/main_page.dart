import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import "package:flutter_riverpod/flutter_riverpod.dart";

class MainPage extends ConsumerWidget {
  late double deviceHeight;
  late double deviceWidth;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [BackgroundWidget()],
        ),
      ),
    );
  }

  Widget BackgroundWidget() {
    return Container(
      height: deviceHeight,
      width: deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: const DecorationImage(
          image: NetworkImage(
              "https://cdn.pixabay.com/photo/2018/07/06/19/48/charles-chaplin-3521070__340.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
        ),
      ),
    );
  }
}
