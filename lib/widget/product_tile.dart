import 'dart:io';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String productName;
  final String category;
  final int price;
  final String imageUrl;
  final VoidCallback cbup;
  final VoidCallback cdDel;
  final VoidCallback cbadd;
  final VoidCallback cbmin;
  final int totalLength;

  const ProductTile(
      {super.key,
      required this.category,
      required this.price,
      required this.imageUrl,
      required this.productName,
      required this.cbup,
      required this.cdDel,
      required this.cbadd,
      required this.cbmin,
      required this.totalLength});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Card(
      child: Stack(children: [
        Positioned(
            bottom: -2,
            child: SizedBox(
              width: size.width * 0.2,
              height: size.height * 0.1,
              child: Image.asset(
                'images/pathcircle.png',
                fit: BoxFit.fitWidth,
              ),
            )),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.02,
            horizontal: size.width * 0.02,
          ),
          child: Column(
            children: [
              Expanded(
                child: Stack(children: [
                  SizedBox(
                      width: size.width * 0.4,
                      child: imageUrl == ''
                          ? Image.asset('images/finalprint.png')
                          : Image.file(
                              File(imageUrl),
                              fit: BoxFit.fitWidth,
                            )),
                  Positioned(
                    right: 2,
                    child: totalLength == 0
                        ? const SizedBox()
                        : CircleAvatar(
                            radius: 20,
                            child: Text(totalLength.toString()),
                          ),
                  ),
                ]),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        productName,
                        style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: cbup,
                            child: SizedBox(
                                width: size.width * 0.06,
                                height: size.height * 0.04,
                                child: Image.asset(
                                  'images/updateic.png',
                                  fit: BoxFit.fitWidth,
                                )),
                          ),
                          InkWell(
                            onTap: cdDel,
                            child: SizedBox(
                                width: size.width * 0.06,
                                height: size.height * 0.04,
                                child: Image.asset('images/tashh.png',
                                    fit: BoxFit.fitWidth)),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            category,
                            style: TextStyle(
                              fontSize: size.height * 0.014,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            price.toString(),
                            style: TextStyle(
                                fontSize: size.height * 0.028,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: cbmin, icon: const Icon(Icons.delete)),
                      IconButton(onPressed: cbadd, icon: const Icon(Icons.add)),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}
