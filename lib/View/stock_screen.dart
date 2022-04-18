import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taniku/Model/response_stock_model.dart';
import 'package:taniku/View/pengiriman_screen.dart';
import 'package:taniku/ViewModel/stock_viewmodel.dart';
import 'package:taniku/Model/response_transaksi_model.dart';


class ReservasiAddScreen extends StatefulWidget {
  final DataTransaksi data_transaksi;

  const ReservasiAddScreen({Key? key,
    required this.data_transaksi,}) : super(key: key);

  @override
  State<ReservasiAddScreen> createState() => _ReservasiAddScreenState();

}

class _ReservasiAddScreenState extends State<ReservasiAddScreen> {
  String date = "";
  final pabrikController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final beratController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2099));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = selectedDate.toString().substring(0, 10);
      });
    }
  }

  Future<void>_selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if(timeOfDay != null && timeOfDay != selectedTime)
    {
      setState(() {
        selectedTime = timeOfDay;
        timeController.text = selectedTime.toString().substring(10, 15);
      });
    }
  }

  @override
  void initState() {
    pabrikController.text = widget.data_transaksi.namaPabrik.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReservasiAdd>(
      create: (context) => ReservasiAdd(context),
      child: Builder(
        builder: (context) {
          return Consumer<ReservasiAdd>(
              builder: (context, viewModel, child) {
                return Scaffold(
                    appBar: AppBar(
                      title: Text("Kirim Persediaan Stok"),
                      backgroundColor: Colors.green,
                      actions: [
                        IconButton(
                            onPressed: () {

                            },
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.white,
                            )
                        ),
                      ],
                    ),
                    body: SingleChildScrollView(
                        child: Container(
                            margin: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                const Text("Nama PKS", style: const TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.normal)),
                                const SizedBox(height: 8,),
                                TextFormField(
                                    controller: pabrikController,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(33)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(33)),
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      fillColor: Colors.black26,
                                      filled: true,
                                    )
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: 'Tanggal Pengiriman',
                                                  style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                                ),
                                                WidgetSpan(
                                                  child: Transform.translate(
                                                    offset: const Offset(2, -4),
                                                    child: const Text(
                                                      '*',
                                                      //superscript is usually smaller in size
                                                      textScaleFactor: 1,
                                                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                        ),
                                        const SizedBox(height: 8,),
                                        SizedBox(
                                          width: 180,
                                          child: TextFormField(
                                            readOnly: true,
                                            style: const TextStyle(color: Colors.black45),
                                            controller: dateController,
                                            decoration: InputDecoration(
                                                focusedBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(32)),
                                                    borderSide: BorderSide(color: Colors.black54, width: 0.0)
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(32)),
                                                    borderSide: BorderSide(color: Colors.black54, width: 0.0)
                                                ),
                                                hintText: "DD/MM/YYYY",
                                                suffixIcon: IconButton(
                                                  icon: Icon(Icons.date_range_rounded),
                                                  onPressed: () {
                                                    setState(() {
                                                      _selectDate(context);
                                                    });
                                                  },
                                                  color: Colors.grey,
                                                ),
                                                labelStyle: const TextStyle(
                                                    color: Colors.grey
                                                )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: 'Jam Pengiriman',
                                                  style: TextStyle(fontSize: 16, color: Colors.black,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                WidgetSpan(
                                                  child: Transform.translate(
                                                    offset: const Offset(2, -4),
                                                    child: const Text(
                                                      '*',
                                                      //superscript is usually smaller in size
                                                      textScaleFactor: 1,
                                                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                        ),
                                        const SizedBox(height: 8,),
                                        SizedBox(
                                          width: 180,
                                          child: TextFormField(
                                            readOnly: true,
                                            style: const TextStyle(color: Colors.black45),
                                            controller: timeController,
                                            decoration: InputDecoration(
                                                focusedBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(32)),
                                                    borderSide: BorderSide(color: Colors.black54, width: 0.0)
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(32)),
                                                    borderSide: BorderSide(color: Colors.black54, width: 0.0)
                                                ),
                                                hintText: "HH:MM",
                                                suffixIcon: IconButton(
                                                  icon: Icon(Icons.alarm),
                                                  onPressed: () {
                                                    setState(() {
                                                      _selectTime(context);
                                                    });
                                                  },
                                                  color: Colors.grey,
                                                ),
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey
                                                )
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                const Text("Estimasi Tonasi TBS (/Kg)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                SizedBox(height: 8,),
                                TextFormField(
                                  controller: beratController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(32)),
                                        borderSide: BorderSide(color: Colors.black54, width: 0.0)
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(32)),
                                        borderSide: BorderSide(color: Colors.black54, width: 0.0)
                                    ),
                                  ),
                                ),
                                SizedBox(height: 260,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        width: 150,
                                        height: 50,
                                        child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(width: 2.0, color: Colors.deepOrange),

                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()),);
                                            },
                                            child: const Text("Batal", style: TextStyle(color: Colors.orange),)
                                        )
                                    ),
                                    Container(
                                      // margin: EdgeInsets.all(20),
                                      width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Colors.orange, Colors.deepOrange],
                                          begin: FractionalOffset.bottomLeft,
                                          end: FractionalOffset.topRight,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextButton(
                                        child: const Text(
                                          'Kirim',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          String pabrikid = widget.data_transaksi.id.toString();
                                          String namapabrik = pabrikController.text.toString();
                                          String tanggal = dateController.text.toString();
                                          String waktu = timeController.text.toString();
                                          String tonasi = beratController.text.toString();

                                          viewModel.getReservasiadd(pabrikid, namapabrik, tanggal, waktu, tonasi, context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                        )
                    )
                );
              });
        },
      ),
    );
  }
}

