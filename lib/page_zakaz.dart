import 'package:apteka/Models/drugsModel.dart';
import 'package:apteka/page_w.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageZakaz extends StatefulWidget {
  int uzz;
  PageZakaz({Key? key, required this.uzz}) : super(key: key);

  @override
  State<PageZakaz> createState() => _PageZakazState();
}
int opshe = 1;
int? pull=0;
class _PageZakazState extends State<PageZakaz> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
            title: Center(child: Text("Buyurtma")),
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
                  pull=drug?[widget.uzz]?.price;
                  return Container(
                    padding: EdgeInsets.only(top: 40,left: 18,right: 10,bottom: 40),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${drug?[widget.uzz]?.imageUrl}"),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            Column(children: [
                              Row(
                                children: [
                                  SizedBox(width: 40,),
                                  Text("${drug?[widget.uzz]?.name}",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22),),SizedBox(width: 60,),
                                  Container(width: 28,height: 28,decoration: BoxDecoration(border: Border.all(width: 2,color: Colors.grey),borderRadius: BorderRadius.circular(50),color: Colors.white),child: Center(child: Icon(Icons.clear,color: Colors.grey,)))
                                ],
                              ),
                              SizedBox(height: 56,),
                              Row(children: [
                                SizedBox(width: 10,),Text("\$ ${drug?[widget.uzz]?.price}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                                SizedBox(width: 48,),
                                Container(
                                  width: 115,
                                  height: 35,
                                  decoration: BoxDecoration(color: Color(0xFFF2F4FF),borderRadius: BorderRadius.circular(60)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(width: 35,height: 35,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Color(0xFFDFE3FF)),
                                      child: TextButton(onPressed: (){setState(() {
                                        opshe--;
                                      });}, child: Center(child: Text("-",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),))),),

                                      Text("${opshe}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 26),),

                                      Container(width: 35,height: 35,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Color(0xFFA0ABFF)),
                                        child: TextButton(onPressed: (){setState(() {
                                          opshe++;
                                        });}, child: Center(child: Text("+",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),))),),
                                    ],
                                  ),
                                ),
                              ],
                              ),
                            ],
                            ),

                          ],
                        ),
                        Container(
                          width: 327,
                          height: 53,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(56),color: Color(0xFF4157FF),
                          ),
                          child: Center(child: Text("Place Order @ \$${opshe>0?pull!*opshe:0}",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400),)),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              })),
    );
  }
}
