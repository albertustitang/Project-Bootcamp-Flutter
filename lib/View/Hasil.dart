import 'package:flutter/material.dart';

class Hasil extends StatelessWidget {
  String value, value2, value3, value4;
  Hasil({Key? key, required this.value, required this.value2, required this.value3, required this.value4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(14),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return
                      Card(
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          child:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(value3, width: 150, height: 150,
                                  errorBuilder: (context, error, stackTracre){
                                    return Container(
                                      width: 70,
                                      height: 70,
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.error_outline, size: 16,),
                                    );
                                  }),
                              const SizedBox(height: 8,),
                              Text(value2, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8,),
                              Text(value, style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 8,),
                              Text(value4, style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 8,),
                            ],
                          ),
                        ),
                      );
                  },
                  itemCount: 1,
                ),
              ],
            )
        ),
      ),
    );
  }
}