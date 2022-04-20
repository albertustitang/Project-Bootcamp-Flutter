import 'package:flutter/material.dart';


class TambahKebun extends StatefulWidget {
  const TambahKebun({Key? key}) : super(key: key);

  @override
  State<TambahKebun> createState() => _TambahKebunState();
}

class _TambahKebunState extends State<TambahKebun> {
  var selectBibit;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: Colors.green,
        title: Text("Kebun"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(14),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: const
                          TextSpan(
                            text: 'Luas Kebun',
                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red)),
                            ]),),
                      SizedBox(height: 8,),
                      SizedBox(
                        height: 45,
                        width: width*0.4,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            suffixText: 'HA',
                            contentPadding: EdgeInsets.all(10),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                            text: 'Jenis Bibit',
                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: Colors.red,))
                            ]),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        height: 45,
                        width: width*0.4,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            isCollapsed: true,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          isExpanded: true,
                          value: selectBibit,
                          items: [
                            DropdownMenuItem(
                              child: Text("First Item"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("Second Item"),
                              value: 2,
                            )
                          ],
                          onChanged: (newValue) {
                            setState(() {
                              selectBibit = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                            text: 'Tipe Lahan',
                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: Colors.red,))
                            ]),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        height: 45,
                        width: width*0.4,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            isCollapsed: true,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          isExpanded: true,
                          value: selectBibit,
                          items: [
                            DropdownMenuItem(
                              child: Text("First Item"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("Second Item"),
                              value: 2,
                            )
                          ],
                          onChanged: (newValue) {
                            setState(() {
                              selectBibit = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
