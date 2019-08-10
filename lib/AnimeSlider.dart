import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'model/animeModel.dart';

class AnimeSlider extends StatelessWidget {
  final List<Anime> animes;

  AnimeSlider(this.animes);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        autoPlay: true,
        viewportFraction: 0.9,
        aspectRatio: 2.4,
        enlargeCenterPage: true,
        items: animes.map((anime) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(anime.imagem), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.2, 1.0),
                        blurRadius: 2,
                        color: Colors.white)
                  ]),
              // child: Image.network(url),
            ),
          );
        }).toList());
  }
}
