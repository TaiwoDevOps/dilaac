import 'dart:io';

import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:dilaac/presentation/widgets/dilaac.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter/material.dart';

class BankListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BankListWidgetState();
}

class _BankListWidgetState extends State<BankListWidget> {
  TextEditingController searchController = TextEditingController();
  String? filter;

  @override
  initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        const YMargin(Sizes.dimen_16),
        DilaacTextField2(
          controller: searchController,
          labelText: 'Search',
          margin: Sizes.dimen_16,
          prefixWidget: Icon(
            Icons.search,
            color: AppColor.deepDarkOrange,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              // if filter is null or empty returns all data
              return filter == null || filter == ""
                  ? ListTile(
                      title: Text(
                        'Taiwo Adisa',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: AppColor.deepDarkOrange,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () {},
                    )
                  : 'Software Engineer'
                          .toLowerCase()
                          .contains(filter!.toLowerCase())
                      ? ListTile(
                          title: Text(
                            '08122437265',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(
                                    color: AppColor.darkOrange,
                                    fontWeight: FontWeight.w500),
                          ),
                          onTap: () {},
                        )
                      : Container();
            },
          ),
        ),
      ],
    ));
  }

  // void _onTapItem(BuildContext context, Data bank) {
  //   if (widget.countryCode.toLowerCase() == "ghs") {
  //     if (bank.bankCode != null) {
  //       context.read(getBanksVM).getBankBranches(bank.bankCode!);
  //       Navigator.pop(context, bank);
  //     } else
  //       navigator.popView();
  //   } else {
  //     if (bank.bankCode != null)
  //       Navigator.pop(context, bank);
  //     else
  //       navigator.popView();
  //   }
  // }
}
