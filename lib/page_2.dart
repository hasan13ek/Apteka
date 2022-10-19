import 'package:apteka/Models/drugsModel.dart';
import 'package:apteka/page_w.dart';
import 'package:apteka/page_zakaz.dart';
import 'package:flutter/material.dart';

class Page_3 extends StatefulWidget {
  int uz;
  Page_3({Key? key, required this.uz}) : super(key: key);

  @override
  State<Page_3> createState() => _Page_3State();
}

class _Page_3State extends State<Page_3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            Container(
              child: Row(
                children: [
                  Icon(Icons.notifications_on),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.shopping_basket_outlined),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
          title: Center(
              child: Text(
            "",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
          )),
        ),
        body: FutureBuilder<List<DrugsModel>?>(
            future: getResult,
            builder:
                (BuildContext context, AsyncSnapshot<List<DrugsModel?>?> oka) {
              if (oka.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (oka.hasError) {
                return Center(child: Text(oka.error.toString()));
              }
              if (oka.hasData) {
                List<DrugsModel?>? drug = oka.data;
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Container(
                        width: 327,
                        height: 157,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0xFFF8F8F8).withOpacity(1)),
                        child: Container(
                            width: 128,
                            height: 128,
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(17)),
                                child: Image.network(
                                  "${drug?[widget.uz]?.imageUrl}",
                                  scale: 4,
                                ))),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.only(left: 0, right: 0)),
                          Text(
                            "\$ ${drug?[widget.uz]?.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 16),
                          ),
                          SizedBox(
                            width: 170,
                          ),
                          Text(
                            "${drug?[widget.uz]?.name}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 40)),
                          Text(
                            "Product Details",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          SizedBox(width: 100,),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_)=>PageZakaz(uzz: widget.uz,)));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.add_box_outlined,color: Colors.blue,),
                                SizedBox(width: 2,),
                                Text("Add to Cart",style: TextStyle(color: Colors.blue),)
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 20),
                        child: Text(
                          "${drug?[widget.uz]?.description}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600]),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            }));
  }
}
