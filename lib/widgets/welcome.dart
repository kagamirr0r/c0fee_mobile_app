import 'package:flutter/material.dart';
import '/widgets/weather.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("welcome"),
        ),
        drawer: Drawer(
            backgroundColor: Colors.white,
            child: ListView(children: [
              ListTile(
                  title: const Text('WeatherNews',
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
        body: Center(child: Text("ようこそ！")));
  }
}
