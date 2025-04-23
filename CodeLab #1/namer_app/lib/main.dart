import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  //Tells Flutter to tun the app defined in MyApp
  runApp(MyApp());
}

//Code in MyApp setsup the whole app and creates the app=wide state
//It names the app, defines the visual theme, and sets the home widget
//Widgets are the elements from which you build every F;uuter app
//Think building blocks
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Build method automatically called every time the widget's circumstamces change. Keeps Widget up to date
    //ChangeNotifierProvider- allows any widget in the app to get hold of the state
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),
        home:
            MyHomePage(), //Tracks changes to the apps current state using the watch method
      ),
    );
  }
}

//MyAppState defines the data the app needs to function
//Change notifier, notifies others (Widgets) anbout its own changes
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  //getNext() method reassigns current with a new random wordpair
  //Also calls notifyListeners()- a method of changeNotifier that ensures that anyone watching MyAppState is notified
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

// ...

class MyHomePage extends StatefulWidget {
  @override
  //Extemds state and can therefore manage its own values (It can change itself)
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // ...

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

// ...
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              //SafeArea ensures the child is not obscured by a hardware notch or status bar
              //It wraps around the NavigationRail to prevent the navigation buttons from being obscured by a mobile status bar
              child: NavigationRail(
                extended: true, //Shows the labels next to the icon
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                ],
                selectedIndex:
                    selectedIndex, //selects the first destination, index of 1 selects the second destination
                onDestinationSelected: (value) {
                  //Tells what happens when the user selects a destination
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              //let you express layouts where some children take only as much space as they need
              //expanded=takes up space
              //Two Expanded widgets split all the available horizontal space between themselves
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ...

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return Center(
        child: Text('No Favorites yet.'),
      );
    }
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text('You have'
            '${appState.favorites.length} favorites: '),
      ),
      for (var pair in appState.favorites)
        ListTile(leading: Icon(Icons.favorite), title: Text(pair.asLowerCase))
    ]);
  }
}
