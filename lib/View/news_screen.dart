import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taniku/View/Hasil.dart';
import 'package:taniku/ViewModel/news_viewmodel.dart';

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
                            const Text("List Horizontal",
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
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => Hasil(value: viewModel.listNews[index].newsTitle.toString(),
                                            value2: viewModel.listNews[index].newsDate.toString(),
                                            value3: viewModel.listNews[index].newsImage.toString(),
                                            value4: viewModel.listNews[index].author.toString())));
                                        print("data :  ${viewModel.listNews[index].newsTitle.toString()}");
                                      },
                                      child: Container(
                                        width: 200,
                                        alignment: Alignment.center,
                                        child: Card(
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
                                                      width: 70,
                                                      height: 70,),
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

                            // SizedBox(height: 16,),
                            // const Text("List Vertical", style: TextStyle(fontWeight: FontWeight.bold),),
                            // SizedBox(height: 16,),
                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   itemBuilder: (context, index) {
                            //     return InkWell(
                            //       onTap: () {
                            //         Navigator.push(context,MaterialPageRoute(builder: (context) => HasilColor(value: viewModel.datacolor[index].name.toString(),
                            //             value2: viewModel.datacolor[index].year.toString(),
                            //             value3: viewModel.datacolor[index].color.toString())));
                            //         print('data : ${viewModel.datacolor[index].name.toString()}');
                            //       },
                            //       child: Card(
                            //         child: Container(
                            //           margin: const EdgeInsets.all(8),
                            //           child: Row(
                            //             children: [
                            //               Container(
                            //                 height: 70,
                            //                 width: 70,
                            //                 decoration: BoxDecoration(
                            //                   borderRadius: BorderRadius.all(Radius.circular(50)),
                            //                   color: HexColor(viewModel.datacolor[index].color.toString()),
                            //                 ),
                            //               ),
                            //               SizedBox(width: 16,),
                            //               Column(
                            //                 crossAxisAlignment: CrossAxisAlignment.start,
                            //                 children: [
                            //                   Text(viewModel.datacolor[index].name.toString()),
                            //                   const SizedBox(height: 8,),
                            //                   Text(viewModel.datacolor[index].year.toString()),
                            //                   const SizedBox(height: 8,),
                            //                 ],
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            //   itemCount: viewModel.datacolor.length,
                            // ),
                            // const SizedBox(height: 16,),
                            // Text("List GridView", style: TextStyle(fontWeight: FontWeight.bold),),
                            // const SizedBox(height: 16),
                            // GridView.builder(
                            //   shrinkWrap: true,
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   itemCount: viewModel.datamovie.length,
                            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //     crossAxisCount: MediaQuery.of(context).orientation ==
                            //         Orientation.landscape ? 3: 2,
                            //     crossAxisSpacing: 4,
                            //     mainAxisSpacing : 4,
                            //     childAspectRatio: (1 / 1),
                            //     mainAxisExtent: 300,
                            //   ),
                            //   itemBuilder: (context,index,) {
                            //     return InkWell(
                            //       onTap: () {
                            //         Navigator.push(context,MaterialPageRoute(builder: (context) => HasilGrid(value: viewModel.datamovie[index].title.toString(),
                            //             value2: viewModel.datamovie[index].year.toString(),
                            //             value3: viewModel.datamovie[index].poster.toString())));
                            //         print("imdbID : ${viewModel.datamovie[index].imdbID.toString()}");
                            //         print("Title : ${viewModel.datamovie[index].title.toString()}");
                            //         print("Year : ${viewModel.datamovie[index].year.toString()}");
                            //       },
                            //       child: Container(
                            //           alignment: Alignment.center,
                            //           child: Card(
                            //             child: Container(
                            //               width: double.infinity,
                            //               margin: const EdgeInsets.all(12),
                            //               child: Column(
                            //                 children: [
                            //                   Image.network(viewModel.datamovie[index].poster.toString(), width: 70, height: 70,
                            //                     errorBuilder: (context, error, stackTrace) {
                            //                       return Container(
                            //                           width: 80,
                            //                           height: 80,
                            //                           alignment: Alignment.center,
                            //                           child: const Icon(Icons.error_outline, size: 22,)
                            //                       );
                            //                     },),
                            //                   const SizedBox(height: 16,),
                            //                   Text(viewModel.datamovie[index].title.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            //                   const SizedBox(height: 8,),
                            //                   Text(viewModel.datamovie[index].year.toString()),
                            //                   const SizedBox(height: 8,),
                            //                 ],
                            //               ),
                            //             ),
                            //           )
                            //       ),
                            //     );
                            //   },
                            // ),

                          ],
                        ),
                      )
                  ),
                );
              });
        },
      ),
    );

  }
}
