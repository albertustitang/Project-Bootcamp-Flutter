import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModel/transaksi_viewmodel.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({Key? key}) : super(key: key);

  @override
  _Transaksi createState() => _Transaksi();
}

class _Transaksi extends State<Transaksi> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TransaksiViewModel>(
      create: (context) => TransaksiViewModel(context),
      child: Builder(
          builder: (context) {
            return Consumer<TransaksiViewModel>(
              builder: (context, viewModel, child) {
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                    appBar: AppBar (
                      title: Text('Data PKS'),
                      backgroundColor: Colors.green,
                    ),
                    body: Container(
                        margin: const EdgeInsets.all(16),
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16,),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: viewModel.listTransaksi.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          // Navigator.push(context, MaterialPageRoute(
                                          //     builder: (context) => DetailKebun(kebunId: viewModel.listVerticalViewModel[index].id.toString(),)

                                          // ));
                                          print("data : ${viewModel.listTransaksi[index].id.toString()}");
                                        },
                                        child: Container(
                                          width: 210,
                                          alignment: Alignment.center,
                                          child: Card(
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    padding: new EdgeInsets.all(20),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Image.network(viewModel.listTransaksi[index].foto.toString(),width: 100, height: 100,),
                                                            const SizedBox(height: 8,),
                                                            Text(viewModel.listTransaksi[index].namaPabrik.toString(),style: const TextStyle(fontSize: 16,fontWeight:FontWeight.bold)),
                                                            const SizedBox(height: 16,),
                                                          ],
                                                        ),
                                                        Container (
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            // mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [

                                                              Text("Kuota ${viewModel.listTransaksi[index].kuota.toString()} Kg",
                                                                  style:
                                                                  const TextStyle(
                                                                      fontSize: 16,
                                                                      color: Colors.grey)),
                                                              Text("Rp ${viewModel.listTransaksi[index].harga.toString()},00",
                                                                  style: const TextStyle(
                                                                      fontSize: 20,
                                                                      color: Colors.green,
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                              Text("Kuota terisi ${viewModel.listTransaksi[index].koutaTerisi.toString()}/10.000 Kg", style: const TextStyle(fontSize: 16, color: Colors.grey)),

                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const Loginscreen2()));

                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(bottom: 15),
                                                      padding: EdgeInsets.symmetric(vertical: 5),
                                                      width: 150,
                                                      height: 40,
                                                      child: Text(
                                                        'Kirim TBS',
                                                        style: TextStyle(color: Colors.white, fontSize: 20
                                                        ),
                                                        textAlign: TextAlign.center,

                                                      ),
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment.topLeft,
                                                            end: Alignment.bottomRight,
                                                            colors: <Color>[
                                                              Colors.orange,
                                                              Colors.deepOrange
                                                            ]),
                                                        borderRadius: BorderRadius.circular(25),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ]
                            )
                        )
                    )

                );
              },
            );
          }
      ),
    );
  }
}