import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weather App",
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      home: myhomepage(),
    );
  }
}

// ignore: camel_case_types
class myhomepage extends StatefulWidget {
  @override
  _myhomepageState createState() => _myhomepageState();
}

// ignore: camel_case_types
class _myhomepageState extends State<myhomepage> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;
  var pressure;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?q=Gunupur,21,91&appid=2783740742a6ccc7daa2c401b9f06c29"));
    var result = jsonDecode(response.body);
    setState(() {
      this.temp = (result['main']['temp'] - 273.15);
      this.description = result['weather'][0]['description'];
      this.currently = result['weather'][0]['main'];
      this.humidity = result['main']['humidity'];
      this.windspeed = result['wind']['speed'] / 0.277777777777778;
      this.pressure = result['main']['pressure'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/gradi.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.mapMarker,
                  color: Colors.black,
                  size: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Gunupur",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  temp != null
                      ? temp.toStringAsFixed(2) + "\u2103"
                      : "Loading..",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading..",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.thermometerHalf,
                      color: Colors.pink,
                    ),
                    title: Text(
                      "Temperature",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal),
                    ),
                    trailing: Text(
                      temp != null
                          ? temp.toStringAsFixed(2) + "\u00B0 "
                          : "Loading..",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.cloud,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      "Weather",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal),
                    ),
                    trailing: Text(
                      description != null
                          ? description.toString()
                          : "Loading..",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.solidSun,
                      color: Colors.orangeAccent,
                    ),
                    title: Text(
                      "Humidity",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal),
                    ),
                    trailing: Text(
                      humidity != null
                          ? humidity.toString() + " %"
                          : "Loading..",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.wind,
                      color: Colors.blueGrey,
                    ),
                    title: Text(
                      "Wind Speed",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal),
                    ),
                    trailing: Text(
                      windspeed != null
                          ? windspeed.toStringAsFixed(2) + " km/h"
                          : "Loading..",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.timesCircle,
                      color: Colors.red,
                    ),
                    title: Text(
                      "Pressure",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal),
                    ),
                    trailing: Text(
                      pressure != null
                          ? pressure.toString() + " hPa"
                          : "Loading..",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
