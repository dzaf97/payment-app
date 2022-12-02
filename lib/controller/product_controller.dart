import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/contents/service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxString name = "".obs;
  List<RxInt> tickets = List.generate(100, (index) => 0.obs);
  int ticketCounter = 0;
  RxDouble total = 0.0.obs;
  RxList<ProductDetail> products = <ProductDetail>[].obs;

  @override
  void onInit() async {
    super.onInit();
    int serviceRefNum = Get.arguments;
    log("Service Ref Number: $serviceRefNum");
    ErrorResponse response = await api.getServiceDetail(serviceRefNum);
    if (response.data == null) return;
    ServiceModel data = ServiceModel.fromJson(response.data);
    if (data.billType != null) log("Bill type: ${data.billType!.type}");

    name.value = data.name;

    for (var first in data.matrix) {
      if (first.matrix[0].length > 2) {
        // print("---------Tiket---------");
        List<String> options = List<String>.from(first.matrix[0]);
        List<List<dynamic>> getProducts = first.matrix.sublist(1);
        for (var i = 0; i < getProducts.length; i++) {
          ProductDetail product = ProductDetail(
            isTicket: true,
            title: "",
            unit: "",
            options: options.sublist(1),
          );

          // Get title
          MatrixMatrixClass titleUnit =
              MatrixMatrixClass.fromJson(getProducts[i][0]);

          // Get price
          List<String> raw = List<String>.from(getProducts[i].sublist(1));
          List<num> prices = raw.map(num.parse).toList();
          // print(jsonEncode(titleUnit));
          // print(jsonEncode(prices));
          product.title = titleUnit.title;
          product.unit = titleUnit.unit;
          product.prices = prices;
          products.add(product);
        }
      } else {
        // print("---------Item---------");
        List<String> options = [];
        List<String> units = [];
        List<num> prices = [];
        List<List<dynamic>> getProducts = first.matrix.sublist(1);
        // print(getProducts);

        for (var i = 0; i < getProducts.length; i++) {
          // GET PRICE AND TITLE
          MatrixMatrixClass titleUnit =
              MatrixMatrixClass.fromJson(getProducts[i][0]);

          num price;
          try {
            price = num.parse(getProducts[i][1]);
          } catch (e) {
            price = getProducts[i][1];
          }
          options.add(titleUnit.title);
          units.add(titleUnit.unit);
          prices.add(price);
        }
        products.add(
          ProductDetail(
            title: first.name,
            isTicket: false,
            options: options,
            units: units,
            prices: prices,
          ),
        );
      }
    }
  }
}

class ProductDetail {
  bool isTicket;
  String title;
  String? unit;
  List<num>? prices;
  List<String>? options;
  List<String>? units;

  ProductDetail({
    required this.isTicket,
    required this.title,
    this.unit,
    this.options,
    this.prices,
    this.units,
  });
}

// {
//   true
//   Pemegang MyKad
//   seorang
// }