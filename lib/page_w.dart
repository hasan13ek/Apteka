import 'dart:convert';

import 'package:apteka/page_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'Models/drugsModel.dart';

class Page_2 extends StatefulWidget {
  const Page_2({Key? key}) : super(key: key);

  @override
  State<Page_2> createState() => _Page_2State();
}

Future<List<DrugsModel>?>? getResult;

class Servis{
  static Future<List<DrugsModel>?> getNews() async {
    String url = "https://pharmacy-app-management.herokuapp.com/api/drugs";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;
      List<DrugsModel> drugsmodel =
      json.map((e) => DrugsModel.fromJson(e)).toList();
      return drugsmodel;
    }
    return null;
  }
}




class _Page_2State extends State<Page_2> {
  void initState() {
    super.initState();
    getResult = Servis.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: Center(child: Text("All Products")),
          ),
          body: FutureBuilder<List<DrugsModel>?>(
              future: getResult,
              builder:
                  (BuildContext context, AsyncSnapshot<List<DrugsModel>?> oka) {
                if (oka.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (oka.hasError) {
                  return Center(child: Text(oka.error.toString()));
                }

                if (oka.hasData) {
                  List<DrugsModel?>? drug = oka.data;
                  return Container(
                    padding: EdgeInsets.only(left: 4,right: 4,top: 4,bottom: 0),
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    color: Colors.white,
                    child: GridView.builder(

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) =>
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>Page_3(uz:index)));
                            },
                            child: Container(
                        width: 157,
                        margin: EdgeInsets.only(top: 8, left: 8, right: 8),
                        height: 650,
                        decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                        child: Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 8)),
                              Container(
                                width: 125,
                                height: 128,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${drug?[index]?.imageUrl}"),
                                        fit: BoxFit.cover),
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${drug?[index]?.name}",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "\$ ${drug?[index]?.price}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 16),
                              )
                            ],
                        ),
                      ),
                          ),
                      itemCount: drug?.length ?? 0,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                    ),
                  );
                }
                return Container(
                  child: Text("Nimadir xatolik bor"),
                );
              })),
    );
  }
}
