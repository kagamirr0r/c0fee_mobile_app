import 'dart:convert';
import 'package:flutter/material.dart';
import 'models/weather.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

Future<Weather> fetchWeather() async {
  const place = 'Kyoto';

  var url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$place&appid={token}&lang=ja');

  var res = await http.get(url);

  if (res.statusCode == 200) {
    var body = res.body;
    var json = jsonDecode(body);
    var model = Weather.fromJson(json);

    return model;
  } else {
    throw Exception('Failed to load weather');
  }
}

class WeatherNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("WeatherNews"),
        ),
        drawer: Drawer(
            backgroundColor: Colors.white,
            child: ListView(children: [
              ListTile(
                  title: Text('Home',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return const MyHomePage(
                            title: 'Flutter Demo Home Page');
                      }),
                    );
                  }),
            ])),
        body: FutureBuilder(
            future: fetchWeather(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                // Data fetched successfully, display your data here
                return Center(
                    child: Text(
                        snapshot.data.place + 'は' + snapshot.data.description,
                        style: TextStyle(fontSize: 24)));
              } else if (snapshot.hasError) {
                // If something went wrong
                return Text('Something went wrong...');
              }
              // While fetching, show a loading spinner.
              return Center(child: CircularProgressIndicator());
            }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(children: [
            ListTile(
                title: Text('WeatherNews',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return WeatherNews();
                    }),
                  );
                }),
          ])),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
