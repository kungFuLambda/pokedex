import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pokedex/objects/Pokemon.dart';
import 'package:pokedex/pokemonCard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Pokedex'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Tween twe;

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              clipBehavior: Clip.none,
              height: _size.height * .15,
              child: Stack(
                children: [
                  Positioned(
                    left: _size.height * .02,
                    top: _size.height * .05,
                    child: Text(
                      'Pokedex',
                      style: TextStyle(
                          fontSize: _size.height * .04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Positioned(
                    right: -70,
                    top: -80,
                    child: Image(
                      image: AssetImage('assets/pokeball.png'),
                      // opacity: AlwaysStoppedAnimation(100),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 239, 239, 239),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Stack(children: [
                        Container(
                          child: Image(
                            image: AssetImage('assets/colouredPokeball.png'),
                          ),
                          height: 40,
                          width: 40,
                        ),
                        Container(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                          height: 40,
                          width: 40,
                        )
                      ]));
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (!snapshot.hasData) {
                        return Text('error');
                      } else {
                        var data = snapshot.data!;
                        List<Widget> listPokemons = [];
                        for (Pokemon pokemon in data) {
                          listPokemons.add(PokemonCard(pokemon));
                        }
                        return GridView.count(
                          physics: BouncingScrollPhysics(),
                          padding:
                              EdgeInsets.only(left: 15, right: 15, top: 20),
                          crossAxisCount: 2,
                          children: listPokemons,
                        );
                      }
                    }
                    return ListView();
                  },
                  future: getAllPokemons(150),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Pokemon>> getAllPokemons(int limit) async {
  String endpoint = "https://pokeapi.co/api/v2/pokemon?limit=$limit";
  var respo = await http.get(Uri.parse(endpoint));
  var res = json.decode(respo.body);
  List<Pokemon> pokemons = [];
  for (var pokemon in res['results']) {
    var respo = await http.get(Uri.parse(pokemon['url']));
    var res = json.decode(respo.body);
    var urlPic = res['sprites']['front_default'];
    var weight = res['weight'];
    var height = res['height'];
    //print(res['id']);
    List<String> poke_types = [];
    var types = res['types'];
    for (var type in types) {
      // print(type['type']['name']);
      poke_types.add(type['type']['name']);
    }
    var newPokemon = Pokemon(
        name: pokemon['name'],
        urlPic: urlPic,
        weight: weight,
        height: height,
        types: poke_types);

    pokemons.add(newPokemon);
  }
  pokemons.shuffle();
  return pokemons;
}
