import 'package:flutter/material.dart';
import 'package:ration_go/colors.dart';

class Orderdetails extends StatefulWidget {
  var order;
  Orderdetails(this.order, {Key? key}) : super(key: key);

  @override
  _OrderdetailsState createState() => _OrderdetailsState();
}

class _OrderdetailsState extends State<Orderdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text('RationGo!',
              style: TextStyle(color: AppColors.primary)),
        ),
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order: ' + widget.order['order_id'],
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.black,
                            fontWeight: FontWeight.w600)),
                    InkWell(
                      onTap: () {
                        setState(() {});
                      },
                      child: Text(
                          'Total: ₹ ' + widget.order['total_amount'].toString(),
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.order['user']['name'],
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.black,
                            fontWeight: FontWeight.w600)),
                    Text(widget.order['user']['ration_card_id'],
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.black,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                Divider(color: Colors.grey.shade300),
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.order['products'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 5, 0, 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            widget.order['products'][index]
                                                ['product_name'],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w500)),
                                        Text(
                                            '₹' +
                                                widget.order['products'][index]
                                                        ['actual_price']
                                                    .toString() +
                                                " x " +
                                                widget.order['products'][index]
                                                        ['quantity']
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                height: 0,
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  '₹' +
                                      (widget.order['products'][index]
                                                  ['actual_price'] *
                                              widget.order['products'][index]
                                                  ['quantity'])
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      height: 0,
                                      color: Colors.grey.shade900,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Order Type:',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              Text(widget.order['order_type'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                widget.order['order_type'] == 'Delivery'
                                    ? 'Delivery by ' +
                                        widget.order['expected_fulfilment_date']
                                    : 'Pickup by ' +
                                        widget
                                            .order['expected_fulfilment_date'],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600)),
                            Divider(color: Colors.grey.shade300),
                            Text(
                                widget.order['order_type'] == 'Delivery'
                                    ? widget.order['user']['address']
                                    : widget.order['store_name'] +
                                        ", " +
                                        widget.order['address'],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Payment Method:',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              widget.order['payment_method'] == "Online"
                                  ? Image.network(
                                      'https://res.cloudinary.com/di9sgzulx/image/upload/v1724971903/gtecrt2v3wnehfpiyj9p.png',
                                      height: 40,
                                    )
                                  : Text("Cash",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                      widget.order['payment_method'] == "Online"
                          ? Text(widget.order['payment_id'].toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  height: 1,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w600))
                          : SizedBox(),
                      SizedBox(height: 20),
                      InkWell(
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    AppColors.primary,
                                    AppColors.primary.withAlpha(120),
                                  ]),
                              color: AppColors.primary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Center(
                              child: Text(
                            widget.order['order_status'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
