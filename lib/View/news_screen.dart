import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taniku/View/Hasil.dart';
import 'package:taniku/ViewModel/news_viewmodel.dart';
import 'package:taniku/View/bottom_navigation.dart';

import 'kebunDetail.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsViewModel>(
      create: (context) => NewsViewModel(context),
      child: Builder(
        builder: (context){
          return Consumer<NewsViewModel>(
              builder: (context, viewModel, child) {
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    backgroundColor: Colors.blue,
                    title: const Text("News"),
                  ),
                  body: Container(
                      margin: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ListView Horizontal
                            const Text("News Update",
                              style: TextStyle(fontWeight: FontWeight.bold,),),
                            const SizedBox(height: 16,),
                            SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: viewModel.listNews.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => Hasil(
                                            value: viewModel.listNews[index].newsTitle.toString(),
                                            value2: viewModel.listNews[index].newsDate.toString(),
                                            value3: viewModel.listNews[index].newsImage.toString(),
                                            value4: viewModel.listNews[index].author.toString())));
                                        print("data :  ${viewModel.listNews[index].newsTitle.toString()}");
                                      },
                                      child: Container(
                                        width: 175,
                                        alignment: Alignment.center,
                                        child: Card(
                                          color: Colors.white,
                                          child: Container(
                                            width: double.infinity,
                                            margin: const EdgeInsets.all(12),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Image.network(
                                                      viewModel.listNews[index].newsImage.toString(),
                                                      width: 90,
                                                      height: 80,),
                                                    const SizedBox(height: 8,),
                                                    Text(
                                                      viewModel.listNews[index].newsTitle.toString(),
                                                      textAlign: TextAlign.center,),
                                                    const SizedBox(height: 8,),
                                                    Text(
                                                      viewModel.listNews[index].newsDate.toString(),
                                                      textAlign: TextAlign.center,),
                                                    const SizedBox(height: 8,),
                                                    Text(
                                                      viewModel.listNews[index].newsId.toString(),
                                                      textAlign: TextAlign.center,),
                                                    const SizedBox(height: 8,),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                              ),
                            ),
                            SizedBox(height: 16,),
                            const Text("List Kebun",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: viewModel.listKebun.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => KebunDetail(value: viewModel.listKebun[index].id.toString(),
                                    )));
                                    },
                                  child: Container(
                                    child: Card(
                                      child: Container(
                                        margin: const EdgeInsets.all(8),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    topRight: Radius.circular(4),
                                                  ),
                                                ),
                                                child:
                                                Row(
                                                  children: const[
                                                    Padding(padding: EdgeInsets.all(14),
                                                      child: Text("Kebun Petani", style:
                                                      TextStyle(fontSize: 20,
                                                          fontWeight: FontWeight.bold),
                                                      )
                                                      ,)
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.all(16),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const Text("Luas Kebun", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                                          Text(viewModel.listKebun[index].luasKebun.toString(), style:
                                                          const TextStyle(fontSize: 12),),
                                                          const SizedBox(height: 8,),
                                                          const Text("Jumlah Pohon", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                                          Text(viewModel.listKebun[index].jumlahPohon.toString(), style:
                                                          const TextStyle(fontSize: 12),),
                                                          const SizedBox(height: 8,),
                                                          const Text("Tahun Tanam", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                                          Text(viewModel.listKebun[index].tahunTanamId.toString(), style:
                                                          const TextStyle(fontSize: 12,),),
                                                          const SizedBox(height: 8,),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Lokasi", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                                          Text("${viewModel.listKebun[index].alamat.toString()},", style:
                                                          const TextStyle(fontSize: 12, color: Colors.grey),),
                                                          Text("${viewModel.listKebun[index].kelurahanName.toString()},", style:
                                                          const TextStyle(fontSize: 12, color: Colors.grey),),
                                                          Text("${viewModel.listKebun[index].kecamatanName.toString()},", style:
                                                          const TextStyle(fontSize: 12, color: Colors.grey),),
                                                          Text("${viewModel.listKebun[index].kabupatenKotaName.toString()},", style:
                                                          const TextStyle(fontSize: 12, color: Colors.grey),),
                                                          Text("${viewModel.listKebun[index].provinsiName.toString()},", style:
                                                          const TextStyle(fontSize: 12, color: Colors.grey),),
                                                          Text("${viewModel.listKebun[index].kodePos.toString()},", style:
                                                          const TextStyle(fontSize: 12, color: Colors.grey),),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                  ),
                );
              }
          );
        },
      ),
    );

  }
}
