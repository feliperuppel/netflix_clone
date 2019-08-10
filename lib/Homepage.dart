import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Detailpage.dart';
import 'PopularMovie.dart';
import 'PopularMovieData.dart';
import 'animeslider.dart';
import 'model/animeModel.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  Future<List<Anime>> loadedAnimes;
  Future<List<Anime>> loadedBestAnimes;
  Future<List<Anime>> loadedAnimeSlider;

  @override
  void initState() {
    super.initState();
    animationController =
        new AnimationController(duration: Duration(seconds: 20), vsync: this);
    animationController.repeat(period: Duration(seconds: 20));

    loadedAnimes = fetchAnimes('http://one.zetai.info/api/animes/recentes');
    loadedBestAnimes = fetchAnimes('http://one.zetai.info/api/animes/recentes');
    loadedAnimeSlider =
        fetchAnimes('http://one.zetai.info/api/animes/recentes');
  }

  Future<List<Anime>> fetchAnimes(String url) async {
    final response = await http.get(Uri.encodeFull(url),
        headers: {'Content-type': 'application/json; charset=utf-8'});
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      animation = IntTween(
              begin: 0,
              end:
                  3) //TODO Replace 'end' with the actual size of the result list.length -1
          .animate(animationController)
            ..addListener(() {
              setState(() {
                index = animation.value;
              });
            });
      return list.map((model) => Anime.fromJson(model)).toList();
    } else {
      throw Exception(
          'Failed do load Animes'); //TODO Better understanding of Exception handling needed
    }
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    popMovies(PopularList plist) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Detailpage(
                      list: plist,
                    )),
          );
        },
        child: PopularMovie(
          image: plist.image,
          name: plist.name,
          rating: plist.rating,
        ));

    final popularscroll = Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: populartlist.map((pl) => popMovies(pl)).toList(),
        ),
      ),
    );
    final scroll = Container(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: FutureBuilder<List<Anime>>(
              future: loadedBestAnimes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bestAnimes(Anime anime) => TopMovies(
                        image: anime.imagem,
                      );
                  Anime anime = snapshot.data[index];
                  return Row(
                    children: snapshot.data
                        .map((movie) => bestAnimes(movie))
                        .toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            )));

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Sushinime POC",
            style: TextStyle(color: Colors.orange, fontSize: 28),
          ),
          backgroundColor: Colors.black,
          //    leading:Icon(Icons.notifications,color: Colors.red,) ,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications,
                color: Colors.orange,
                size: 25,
              ),
            )
          ],
          //  toolbarOpacity: 0,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                  color: Colors.black,
                  child: FutureBuilder<List<Anime>>(
                    future: loadedAnimes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Anime anime = snapshot.data[index];
                        return Column(
                          children: <Widget>[
                            ImageData(anime.imagem, anime.nome),
                            scroll
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      // By default, show a loading spinner.
                      return CircularProgressIndicator();
                    },
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Continue Watching",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 180,
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.orange),
                    )
                  ],
                ),
              ),
              FutureBuilder<List<Anime>>(
                future: loadedBestAnimes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AnimeSlider(snapshot.data);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Popular On Netflix",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 180,
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.orange),
                    )
                  ],
                ),
              ),
              popularscroll
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }
}

class ImageData extends StatelessWidget {
  final String image;
  final String name;

  ImageData(this.image, this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(8.0)),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          name,
          style: TextStyle(
//            backgroundColor: Colors.black26,
            color: Colors.orangeAccent,
            fontWeight: FontWeight.bold,
            fontSize: 28,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black,
                offset: Offset(5.0, 0.0),
              ),
              Shadow(
                blurRadius: 10.0,
                color: Colors.black,
                offset: Offset(-5.0, 0.0),
              ),
              Shadow(
                blurRadius: 10.0,
                color: Colors.black,
                offset: Offset(0.0, -5.0),
              ),
              Shadow(
                blurRadius: 10.0,
                color: Colors.black,
                offset: Offset(0.0, 5.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopMovies extends StatelessWidget {
  final String image;

  TopMovies({Key key, this.image});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipOval(
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0.5, 1.0),
                    blurRadius: 5,
                    color: Colors.white)
              ]),
        ),
      ),
    );
  }
}
