import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants.dart';
import '../../domain/entities/upcoming_movies.dart';
import '../bloc/upcoming_movies_list_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  final UpcomingMovies movie;
  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MoviesListBloc bloc = MoviesListBloc();

  @override
  Widget build(BuildContext context) {
    var releaseDate = widget.movie.releaseDate;
    List<String>? genreNames = bloc.genres(widget.movie.genreIds!);
    var size = MediaQuery.of(context).size;
    releaseDate = bloc.dateFormatter(releaseDate!);
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.6,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    posterPathBaseUrl + widget.movie.posterPath!,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.movie.title!,
                style: GoogleFonts.oswald(
                    textStyle: TextStyle(fontSize: 20), color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Release Date: " + releaseDate!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  )),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.movie.overview!,
                  style: GoogleFonts.oswald(
                      textStyle: TextStyle(fontSize: 16), color: Colors.white),
                ),
              ),
            ),
            SizedBox(
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                genreNames[position],
                                style: GoogleFonts.oswald(
                                    textStyle: TextStyle(fontSize: 14),
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
