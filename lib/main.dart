import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Text(
//       'aaaaaaaaa',
//       textDirection: TextDirection.ltr,
//       style: TextStyle(fontSize: 20),
//     ));
//   }
// }

// class MyAppBar extends StatelessWidget {
//   final Widget title;
//   MyAppBar({this.title});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 45.0,
//         margin: EdgeInsets.symmetric(vertical: 20),
//         decoration: BoxDecoration(color: Colors.teal),
//         child: Row(
//           children: <Widget>[
//             IconButton(
//                 icon: Icon(Icons.menu), onPressed: null, tooltip: 'menu'),
//             Expanded(child: title),
//             IconButton(
//               icon: Icon(Icons.menu_book),
//               onPressed: null,
//               tooltip: 'menu book',
//             )
//           ],
//         ));
//   }
// }

// class MyScaffold extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//         child: Column(
//       children: <Widget>[
//         MyAppBar(
//             title: Text(
//           'hihi',
//           style: Theme.of(context).primaryTextTheme.bodyText1,
//           textAlign: TextAlign.center,
//         )),
//         Expanded(
//             child: Center(
//           child: Text('my body'),
//         )),
//       ],
//     ));
//   }
// }

// void main() {
//   runApp(MaterialApp(title: 'aaaa', home: MyScaffold()));
// }

// class _RandomWordsState extends State<RandomWords> {
//   final _suggestions = <WordPair>[];
//   final _saved = Set<WordPair>();
//   final _biggerFont = TextStyle(fontSize: 18.0);
//   @override
//   Widget build(BuildContext context) {
//     return _buildSuggestions();
//   }

//   Widget _buildSuggestions() {
//     return ListView.builder(itemBuilder: (context, i) {
//       if (i.isOdd) return Divider(); /*2*/

//       final index = i ~/ 2; /*3*/
//       if (index >= _suggestions.length) {
//         _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//       }
//       return _buildRow(_suggestions[index]);
//     });
//   }

//   Widget _buildRow(WordPair text) {
//     final alreadySaved = _saved.contains(text);
//     return Container(
//         margin: const EdgeInsets.all(4.0),
//         padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//         child: ListTile(
//           title: Text(text.asString, style: _biggerFont),
//           trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
//               color: alreadySaved ? Colors.red : null),
//           onTap: () => setSave(text, alreadySaved),
//         ));
//   }

//   void setSave(WordPair text, bool alreadySaved) {
//     setState(() {
//       if (alreadySaved) {
//         _saved.remove(text);
//       } else {
//         _saved.add(text);
//       }
//     });
//   }
// }

//  Widget renderRow(WordPair text) {
//       return Container(
//           margin: const EdgeInsets.all(4.0),
//           padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//           child: ListTile(
//             title: Expanded(child: Text(text.asString)),
//           ));
//     }

//     void _pushSaved() {
//       // final listSuggest = context.read<ListWords>()._saved.toList();

//       Navigator.of(context)
//           .push(MaterialPageRoute<void>(builder: (BuildContext context) {
//         return Scaffold(
//             appBar: AppBar(
//                 title: Text('List Saved',
//                     style: TextStyle(fontSize: 18, color: Colors.white))),
//             body: Text('aaaaaaaa'));
//       }));
//     }

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }

  Widget _buildSuggestions() {
    final listSuggest = context.read<ListWords>()._suggestions;
    return ListView.builder(itemBuilder: (context, i) {
      if (i.isOdd) return Divider(); /*2*/

      final index = i ~/ 2; /*3*/
      if (index >= listSuggest.length) {
        context
            .read<ListWords>()
            .addAllListSuggestion(generateWordPairs().take(10));
      }
      return _buildRow(listSuggest[index]);
    });
  }

  Widget _buildRow(WordPair text) {
    final listSaved = context.watch<ListWords>()._saved;

    final alreadySaved = listSaved.contains(text);
    return Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: ListTile(
          title: Text(text.asString, style: _biggerFont),
          trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null),
          onTap: () => setSave(text, alreadySaved),
        ));
  }

  void setSave(WordPair text, bool alreadySaved) {
    if (alreadySaved) {
      context.read<ListWords>().removeSaved(text);
    } else {
      context.read<ListWords>().addSaved(text);
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'First App',
        home: Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.menu_open), onPressed: null),
                Expanded(
                    child: Container(
                        color: Colors.blue,
                        child: Text(
                          'List',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ))),
                IconButton(icon: Icon(Icons.menu_open), onPressed: null)
              ],
            ),
          ),
          body: RandomWords(),
        ));
  }
}

class ListWords with ChangeNotifier {
  List<WordPair> _suggestions = [];

  Set<WordPair> _saved = {};

  List<WordPair> getList() => _suggestions;

  Set<WordPair> getSave() => _saved;

  void addAllListSuggestion(Iterable<WordPair> list) {
    _suggestions.addAll(list);
    notifyListeners();
  }

  void addSaved(WordPair text) {
    _saved.add(text);
    notifyListeners();
  }

  void removeSaved(WordPair text) {
    _saved.remove(text);
    notifyListeners();
  }
}

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ListWords()),
    ],
    child: MyApp(),
  ));
}
