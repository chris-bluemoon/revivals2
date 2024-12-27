import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:revivals/models/item.dart';
import 'package:revivals/models/item_renter.dart';
import 'package:revivals/services/class_store.dart';
import 'package:revivals/shared/styled_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class AccountsInsightsPage extends StatefulWidget {
  const AccountsInsightsPage({super.key});

  @override
  State<AccountsInsightsPage> createState() => _AccountsInsightsPageState();
}

class _AccountsInsightsPageState extends State<AccountsInsightsPage> {
  
  @override
  void initState() {
    super.initState();
    setMonthlyAccounts();
    calculateMonthlyAccounts();
  }

  List<_SalesData> data = [
    // _SalesData('Jan', 35),
    // _SalesData('Feb', 28),
    // _SalesData('Mar', 34),
    // _SalesData('Apr', 32),
    // _SalesData('May', 40), 
    // _SalesData('Jun', 40)
  ];

  List<ItemRenter> myAccountsHistory = [];

  Map<String, int> accountMapMonthly = {};

  int totalRentals = 0;
  int totalSales = 0;
  int returnOnInvestment = 0;
  int valueOfListings = 0;
  int responseRate = 0;
  int acceptanceRate = 0;
  String mostRented = '';
  List<String> brands = [];

  void setMonthlyAccounts() {
    // Get earliest date
    List<ItemRenter> allAccountsHistory = Provider.of<ItemStore>(context, listen: false).itemRenters;
    for (ItemRenter ir in allAccountsHistory) {
      if (ir.ownerId == Provider.of<ItemStore>(context, listen: false).renter.email) {
        myAccountsHistory.add(ir);
        myAccountsHistory.sort((a, b) => a.endDate.compareTo(b.endDate));
        totalRentals++;
        totalSales = totalSales + ir.price;
        for (Item i in Provider.of<ItemStore>(context, listen: false).items) {
          if (i.id == ir.itemId) {
            brands.add(i.brand);
        }
      }
      }
    }

    Map<String, int> map = {};
    for (var x in brands) {
      map[x] = !map.containsKey(x) ? (1) : (map[x]! + 1);
    }
    final sorted = SplayTreeMap<String,dynamic>.from(map, (b, a) => a.compareTo(b));
    mostRented = sorted.keys.toList().first;


    for (Item i in Provider.of<ItemStore>(context, listen: false).items) {
      if (i.owner == Provider.of<ItemStore>(context, listen: false).renter.id) {
        valueOfListings = valueOfListings + i.rrp;
      }
    }

    String earliestDateString = myAccountsHistory[0].endDate;
    String earliestMonthString = earliestDateString.substring(0,7);
    String nowMonth = DateFormat('yyyy-MM').format(DateTime.now().add(const Duration(days: 31)));
    String bucketMonth = earliestMonthString;
    while (bucketMonth != nowMonth) {
      accountMapMonthly[bucketMonth] = 0;
      DateTime nextMonth = DateFormat('yyyy-MM').parse(bucketMonth).add(const Duration(days: 31));
      bucketMonth = DateFormat('yyyy-MM').format(nextMonth);
    }
  }

  void calculateMonthlyAccounts() {
    for (ItemRenter ir in myAccountsHistory) {
      for (var v in accountMapMonthly.keys) {
        String monthEndDate = ir.endDate.substring(0, 7);
        if (monthEndDate == v) {
          int newValue = accountMapMonthly[v]! + ir.price;
          accountMapMonthly[v] = newValue;
        }
      }
    }
    accountMapMonthly.forEach((key, value) {
      DateTime month = DateFormat('yyyy-MM').parse(key);
      String stringMonth1 = DateFormat('yMMM').format(month);
      String stringMonth2 = DateFormat('MMM').format(month);
      if (accountMapMonthly.length > 12) {
        data.add(_SalesData(stringMonth1, value));
      } else {
        data.add(_SalesData(stringMonth2, value));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              // Chart title
              title: const ChartTitle(text: 'All Sales'),
              // Enable legend
              legend: const Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.month,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Sales',
                    // Enable data label
                    // dataLabelSettings: const DataLabelSettings(isVisible: true)
                )
              ]),
              const Divider(indent: 50, endIndent: 50),
              SizedBox(height: width * 0.04),
              Row(children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: const StyledBody('Total Rentals', weight: FontWeight.normal),
                      subtitle: StyledBody(totalRentals.toString()),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey,),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      // dense: true,
                      title: const StyledBody('Total Sales', weight: FontWeight.normal),
                      subtitle: StyledBody(totalSales.toString()),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey,),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],),
              Row(children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: const StyledBody('Return on Investment', weight: FontWeight.normal),
                      subtitle: const StyledBody('15%'),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey,),
                          borderRadius: BorderRadius.circular(10),
                        ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      // dense: true,
                      title: const StyledBody('Value of Listings', weight: FontWeight.normal),
                      subtitle: StyledBody('\$${valueOfListings.toString()}'),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey,),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],),
              Row(children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: const StyledBody('Response Rate', weight: FontWeight.normal),
                      subtitle: const StyledBody('94%'),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.grey,),
                          borderRadius: BorderRadius.circular(10),
                        ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      // dense: true,
                      title: const StyledBody('Acceptance Rate', weight: FontWeight.normal),
                      subtitle: const StyledBody('85%'),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.grey,),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],),
              // const Divider(indent: 50, endIndent: 50),
              SizedBox(height: width * 0.04),
              const Divider(height: 50, indent: 50, endIndent: 50),
              Padding(
                padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
                child: Row(
                  children: [
                    const StyledBody('Your most rented brand'),
                    const Expanded(child: SizedBox()),
                    StyledBody(mostRented),
                  ],),
              ),
              const Divider(height: 50, indent : 50, endIndent: 50),
              // SizedBox(height: width * 0.01),
              Padding(
                padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
                child: Row(
                  children: [
                    const StyledBody('Your most popular listing'),
                    const Expanded(child: SizedBox()),
                    Icon(Icons.chevron_right_outlined, size: width * 0.05),
                  ],),
              )
        ]);

  }}

class _SalesData {
  _SalesData(this.month, this.sales);

  final String month;
  final int sales;
}
