import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  final String place;

  const Result({super.key, required this.place});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Future<Map<String, dynamic>> getDataFromAPI() async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=${widget.place}&appid=e3944ebf35eed5bc33dd34c0819d504f&units=metric"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception("Error");
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: const Text(
                "Tracking Result",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 78, 146, 128),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              )),
          body: Container(
            padding: const EdgeInsets.only(left: 105, right: 70),
            child: FutureBuilder(
                future: getDataFromAPI(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    const CircularProgressIndicator();
                  }
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image: NetworkImage(
                                  'https://flagsapi.com/${data["sys"]["country"]}/shiny/64.png')),
                          Text("Temperature: ${data["main"]["feels_like"]} °C",
                              style: TextStyle(fontSize: 20)),
                          Text("wind speed: ${data["wind"]["speed"]} m/s ",
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    );
                  } else {
                    return const Text("We couldn't find the place");
                  }
                }),
          )),
    );
  }
}
