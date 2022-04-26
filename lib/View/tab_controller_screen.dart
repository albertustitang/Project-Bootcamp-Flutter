import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taniku/View/sertifikat_screen.dart';
import '../ViewModel/tabbar_viewmodel.dart';
import 'alamat_screen.dart';
import 'bottom_navigation.dart';
import 'dokumen_screen.dart';
import 'kebun_screen.dart';



class TopBarScreen extends StatefulWidget {
  final id,petaniID;
  const TopBarScreen({Key? key, required this.id, required this.petaniID}) : super(key: key);

  @override
  _TopBarScreenState createState() => _TopBarScreenState();
}

class _TopBarScreenState extends State<TopBarScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<TabViewModel>(
      create: (context) => TabViewModel(),
      child: Builder(builder: (context) {
        return Consumer<TabViewModel>(
            builder: (context, viewModel, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: DefaultTabController(
                  length: 4,
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.green,
                      iconTheme: const IconThemeData(color: Colors.white,),
                      actions: [
                        IconButton(
                          color: Colors.white,
                          icon: const Icon(
                            Icons.arrow_back_ios,
                          ),
                          onPressed: () {
                            print('Back');
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BotNavBar()));
                          },
                        ),
                      ],
                      title: const Text("Tambah Kebun"),
                      automaticallyImplyLeading: true,
                      bottom: PreferredSize(
                        preferredSize: Size(
                          width*0.2,
                          height*0.07,
                        ),
                        child:
                        Container(
                          color: Colors.white,
                          height: height*0.07,
                          width: width,
                          child:
                          TabBar(
                            labelColor: Colors.green,
                            tabs: [
                              Text("Alamat", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                              Text("Kebun", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                              Text("Dokumen", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                              Text("Sertifikasi", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: TabBarView(
                        children: [
                           TambahAlamat(
                            parentViewModel: viewModel,
                             id: widget.id,
                             petaniId: widget.petaniID,
                          ),
                           TambahKebun(
                             parentViewModel: viewModel,
                           ),
                           TambahDokumen(
                             parentViewModel: viewModel,
                           ),
                           TambahSertifikat(
                             parentViewModel: viewModel,
                           ),
                        ]
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}


