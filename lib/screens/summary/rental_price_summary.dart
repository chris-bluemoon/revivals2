import 'package:flutter/material.dart';
import 'package:revivals/shared/styled_text.dart';

class RentalPriceSummary extends StatelessWidget {
  const RentalPriceSummary(this.price, this.noOfDays, this.deliveryPrice, this.symbol, {super.key});

  final int price;
  final int noOfDays;
  final int deliveryPrice;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    int pricePerDay = price~/noOfDays;
    int finalPrice = price + deliveryPrice;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StyledHeading('PRICE DETAILS'),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                StyledBody('$pricePerDay x $noOfDays days', color: Colors.black, weight: FontWeight.normal),
                const Expanded(child: SizedBox()),
                StyledBody('$price$symbol', color: Colors.black, weight: FontWeight.normal),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                const StyledBody('Delivery fee', color: Colors.black, weight: FontWeight.normal),
                const Expanded(child: SizedBox()),
                StyledBody('$deliveryPrice$symbol', color: Colors.black, weight: FontWeight.normal),
            
              ],
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                const StyledHeading('Total'),
                const Expanded(child: SizedBox()),
                StyledHeading('$finalPrice$symbol'),
              ],
            ),
          ),
      ],),
    );
  }
}