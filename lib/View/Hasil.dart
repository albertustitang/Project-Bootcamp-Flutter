import 'package:flutter/material.dart';

class Hasil extends StatefulWidget {
  String value, value2, value3, value4;
  Hasil(
      {Key? key,
        required this.value,
        required this.value2,
        required this.value3,
        required this.value4})
      : super(key: key);

  @override
  State<Hasil> createState() => _Hasil();
}

class _Hasil extends State<Hasil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 78, 182, 229),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 400,
                width: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.value3), fit: BoxFit.fill),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(widget.value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(
                height: 8,
              ),
              Text(widget.value2, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(
                height: 8,
              ),
              Text(widget.value4, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
            ],
          )),
    );
  }
}