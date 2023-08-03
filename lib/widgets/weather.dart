import 'package:flutter/material.dart';

import '/main.dart';
import '/api/wheather.dart';

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
                  title: const Text('Home',
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
                return Center(
                    child: Text(
                        snapshot.data.place + 'は' + snapshot.data.description,
                        style: TextStyle(fontSize: 24)));
              } else if (snapshot.hasError) {
                return Text('Something went wrong...');
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
