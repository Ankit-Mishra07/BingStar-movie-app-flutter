import 'dart:ui';

import 'package:client/models/search_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import "package:flutter_riverpod/flutter_riverpod.dart";

class MainPage extends ConsumerWidget {
  late double deviceHeight;
  late double deviceWidth;
  late TextEditingController searchTextFeildController;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    searchTextFeildController = TextEditingController();
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
          children: [
            BackgroundWidget(),
            ForegroundWidget(),
          ],
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

  Widget ForegroundWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, deviceHeight * 0.02, 0, 0),
      width: deviceWidth * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [TopBarWidget()],
      ),
    );
  }

  Widget TopBarWidget() {
    return Container(
      height: deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SearchFeildWidget(),
          CategorySelectionWidget(),
        ],
      ),
    );
  }

  Widget SearchFeildWidget() {
    final _border = InputBorder.none;
    return Container(
      width: deviceWidth * 0.50,
      height: deviceHeight * 0.05,
      child: TextField(
        controller: searchTextFeildController,
        onSubmitted: (_input) {},
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: _border,
          border: _border,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white24,
          ),
          hintStyle: TextStyle(color: Colors.white54),
          filled: false,
          fillColor: Colors.white,
          hintText: "Search...",
        ),
      ),
    );
  }

  Widget CategorySelectionWidget() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: SearchCategory.popular,
      icon: Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      onChanged: (_value) {},
      items: [
        DropdownMenuItem(
          child: Text(
            SearchCategory.popular,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          value: SearchCategory.popular,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.upcoming,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          value: SearchCategory.upcoming,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.none,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          value: SearchCategory.none,
        ),
      ],
    );
  }
}
