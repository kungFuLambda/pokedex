import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'objects/Pokemon.dart';

class PokemonDetails extends StatelessWidget {
  PokemonDetails({required this.pokemon, super.key});
  Pokemon pokemon;

  List<Widget> getTypes() {
    List<Widget> ret = [];
    pokemon.types.forEach((element) {
      ret.add(Text(
        element,
        style: TextStyle(fontSize: 20),
      ));
      ret.add(SizedBox(
        width: 5,
      ));
    });
    return ret;
  }

  List<Widget> typeWidgets() {
    List<Widget> ret = [];
    for (var pokeType in pokemon.types) {
      ret.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(20)),
          child: Text(pokeType)));
      ret.add(const SizedBox(
        width: 10,
      ));
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: pokemon.types.first == "grass"
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
                                                : pokemon.types.first == "ghost"
                                                    ? Colors.deepPurple
                                                    : pokemon.types.first ==
                                                            "normal"
                                                        ? Colors.black26
                                                        : Colors.pink,
        body: Stack(children: [
          Positioned(
              top: _size.height * .01,
              left: _size.width * .01,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
              )),
          Positioned(
              top: _size.height * .09,
              left: _size.width * .05,
              child: Text(
                "${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)}",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              )),
          Positioned(
            top: _size.height * .2,
            child: Container(
                height: _size.height * .8,
                width: _size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.1,
                      scale: 0.1,
                      image: AssetImage('assets/pokeball.png'),
                    ),
                    color: Color.fromARGB(255, 239, 239, 239),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Types: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Row(children: typeWidgets()),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Height: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            pokemon.height.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Weight: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            pokemon.weight.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          Positioned(
            right: 0,
            top: _size.height * .09,
            height: _size.height * .2,
            width: _size.height * .2,
            child: Hero(
              tag: pokemon.name,
              child: CachedNetworkImage(
                imageUrl: pokemon.urlPic,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class AttributeContainer extends StatelessWidget {
  String name;
  dynamic value;
  AttributeContainer(this.name, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black12,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          name,
          textAlign: TextAlign.start,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(value.toString())
      ]),
    );
  }
}
