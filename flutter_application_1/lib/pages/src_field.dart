import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/result.dart';

class SrcField extends StatefulWidget {
  const SrcField({super.key});

  @override
  State<SrcField> createState() => _SrcField();
}

class _SrcField extends State<SrcField> {
  TextEditingController placeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Weather Tracking",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 78, 146, 128),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(hintText: "ex: Bandung"),
                controller: placeController,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Result(
                      place: placeController.text,
                    );
                  }));
                },
                child: const Text(
                  "Search",
                  style: TextStyle(color: Color.fromARGB(255, 78, 146, 128)),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
