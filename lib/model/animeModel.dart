import 'package:flutter/material.dart';

class Anime extends StatelessWidget {
  final int id;
  final String nome;
  final String desc;
  final bool status;
  final String imagem;
  final String ano;
  final String categoria;
  final int rank;

  Anime(
      {this.id,
      this.nome,
      this.desc,
      this.status,
      this.imagem,
      this.ano,
      this.categoria,
      this.rank});

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
        id: json['Id'],
        nome: json['Nome'],
        desc: json['Desc'],
        status: json['Status'],
        imagem: json['Imagem'],
        ano: json['Ano'],
        categoria: json['Categoria'],
        rank: json['Rank']);
  }

//  @override
//  String toString() {
//
//    return "id : " + id.toString() + "\n"
//         + "nome : " + nome.toString() + "\n"
//        + "desc : " + desc.toString() + "\n"
//        + "status : " + status.toString() + "\n"
//        + "imagem : " + imagem.toString() + "\n"
//        + "ano : " + ano.toString() + "\n"
//        + "categoria : " + categoria.toString() + "\n"
//        + "rank : " + rank.toString() + "\n";
//  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Column(
          children: <Widget>[
            Container(
              height: 140,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imagem),
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
            Container(
              //width: 100,
              //height: 40,
              child: Text(
                nome,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            Text(
              "Rank ${rank}",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
