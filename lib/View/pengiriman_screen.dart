import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taniku/ViewModel/pengiriman_viewmodel.dart';

class PengirimanPages extends StatefulWidget {
  const PengirimanPages({Key? key}) : super(key: key);

  @override
  State<PengirimanPages> createState() => _PengirimanPagesState();
}

class _PengirimanPagesState extends State<PengirimanPages> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate) {
      setState(() {
        // selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        timeController.text = selectedTime.toString().substring(10, 15);
        print(selectedTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PengirimanViewModel>(
      create: (context) => PengirimanViewModel(context),
      child: Builder(
          builder: (context) {
            return Consumer<PengirimanViewModel>(
                builder: (context, viewModel, child) {
                  return RefreshIndicator(
                    displacement: 150,
                    color: Colors.white10,
                    strokeWidth: 5,
                    triggerMode: RefreshIndicatorTriggerMode.onEdge,
                    child: Scaffold(
                      appBar: AppBar(
                        title: Text("Daftar Reservasi Pengiriman TBS"),
                        backgroundColor: Colors.green,
                        actions: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notifications,
                                color: Colors.white,
                              )
                          ),
                        ],
                      ),
                      body: Container(
                        margin: const EdgeInsets.all(8),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: viewModel.listPengiriman.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Card(
                                            child: Row(
                                              children: [
                                                Column(),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(width: 8,),
                                                        Icon(Icons
                                                            .home_work_outlined,
                                                          size: 60,),
                                                        SizedBox(width: 18,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 16,),
                                                            Row(
                                                              children: [
                                                                Text(viewModel
                                                                    .listPengiriman[index].tanggalPengiriman.toString(),
                                                                    style: const TextStyle(
                                                                        fontSize: 16)),
                                                                SizedBox(
                                                                  width: 50,),
                                                                Text(viewModel.listPengiriman[index].statusName.toString(),
                                                                    style: const TextStyle(
                                                                        fontSize: 14,
                                                                        fontStyle: FontStyle
                                                                            .italic,
                                                                        color: Colors
                                                                            .lightGreen
                                                                    )
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 8,),
                                                            Text(viewModel
                                                                .listPengiriman[index].noReservasi.toString(),
                                                                style: const TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                            SizedBox(
                                                              height: 8,),
                                                            Text(viewModel.listPengiriman[index].namaPabrik.toString(),
                                                                style: const TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight
                                                                        .bold)),
                                                            SizedBox(
                                                              height: 8,),
                                                            Row(
                                                              children: [
                                                                Text(viewModel.listPengiriman[index].tonasi.toString(),
                                                                    style: const TextStyle(
                                                                        fontSize: 16,
                                                                        color: Colors
                                                                            .lightGreen,
                                                                        fontWeight: FontWeight
                                                                            .bold)),
                                                                SizedBox(
                                                                  width: 10,),
                                                                Text("kg",
                                                                    style: const TextStyle(
                                                                        fontSize: 16,
                                                                        color: Colors
                                                                            .lightGreen,
                                                                        fontWeight: FontWeight
                                                                            .bold)),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 8,),
                                                            Row(children: [
                                                              if(viewModel
                                                                  .listPengiriman[index].status.toString() == "1") ... [
// QR Code//
                                                                ElevatedButton.icon(
                                                                    onPressed: () async {
                                                                      setState(() {
                                                                        showDialog(
                                                                            context: context, builder: (_) =>
                                                                            AlertDialog(
                                                                              // contentPadding: EdgeInsets.only(left: 100, right: 100, top: 30, bottom: 50),
                                                                              titlePadding: EdgeInsets.all(0),
                                                                              title: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: [
                                                                                  Container(
                                                                                    height: 50,
                                                                                    width: 200,
                                                                                    color: Colors.green,
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.only(
                                                                                          left: 15,
                                                                                          top: 15),
                                                                                      child: Text(
                                                                                        'Lihat QR',
                                                                                        style: TextStyle(
                                                                                          color: Colors.white,),),
                                                                                    ),),
                                                                                  Container(
                                                                                    height: 50,
                                                                                    width: 112.5,
                                                                                    color: Colors.green,
                                                                                    child: IconButton(
                                                                                      onPressed: () {
                                                                                        Navigator.of(context, rootNavigator: true).pop(context);
                                                                                      },
                                                                                      icon: new Icon(
                                                                                        Icons.close,
                                                                                        color: Colors.white,),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              content:
                                                                              SizedBox(
                                                                                width: 200,
                                                                                height: 200,
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    QrImage(
                                                                                      data: viewModel.listPengiriman[index].noReservasi.toString(),
                                                                                      version: QrVersions.auto,
                                                                                      size: 150,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 12,),
                                                                                    Text(
                                                                                      viewModel.listPengiriman[index].noReservasi
                                                                                          .toString(),
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              actions: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 250,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                                                                        gradient: const LinearGradient(
                                                                                            colors: [
                                                                                              Colors.orange,
                                                                                              Colors.deepOrange],
                                                                                          begin: FractionalOffset.bottomLeft,
                                                                                          end: FractionalOffset.topRight,
                                                                                        ),
                                                                                      ),
                                                                                      child: TextButton(
                                                                                        onPressed: () {
                                                                                          Navigator.of(context, rootNavigator: true).pop(context);
                                                                                        },
                                                                                        style:
                                                                                        ElevatedButton.styleFrom(
                                                                                            primary: Colors.transparent,
                                                                                            shadowColor: Colors.transparent),
                                                                                        child: Text('Kembali',
                                                                                          style: TextStyle(
                                                                                              fontWeight: FontWeight.bold, color: Colors.white),),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ));
                                                                      });
                                                                    },
                                                                    icon: Icon(Icons.qr_code_scanner_rounded,
                                                                      color: Colors.orange,
                                                                      size: 30,
                                                                    ),
                                                                    label: Text(""),
                                                                    style: ElevatedButton.styleFrom(primary: Colors.white)
                                                                ),
                                                                SizedBox(
                                                                  width: 10,),
// Jadwal Ulang//
                                                                ElevatedButton(
                                                                  onPressed: () async {
                                                                    setState(() {
                                                                      showDialog(context: (context), builder: (_)=>
                                                                          AlertDialog(
                                                                            shape: const RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                                            titlePadding: const EdgeInsets.all(0),
                                                                            title: Container(
                                                                              decoration: const BoxDecoration(
                                                                                  color: Colors.green,
                                                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 2),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    const Text("Reschedule Pengiriman TBS", style: TextStyle(color: Colors.white),),
                                                                                    IconButton(
                                                                                        onPressed: () {
                                                                                          Navigator.of(context, rootNavigator: true).pop(context);},
                                                                                        icon: const Icon(Icons.close, color: Colors.white,))
                                                                                  ],),
                                                                              ),
                                                                            ),
                                                                            content: Container(
                                                                              height: 200,
                                                                              width:  300,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  RichText(
                                                                                    textAlign: TextAlign.center,
                                                                                    text: TextSpan(
                                                                                        children: [
                                                                                          const TextSpan(
                                                                                            text: 'Tanggal',
                                                                                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                          ),
                                                                                          WidgetSpan(
                                                                                            child: Transform.translate(
                                                                                              offset: const Offset(2, -4),
                                                                                            ),
                                                                                          ),
                                                                                        ]),
                                                                                  ),
                                                                                  const SizedBox(height: 8,),
                                                                                  SizedBox(
                                                                                    width: 300,
                                                                                    child: TextFormField(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          _selectDate(context);
                                                                                        });
                                                                                      },
                                                                                      style: const TextStyle(color: Colors.black),
                                                                                      controller: dateController,
                                                                                      decoration: InputDecoration(
                                                                                        focusedBorder: const OutlineInputBorder(
                                                                                            borderRadius: BorderRadius.all(Radius.circular(32)),
                                                                                            borderSide: BorderSide(color: Colors.black12, width: 0.0)
                                                                                        ),
                                                                                        enabledBorder: OutlineInputBorder(
                                                                                            borderRadius: BorderRadius.all(Radius.circular(32)),
                                                                                            borderSide: BorderSide(color: Colors.black12, width: 0.0)
                                                                                        ),
                                                                                        hintText: "DD/MM/YYYY",
                                                                                        suffixIcon: IconButton(
                                                                                          icon: Icon(Icons.close),
                                                                                          onPressed: () {
                                                                                            dateController.clear();
                                                                                          },
                                                                                          color: Colors.black,
                                                                                        ),
                                                                                        labelStyle: const TextStyle(
                                                                                            color: Colors.grey
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      RichText(
                                                                                        textAlign: TextAlign.center,
                                                                                        text: TextSpan(
                                                                                            children: [
                                                                                              const TextSpan(
                                                                                                text: 'Jam',
                                                                                                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                              WidgetSpan(
                                                                                                child: Transform.translate(
                                                                                                  offset: const Offset(2, -4),
                                                                                                ),
                                                                                              )
                                                                                            ]),
                                                                                      ),
                                                                                      const SizedBox(height: 8,),
                                                                                      SizedBox(
                                                                                        width: 300,
                                                                                        child: TextFormField(
                                                                                          onTap: () {
                                                                                            setState(() {
                                                                                              _selectTime(context);
                                                                                            });
                                                                                          },
                                                                                          readOnly: true,
                                                                                          style: const TextStyle(color: Colors.black),
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
                                                                                                icon: Icon(Icons.close),
                                                                                                onPressed: () {
                                                                                                  timeController.clear();
                                                                                                },
                                                                                                color: Colors.black,
                                                                                              ),
                                                                                              hintStyle: const TextStyle(
                                                                                                  color: Colors.grey
                                                                                              )
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            actions: [ Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                SizedBox(
                                                                                    width: 120,
                                                                                    height: 50,
                                                                                    child: OutlinedButton(
                                                                                        style: OutlinedButton.styleFrom(
                                                                                          side: const BorderSide(width: 1.0, color: Colors.orange),
                                                                                          shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(32.0)
                                                                                          ),
                                                                                        ),
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                        child: const Text("Tidak, Ubah", style: TextStyle(color: Colors.orange),)
                                                                                    )
                                                                                ),
                                                                                Container(
                                                                                  // margin: EdgeInsets.all(20),
                                                                                  width: 120,
                                                                                  height: 50,
                                                                                  decoration: BoxDecoration(
                                                                                    gradient: const LinearGradient(
                                                                                      colors: [Colors.orange, Colors.deepOrange],
                                                                                      begin: FractionalOffset.bottomLeft,
                                                                                      end: FractionalOffset.topRight,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(32),
                                                                                  ),
                                                                                  child: TextButton(
                                                                                    child: const Text('Ya,Benar',
                                                                                      style: TextStyle(color: Colors.white),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      String noRes = viewModel.listPengiriman[index].noReservasi.toString();
                                                                                      String petaniId = viewModel.listPengiriman[index].petaniId.toString();
                                                                                      String tanggal = dateController.text.toString();
                                                                                      String waktu = timeController.text.toString();

                                                                                      viewModel.getStockEdit(noRes, petaniId, tanggal, waktu, context);
                                                                                      // Navigator.pop(context);
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                              const SizedBox(height: 16,)
                                                                            ],
                                                                          ),
                                                                      );
                                                                    });

                                                                  },
                                                                  child: Text("Jadwal Ulang"),
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    primary: Colors
                                                                        .orange,
                                                                    shape: new RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius
                                                                          .circular(
                                                                          16),
                                                                    ),
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 14,
                                                                        vertical: 12),
                                                                  ),
                                                                ),
                                                              ]
                                                              else
                                                                if(viewModel
                                                                    .listPengiriman[index]
                                                                    .status
                                                                    .toString() ==
                                                                    "2") ... [
// Faktur//
                                                                  ElevatedButton(
                                                                    onPressed: () {},
                                                                    child: Text("Faktur"),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      primary: Colors
                                                                          .lightGreen,
                                                                      shape: new RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius
                                                                            .circular(
                                                                            16),
                                                                      ),
                                                                      padding: EdgeInsets
                                                                          .symmetric(
                                                                          horizontal: 14,
                                                                          vertical: 12),
                                                                    ),
                                                                  ),
                                                                ],
                                                            ],
                                                            ),
                                                            SizedBox(height: 16,),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onRefresh: () async {
                      await Future.delayed(Duration(milliseconds: 1500));
                      setState(() {
                        viewModel.getListPengiriman(context);
                      });
                    },
                  );
                  // return RefreshIndicator(
                  //   displacement: 250,
                  //   backgroundColor: Colors.yellow,
                  //   color: Colors.red,
                  //   strokeWidth: 3,
                  //   triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  //   onRefresh: () async {
                  //     await Future.delayed(const Duration(milliseconds: 1500));
                  //     setState(() {
                  //       var itemCount = viewModel.getListPengiriman(context);
                  //       itemCount;
                  //     });
                  //   },
                  //   child: Scaffold(
                  //     resizeToAvoidBottomInset: false,
                  //     appBar: AppBar(
                  //       backgroundColor: Colors.green,
                  //       title: const Text("Data Reservasi Pengiriman TBS"),
                  //       actions: [
                  //         IconButton(
                  //           color: Colors.white,
                  //           icon: const Icon(
                  //             Icons.notifications,
                  //           ),
                  //           onPressed: () {
                  //
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //     body: SingleChildScrollView(
                  //       child: Container(
                  //         margin: const EdgeInsets.all(8),
                  //         child: Column(
                  //           children: [
                  //             ListView.builder(
                  //               shrinkWrap: true,
                  //               physics: const NeverScrollableScrollPhysics(),
                  //               itemBuilder: (context, index) {
                  //                 var pengiriman = viewModel.listPengiriman[index];
                  //                 var _status = int.parse(pengiriman.status.toString());
                  //                 DateTime dt = DateTime.parse(pengiriman.tanggalPengiriman.toString());
                  //                 final DateFormat formatter = DateFormat('dd MMMM yyyy');
                  //                 return SizedBox(
                  //                     height: 220,
                  //                     width: double.infinity,
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.all(16),
                  //                       child: Column(
                  //                         children: [
                  //                           Row(
                  //                             children: [
                  //                               const SizedBox(
                  //                                 child: CircleAvatar(
                  //                                   // backgroundImage: AssetImage('assets/images/google_icon.png'),
                  //                                   radius: 40,
                  //                                 ),
                  //                               ),
                  //                               const SizedBox(width: 16,),
                  //                               Column(
                  //                                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                                 children: [
                  //                                   Row(
                  //                                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                                     children: [
                  //                                       Text(formatter.format(dt), style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  //                                       // Text(pengiriman.tanggalPengiriman.toString().substring(0, 10), style: TextStyle(color: Colors.grey, fontSize: 12),),
                  //                                       const SizedBox(width: 120,),
                  //                                       Text(
                  //                                         pengiriman.statusName.toString(),
                  //                                         style: const TextStyle(
                  //                                             color: Colors.green,
                  //                                             fontSize: 12,
                  //                                             fontStyle: FontStyle.italic
                  //                                         ),
                  //                                       ),
                  //                                     ],
                  //                                   ),
                  //                                   const SizedBox(height: 8,),
                  //                                   Text(pengiriman.noReservasi.toString(), style: const TextStyle(fontSize: 16),),
                  //                                   const SizedBox(height: 8,),
                  //                                   Text("${pengiriman.tonasi.toString()} kg", style: const TextStyle(color: Colors.green),),
                  //                                   const SizedBox(height: 8,),
                  //                                   Row(
                  //                                     children: [
                  //                                       Visibility(
                  //                                         visible: _status == 1 ? true : false,
                  //                                         replacement: const SizedBox(width: 80,),
                  //                                         child: InkWell(
                  //                                           onTap: () {
                  //                                             setState(() {
                  //                                               showDialog(
                  //                                                   context: context,
                  //                                                   builder: (_) => AlertDialog(
                  //                                                     shape: const RoundedRectangleBorder(
                  //                                                         borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  //                                                     titlePadding: const EdgeInsets.all(0),
                  //                                                     // backgroundColor: HexColor(dataListColor[index].color.toString()),
                  //                                                     title: Container(
                  //                                                         decoration: const BoxDecoration(
                  //                                                             color: Colors.green,
                  //                                                             borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                  //                                                         ),
                  //                                                         child: Padding(
                  //                                                           padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  //                                                           child: Row(
                  //                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                                             children: [
                  //                                                               const Text("Lihat QR", style: TextStyle(color: Colors.white),),
                  //                                                               IconButton(
                  //                                                                   onPressed: () {Navigator.of(context).pop();},
                  //                                                                   icon: const Icon(Icons.close, color: Colors.white,)
                  //                                                               )
                  //                                                             ],
                  //                                                           ),
                  //                                                         )
                  //                                                     ),
                  //                                                     content:
                  //                                                     SizedBox(
                  //                                                         width: 150,
                  //                                                         height: 220,
                  //                                                         child: Column(
                  //                                                           mainAxisAlignment: MainAxisAlignment.center,
                  //                                                           children: [
                  //                                                             QrImage(
                  //                                                               data: pengiriman.noReservasi.toString(),
                  //                                                               version: QrVersions.auto,
                  //                                                               size: 200,
                  //                                                             ),
                  //                                                             Text(pengiriman.noReservasi.toString())
                  //                                                           ],
                  //                                                         )
                  //                                                     ),
                  //                                                     actions: [
                  //                                                       Row(
                  //                                                         mainAxisAlignment: MainAxisAlignment.center,
                  //                                                         children: [
                  //                                                           Container(
                  //                                                             width: 200,
                  //                                                             height: 50,
                  //                                                             decoration: BoxDecoration(
                  //                                                               gradient: const LinearGradient(
                  //                                                                 colors: [Colors.orange, Colors.deepOrange],
                  //                                                                 begin: FractionalOffset.bottomLeft,
                  //                                                                 end: FractionalOffset.topRight,
                  //                                                               ),
                  //                                                               borderRadius: BorderRadius.circular(32),
                  //                                                             ),
                  //                                                             child: TextButton(
                  //                                                               child: const Text(
                  //                                                                 'Kembali',
                  //                                                                 style: TextStyle(color: Colors.white),
                  //                                                               ),
                  //                                                               onPressed: () {
                  //                                                                 Navigator.of(context).pop();
                  //                                                               },
                  //                                                             ),
                  //                                                           ),
                  //                                                         ],
                  //                                                       ),
                  //                                                       const SizedBox(height: 16,)
                  //                                                     ],
                  //                                                   )
                  //                                               );
                  //                                             });
                  //                                           },
                  //                                           child: Image.asset("assets/images/barcode.png", height: 50,),
                  //                                         ),
                  //                                       ),
                  //                                       const SizedBox(width: 16,),
                  //                                       Visibility(
                  //                                         visible: _status == 1 ? true : false,
                  //                                         replacement: const SizedBox(width: 80,),
                  //                                         child: InkWell(
                  //                                             onTap: () {},
                  //                                             child: Container(
                  //                                               // margin: EdgeInsets.all(20),
                  //                                               width: 105,
                  //                                               height: 45,
                  //                                               decoration: BoxDecoration(
                  //                                                 borderRadius: BorderRadius.circular(16),
                  //                                                 gradient: const LinearGradient(
                  //                                                   colors: [Colors.orange, Colors.deepOrange],
                  //                                                   begin: FractionalOffset.bottomLeft,
                  //                                                   end: FractionalOffset.topRight,
                  //                                                 ),
                  //                                               ),
                  //                                               child: TextButton(
                  //                                                 child: const Text(
                  //                                                   'Jadwal Ulang',
                  //                                                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  //                                                 ),
                  //                                                 onPressed: () {
                  //                                                   final dateController = TextEditingController(text: viewModel.listPengiriman[index].tanggalPengiriman.toString().substring(0,11));
                  //                                                   final timeController = TextEditingController(text: viewModel.listPengiriman[index].tanggalPengiriman.toString().substring(11,16));
                  //                                                   setState(() {
                  //                                                     showDialog(
                  //                                                         context: context,
                  //                                                         builder: (_) => AlertDialog(
                  //                                                           shape: const RoundedRectangleBorder(
                  //                                                               borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  //                                                           titlePadding: const EdgeInsets.all(0),
                  //                                                           // backgroundColor: HexColor(dataListColor[index].color.toString()),
                  //                                                           title: Container(
                  //                                                               decoration: const BoxDecoration(
                  //                                                                   color: Colors.green,
                  //                                                                   borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                  //                                                               ),
                  //                                                               child: Padding(
                  //                                                                 padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  //                                                                 child: Row(
                  //                                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                                                                   children: [
                  //                                                                     const Text("Reschedule Pengiriman TBS", style: TextStyle(color: Colors.white),),
                  //                                                                     IconButton(
                  //                                                                         onPressed: () {
                  //                                                                           Navigator.of(context).pop();
                  //                                                                         },
                  //                                                                         icon: const Icon(Icons.close, color: Colors.white,)
                  //                                                                     )
                  //                                                                   ],
                  //                                                                 ),
                  //                                                               )
                  //                                                           ),
                  //                                                           content:
                  //                                                           SizedBox(
                  //                                                               width: 150,
                  //                                                               height: 150,
                  //                                                               child: Column(
                  //                                                                 mainAxisAlignment: MainAxisAlignment.center,
                  //                                                                 children: [
                  //                                                                   SizedBox(
                  //                                                                     width: 180,
                  //                                                                     child: TextFormField(
                  //                                                                       // initialValue: viewModel.listPengiriman[index].tanggalPengiriman.toString().substring(0, 11),
                  //                                                                       onTap: () async {
                  //                                                                         await showDatePicker(
                  //                                                                             context: context,
                  //                                                                             initialDate: DateTime.now(),
                  //                                                                             firstDate: DateTime(2000),
                  //                                                                             lastDate: DateTime(2099)
                  //                                                                         ).then((selectedDate) {
                  //                                                                           if (selectedDate != null){
                  //                                                                             dateController.text = selectedDate.toString().substring(0, 11);
                  //                                                                           }
                  //                                                                         });
                  //                                                                       },
                  //                                                                       readOnly: true,
                  //                                                                       style: const TextStyle(color: Colors.black45),
                  //                                                                       controller: dateController,
                  //                                                                       decoration: const InputDecoration(
                  //                                                                           focusedBorder: OutlineInputBorder(
                  //                                                                               borderRadius: BorderRadius.all(Radius.circular(32)),
                  //                                                                               borderSide: BorderSide(color: Colors.black54, width: 0.0)
                  //                                                                           ),
                  //                                                                           enabledBorder: OutlineInputBorder(
                  //                                                                               borderRadius: BorderRadius.all(Radius.circular(32)),
                  //                                                                               borderSide: BorderSide(color: Colors.black54, width: 0.0)
                  //                                                                           ),
                  //                                                                           hintText: "DD/MM/YYYY",
                  //                                                                           suffixIcon: Icon(Icons.date_range_rounded),
                  //                                                                           labelStyle: TextStyle(
                  //                                                                               color: Colors.grey
                  //                                                                           )
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                   ),
                  //                                                                   const SizedBox(height: 20,),
                  //                                                                   SizedBox(
                  //                                                                     width: 180,
                  //                                                                     child: TextFormField(
                  //                                                                       // initialValue: viewModel.listPengiriman[index].tanggalPengiriman.toString().substring(11, 16),
                  //                                                                       onTap: () async {
                  //                                                                         TimeOfDay? pickedTime = await showTimePicker(
                  //                                                                             context: context,
                  //                                                                             initialTime: TimeOfDay.now());
                  //                                                                         if (pickedTime != null) {
                  //                                                                           // DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                  //                                                                           // String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                  //                                                                           setState(() {
                  //                                                                             timeController.text = pickedTime.toString().substring(10,15);
                  //                                                                           });
                  //                                                                         } else {
                  //                                                                           return null;
                  //                                                                         }
                  //                                                                       },
                  //                                                                       readOnly: true,
                  //                                                                       style: const TextStyle(color: Colors.black45),
                  //                                                                       controller: timeController,
                  //                                                                       decoration: const InputDecoration(
                  //                                                                           focusedBorder: OutlineInputBorder(
                  //                                                                               borderRadius: BorderRadius.all(Radius.circular(32)),
                  //                                                                               borderSide: BorderSide(color: Colors.black54, width: 0.0)
                  //                                                                           ),
                  //                                                                           enabledBorder: OutlineInputBorder(
                  //                                                                               borderRadius: BorderRadius.all(Radius.circular(32)),
                  //                                                                               borderSide: BorderSide(color: Colors.black54, width: 0.0)
                  //                                                                           ),
                  //                                                                           hintText: "HH:mm",
                  //                                                                           suffixIcon: Icon(Icons.alarm_rounded),
                  //                                                                           labelStyle: TextStyle(
                  //                                                                               color: Colors.grey
                  //                                                                           )
                  //                                                                       ),
                  //                                                                     ),
                  //                                                                   )
                  //                                                                 ],
                  //                                                               )
                  //                                                           ),
                  //                                                           actions: [
                  //                                                             Row(
                  //                                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                                                               children: [
                  //                                                                 SizedBox(
                  //                                                                     width: 120,
                  //                                                                     height: 50,
                  //                                                                     child: OutlinedButton(
                  //                                                                         style: OutlinedButton.styleFrom(
                  //                                                                           side: const BorderSide(width: 1.0, color: Colors.orange),
                  //                                                                           shape: RoundedRectangleBorder(
                  //                                                                               borderRadius: BorderRadius.circular(32.0)
                  //                                                                           ),
                  //                                                                         ),
                  //                                                                         onPressed: () {
                  //                                                                           Navigator.pop(context);
                  //                                                                         },
                  //                                                                         child: const Text("Tidak, Ubah", style: TextStyle(color: Colors.orange),)
                  //                                                                     )
                  //                                                                 ),
                  //                                                                 Container(
                  //                                                                   // margin: EdgeInsets.all(20),
                  //                                                                   width: 120,
                  //                                                                   height: 50,
                  //                                                                   decoration: BoxDecoration(
                  //                                                                     gradient: const LinearGradient(
                  //                                                                       colors: [Colors.orange, Colors.deepOrange],
                  //                                                                       begin: FractionalOffset.bottomLeft,
                  //                                                                       end: FractionalOffset.topRight,
                  //                                                                     ),
                  //                                                                     borderRadius: BorderRadius.circular(32),
                  //                                                                   ),
                  //                                                                   child: TextButton(
                  //                                                                     child: const Text(
                  //                                                                       'Ya,Benar',
                  //                                                                       style: TextStyle(color: Colors.white),
                  //                                                                     ),
                  //                                                                     onPressed: () {
                  //                                                                       String noRes = viewModel.listPengiriman[index].noReservasi.toString();
                  //                                                                       String petaniId = viewModel.listPengiriman[index].noReservasi.toString();
                  //                                                                       String tanggal = dateController.text.toString();
                  //                                                                       String waktu = timeController.text.toString();
                  //
                  //                                                                       viewModel.getUpdateReservasi(noRes, petaniId, tanggal, waktu, context);
                  //                                                                       // Navigator.pop(context);
                  //                                                                     },
                  //                                                                   ),
                  //                                                                 ),
                  //                                                               ],
                  //                                                             ),
                  //                                                             const SizedBox(height: 16,)
                  //                                                           ],
                  //                                                         )
                  //                                                     );
                  //                                                   });
                  //                                                 },
                  //                                               ),
                  //                                             )
                  //                                         ),
                  //                                       ),
                  //                                       const SizedBox(width: 16,),
                  //                                       Visibility(
                  //                                         visible: _status == 2 ? true : false,
                  //                                         replacement: const SizedBox(width: 80,),
                  //                                         child: InkWell(
                  //                                             onTap: () {},
                  //                                             child: Container(
                  //                                               // margin: EdgeInsets.all(20),
                  //                                               width: 70,
                  //                                               height: 45,
                  //                                               decoration: BoxDecoration(
                  //                                                   borderRadius: BorderRadius.circular(16),
                  //                                                   color: Colors.green
                  //                                               ),
                  //                                               child: TextButton(
                  //                                                 child: const Text(
                  //                                                   'Faktur',
                  //                                                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  //                                                 ),
                  //                                                 onPressed: () {},
                  //                                               ),
                  //                                             )
                  //                                         ),
                  //                                       ),
                  //                                     ],
                  //                                   )
                  //                                 ],
                  //                               ),
                  //                             ],
                  //                           ),
                  //                           const Expanded(child: Divider(thickness: 1,)),
                  //                         ],
                  //                       ),
                  //                     )
                  //                 );
                  //               },
                  //               itemCount: viewModel.listPengiriman.length,
                  //             ),
                  //             const SizedBox(height: 16,),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // );
                }
            );
          }
      ),
    );
  }
}
