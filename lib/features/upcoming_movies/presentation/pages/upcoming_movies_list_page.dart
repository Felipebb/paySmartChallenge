import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants.dart';
import '../../domain/entities/upcoming_movies.dart';
import '../bloc/upcoming_movies_list_bloc.dart';
import 'upcoming_movie_detail_page.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  MoviesListBloc bloc = MoviesListBloc();
  final _scrollController = ScrollController();
  static const _progressIndicatorSize = 10.0;
  bool tapSearchIcon = false;
  var textEditingController = TextEditingController();
  bool isFilter = false;

  @override
  void initState() {
    super.initState();
    bloc.getMovies();
    _scrollController.addListener(() {
      if (!bloc.isLoadingNewsPage &&
          !isFilter &&
          (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent -
                  _progressIndicatorSize)) {
        bloc.getMovies();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.4),
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.house),
                    onPressed: () {
                      bloc.getMovies();
                      isFilter = !isFilter;
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("paySmartChallenge "),
                ),
              ],
            ),
            TextField(
              controller: textEditingController,
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                      onTap: () {
                        isFilter = true;
                        if (textEditingController.text.isNotEmpty &&
                            textEditingController.text.length > 2) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          bloc.getFilteredMovieList(textEditingController.text);
                          textEditingController.clear();
                        }
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Search',
                  fillColor: Colors.white,
                  filled: true,
                  labelStyle: TextStyle(
                      backgroundColor: Colors.black, color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10))),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        titleTextStyle: GoogleFonts.oswald(
            textStyle: TextStyle(fontSize: 20), color: Colors.white),
        toolbarHeight: 125,
      ),
      body: StreamBuilder(
        initialData: null,
        stream: bloc.movieStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _buildListWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              "No results were found for your search.",
              style: GoogleFonts.oswald(
                  textStyle: TextStyle(fontSize: 26), color: Colors.white),
            ));
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        },
      ),
    );
  }

  Widget _buildListWidget(List<UpcomingMovies> upcomingMovies) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: upcomingMovies.length + 1,
      itemBuilder: (context, position) {
        if (position == upcomingMovies.length) {
          if (bloc.hasMoreItems && !isFilter) {
            bloc.getMovies();
          }
          return Visibility(
            visible: bloc.hasMoreItems && !isFilter,
            child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator())),
          );
        }
        return _buildCardWidget(upcomingMovies[position], position);
      },
    );
  }

  Widget _buildCardWidget(UpcomingMovies movie, int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
      child: InkWell(
        onTap: () => _onMovieDetail(movie),
        child: Card(
          child: _buildStackWidget(movie),
        ),
      ),
    );
  }

  Widget _buildStackWidget(UpcomingMovies movie) {
    return Stack(
      children: <Widget>[
        _posterWidget(movie.posterPath),
        _titleAndDateWidget(movie.originalTitle!, movie.releaseDate!),
        _genreWidget(movie.genreIds!),
      ],
    );
  }

  Widget _posterWidget(String? posterImagePath) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4.0), bottomLeft: Radius.circular(4.0)),
        child: posterImagePath == null
            ? Image.network(
                posterImageNotFound,
                height: 150.0,
                width: 100.0,
              )
            : Image.network(
                posterPathBaseUrl + posterImagePath,
                height: 150.0,
                width: 100.0,
              ));
  }

  Widget _titleAndDateWidget(String title, String releaseDate) {
    releaseDate = bloc.dateFormatter(releaseDate);
    return Positioned(
      left: 130,
      top: 10,
      child: SizedBox(
        width: 200,
        child: Column(
          children: [
            Text(
              title,
              style: GoogleFonts.oswald(
                textStyle: TextStyle(fontSize: 16),
                color: Colors.grey.shade800,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Release Date: " + releaseDate,
                style: GoogleFonts.oswald(
                    textStyle: TextStyle(fontSize: 12), color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genreWidget(List<int> genreIds) {
    List<String>? genreNames = bloc.genres(genreIds);
    return Positioned(
      bottom: -20,
      left: 102,
      child: SizedBox(
        height: 100,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: genreNames!.length,
            itemBuilder: (context, position) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          genreNames[position],
                          style: GoogleFonts.oswald(
                            textStyle: TextStyle(fontSize: 14),
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  _onMovieDetail(UpcomingMovies movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MovieDetailPage(movie: movie);
        },
      ),
    );
  }
}
