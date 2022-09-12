import 'dart:ui';

import 'package:client/controllers/main_page_data_controller.dart';
import 'package:client/models/main_page_data.dart';
import 'package:client/models/movie_model.dart';
import 'package:client/models/search_category.dart';
import 'package:client/widgets/movie_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import "package:flutter_riverpod/flutter_riverpod.dart";

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController>((ref) {
  return MainPageDataController();
});

class MainPage extends ConsumerWidget {
  late double deviceHeight;
  late double deviceWidth;
  late MainPageDataController _mainPageDataController;
  late MainPageData _mainPageData;
  late TextEditingController searchTextFeildController;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    searchTextFeildController = TextEditingController();
    _mainPageDataController = watch(mainPageDataControllerProvider);
    _mainPageData = watch(mainPageDataControllerProvider.state);
    searchTextFeildController.text = _mainPageData.searchText;

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TopBarWidget(),
          Container(
            height: deviceHeight * 0.83,
            padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
            child: MoviesListViewWidget(),
          )
        ],
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
        onSubmitted: (_input) =>
            _mainPageDataController.updateTextSearch(_input.toString()),
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
      value: _mainPageData.searchCategory,
      icon: Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      onChanged: (_value) => _value.toString().isNotEmpty
          ? _mainPageDataController.updateSearchCategory(_value.toString())
          : null,
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

  Widget MoviesListViewWidget() {
    final List<MovieModel> movies = _mainPageData.movies;
    // for (var i = 0; i < 20; i++) {
    //   movies.add(MovieModel(
    //     name: "Ankit Mishra",
    //     language: "Hindi",
    //     isAdult: true,
    //     description:
    //         "Hey There is description Hey There is description Hey There is description Hey There is description Hey There is description Hey There is description",
    //     posterPath: "/rugyJdeoJm7cSJL1q4jBpTNbxyU.jpg",
    //     backdropPath: "/ugS5FVfCI3RV0ZwZtBV3HAV75OX.jpg",
    //     rating: 7.8,
    //     releaseDate: "2022-07-05",
    //   ));
    // }
    if (movies.length != 0) {
      return NotificationListener(
        onNotification: (_onScrollNotification) {
          if (_onScrollNotification is ScrollEndNotification) {
            final before = _onScrollNotification.metrics.extentBefore;
            final max = _onScrollNotification.metrics.maxScrollExtent;
            if (before == max) {
              _mainPageDataController.getMovies();
              return true;
            }
            return false;
          }
          return false;
        },
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext _context, int _count) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: deviceHeight * 0.01, horizontal: 0),
              child: GestureDetector(
                onTap: () {},
                child: MovieTile(
                  movie: movies[_count],
                  height: deviceHeight * 0.20,
                  width: deviceWidth * 0.85,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ));
    }
  }
}
