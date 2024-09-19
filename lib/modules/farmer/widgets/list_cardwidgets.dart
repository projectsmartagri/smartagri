import 'package:flutter/material.dart';


class ListCardWidgets extends StatelessWidget {
  ListCardWidgets(
      {super.key,
      required this.image,
        required this.ontab,
        required this.val,
      required this.title,
      required this.subtitle,
      required this.price,
      this.isCategories=false
      });


  String image;
  String title;
  String subtitle;
  String price;
  bool isCategories;
  Map<String,dynamic> val;

  void Function() ontab;






  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          ontab();
        },
        child: SizedBox(
            height: 270,
            child: Card(

                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                ),
                child: Container(
                  width: 173.32,
                  height: 248.51,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25.21,
                          width: 133.73,
                        ),


                        Image.network(
                          image,
                          width: 99.89,
                          height: 79.43,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            // textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff181725),
                                fontSize: 16),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            subtitle,
                            textAlign: TextAlign.start,
                            style:
                                TextStyle(color: Color(0xff7C7C7C), fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹${price}' ,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff181725)),
                            ),
                            isCategories? SizedBox() : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(47.67, 47.67),
                                  backgroundColor: Color(0xff53B175),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12), // <-- Radius
                                  ),
                                ),
                                onPressed:ontab,
                                child: Icon(
                                  Icons.add,
                                  size: 17,
                                  color: Colors.white,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}
