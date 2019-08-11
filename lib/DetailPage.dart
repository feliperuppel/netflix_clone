import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import 'model/animeModel.dart';

class Detailpage extends StatelessWidget {
  final Anime anime;

  Detailpage({this.anime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          topBar(),
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: MediaQuery.of(context).size.height - 260,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 8,
                height: MediaQuery.of(context).size.height - 260,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 130),
                              child: Text(
                                anime.nome,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'MagnumSansMedium'),
                              ),
                            ),
                            Positioned(
                                top: 12,
                                right: 0,
                                child: Text(
                                  anime.rank.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'MagnumSansBold'),
                                ))
                          ],
                        ),
                      ),
                      Moviedata(
                        rating: anime.rank.toString(),
                        dname: anime.categoria.split(" ")[0],
                        release: anime.ano,
                      ),
                      FittedBox(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Description',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                anime.desc,
                                style: TextStyle(fontSize: 15, height: 1.4),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  SizedBox topBar() {
    return SizedBox(
      height: 250,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[BlueBar(anime.imagem), MoviePoster(anime.imagem)],
      ),
    );
  }
}

class BlueBar extends StatelessWidget {
  final String image;

  BlueBar(this.image);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ControlledAnimation(
      duration: Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 250),
      builder: (context, animation) {
        return Container(
          height: animation,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
        );
      },
    );
  }
}

class MoviePoster extends StatelessWidget {
  String image;

  MoviePoster(this.image);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;
    return ControlledAnimation(
      duration: Duration(milliseconds: 600),
      delay: Duration(milliseconds: (300 * 2).round()),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.elasticInOut,
      builder: (context, scalevalue) {
        return Positioned(
          top: 170,
          left: 8,
          child: Transform.scale(
            scale: scalevalue,
            alignment: Alignment.center,
            child: Container(
              height: 140,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.5, 1.0),
                        blurRadius: 5,
                        color: Colors.white)
                  ]),
            ),
          ),
        );
      },
    );
  }
}

class Moviedata extends StatefulWidget {
  final String release, dname, rating;
  Icon icon;

  Moviedata({this.rating, this.release, this.dname});

  @override
  _MoviedataState createState() => _MoviedataState();
}

class _MoviedataState extends State<Moviedata> {
  List<Movieinfo> data = new List<Movieinfo>();

  @override
  void initState() {
    super.initState();
    data.add(new Movieinfo(
        "Rating",
        widget.rating,
        Icon(
          Icons.star_border,
          size: 46,
        )));
    data.add(new Movieinfo(
        "Release",
        widget.release,
        Icon(
          Icons.screen_lock_landscape,
          size: 46,
        )));
    data.add(new Movieinfo(
      "Genero",
      widget.dname,
      Icon(
        Icons.people_outline,
        size: 46,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 3 - 4,
      margin: EdgeInsets.only(top: 20),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, int index) {
            return Container(
              margin: EdgeInsets.only(
                  right: index == 0 ? 10 : 0,
                  left: index == data.length - 1 ? 10 : 0),
              width: MediaQuery.of(context).size.width / 3 - 23,
              height: MediaQuery.of(context).size.width / 3 - 23,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      data[index].rating,
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      data[index].release,
                      style:
                          TextStyle(fontFamily: 'MagnumSansBold', fontSize: 12),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    data[index].icon
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class Movieinfo {
  String rating, release;
  Icon icon;

  Movieinfo(this.rating, this.release, this.icon);
}
