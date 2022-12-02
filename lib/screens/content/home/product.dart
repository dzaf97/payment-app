import 'package:flutter/material.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/datepicker_form.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/controller/product_controller.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class Product extends StatelessWidget {
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Tiket",
          style: styles.heading4,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                color: constants.primaryColor,
                child: Obx(() => Text(
                      controller.name.value,
                      style: styles.heading1,
                      textAlign: TextAlign.center,
                    )),
              ),
              AppBar(
                shape: const MyShapeBorder(-10.0),
                automaticallyImplyLeading: false,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: FormDatePicker(
                    title: "Pilih Tarikh",
                    selectedDate: controller.selectedDate),
              ),
              Obx(() {
                List<Widget> products = [];
                int ticketCounter = 0;
                for (var product in controller.products) {
                  if (product.isTicket) {
                    List<Widget> ticketTiles = [];
                    for (var i = 0; i < product.options!.length; i++) {
                      ticketTiles.add(
                        TicketTile(
                          option: product.options![i],
                          unit: product.unit!,
                          price: product.prices![i],
                          total: controller.total,
                          value: controller.tickets[ticketCounter],
                        ),
                      );
                      ticketCounter++;
                    }

                    products.add(Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(product.title),
                        children: ticketTiles,
                      ),
                    ));
                  } else {
                    List<Widget> ticketTiles = [];
                    for (var i = 0; i < product.options!.length; i++) {
                      ticketTiles.add(
                        TicketTile(
                          option: product.options![i],
                          unit: product.units![i],
                          price: product.prices![i],
                          total: controller.total,
                          value: controller.tickets[ticketCounter],
                        ),
                      );
                      ticketCounter++;
                    }

                    products.add(Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(product.title),
                        children: ticketTiles,
                      ),
                    ));
                  }
                }
                return Column(
                  children: products,
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: AddToCartButton(
                  onPressed: () {},
                  icon: LineIcons.addToShoppingCart,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 8,
                child: Obx(
                  () => PrimaryButton(
                    onPressed: () {
                      confirmPayment(
                        context,
                        controller.total.value,
                        '01',
                        [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      'Bayar RM ${controller.total.toStringAsFixed(2)} ?',
                                  style: TextStyle(
                                    color: constants.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        yesTitle: "Ya",
                        noTitle: "Tidak",
                      );
                    },
                    text: 'RM${controller.total} - Bayar',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketTile extends StatelessWidget {
  const TicketTile({
    Key? key,
    required this.price,
    required this.value,
    required this.total,
    required this.unit,
    this.option,
  }) : super(key: key);

  final String? option;
  final String unit;
  final num price;
  final RxInt value;
  final RxDouble total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Get.width * 0.4,
                child: Text(
                  unit.capitalizeFirst!,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(padding: const EdgeInsets.only(bottom: 5)),
              (option != null)
                  ? Container(width: Get.width * 0.4, child: Text(option!))
                  : Container(),
            ],
          ),
          Text(
            "RM $price",
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (value.value == 0) {
                    return null;
                  }
                  value.value--;
                  total.value = total.value - price;
                },
                child: Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: value.value == 0
                          ? Color(0xFF25A3A6).withOpacity(0.2)
                          : Color(0xFF25A3A6),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Obx(
                  () => Text(
                    "$value",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  value.value++;
                  total.value = total.value + price;
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF25A3A6),
                      borderRadius: BorderRadius.circular(5)),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
