import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_clone/model/animeModel.dart';

Future<List<Anime>> fetchAnimes() async {
  final response = await http.get(
      Uri.encodeFull('http://one.zetai.info/api/animes/recentes'),
      headers: {'Content-type': 'application/json; charset=utf-8'});
  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    return list.map((model) => Anime.fromJson(model)).toList();
  } else {
    throw Exception(
        'Failed do load Animes'); //TODO Better understanding of Exception handling needed
  }
}

Widget getAnimeList() {
  return FutureBuilder<List<Anime>>(
    future: fetchAnimes(),
    builder: (context, snapshot) {
        return new AnimeList(
          hasData: snapshot.hasData,
          length: snapshot.data.length,
          animes: snapshot.data,
          hasError: snapshot.hasError,
          error: snapshot.error,
        );
    },
  );
}

class AnimeList extends StatelessWidget {
  final bool hasData;
  final int length;
  final List<Anime> animes;
  final bool hasError;
  final Object error;

  AnimeList({this.hasData, this.length, this.animes, this.hasError, this.error});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
