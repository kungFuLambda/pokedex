import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pokedex/objects/Pokemon.dart';
import 'package:pokedex/pokemonDetails.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard(
    this.pokemon, {
    super.key,
  });
  final Pokemon pokemon;

  List<Widget> typeWidgets() {
    List<Widget> ret = [];
    for (var pokeType in pokemon.types) {
      ret.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(20)),
          child: Text(pokeType)));
      ret.add(const SizedBox(
        height: 10,
      ));
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    const double imageSize = 100;
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetails(pokemon: pokemon),
          )),
      child: Container(
        height: _size.height * .02,
        margin: EdgeInsets.all(_size.width * .015),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: pokemon.types.first == "grass"
              ? Colors.greenAccent
              : pokemon.types.first == "fire"
                  ? Colors.redAccent
                  : pokemon.types.first == "water"
                      ? Colors.blue
                      : pokemon.types.first == "poison"
                          ? Colors.deepPurpleAccent
                          : pokemon.types.first == "electric"
                              ? Colors.amber
                              : pokemon.types.first == "rock"
                                  ? Colors.grey
                                  : pokemon.types.first == "ground"
                                      ? Colors.brown
                                      : pokemon.types.first == "psychic"
                                          ? Colors.indigo
                                          : pokemon.types.first == "fighting"
                                              ? Colors.orange
                                              : pokemon.types.first == "bug"
                                                  ? Colors.lightGreenAccent
                                                  : pokemon.types.first ==
                                                          "ghost"
                                                      ? Colors.deepPurple
                                                      : pokemon.types.first ==
                                                              "normal"
                                                          ? Colors.black26
                                                          : Colors.pink,
        ),
        child: Stack(children: [
          const Positioned(
            right: -70,
            bottom: -70,
            child: Image(
              image: AssetImage('assets/pokeball.png'),
              opacity: AlwaysStoppedAnimation(100),
              height: imageSize * 2,
              width: imageSize * 2,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Hero(
              tag: pokemon.name,
              child: CachedNetworkImage(
                fit: BoxFit.fitHeight,
                imageUrl: pokemon.urlPic,
                // height: imageSize,
                // width: imageSize,
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Text(
              "${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)}",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Positioned(
              left: 10,
              top: 35,
              child: Column(
                children: typeWidgets(),
              ))
        ]),
      ),
    );
  }
}
