import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:dilaac/common/constants/image_constants.dart';
import 'package:dilaac/common/constants/size_constants.dart';
import 'package:dilaac/common/constants/translation_constants.dart';
import 'package:dilaac/common/screenutil/margin_util.dart';
import 'package:dilaac/presentation/journeys/transaction_history_screen/trans_widget.dart';
import 'package:dilaac/presentation/themes/theme_color.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dilaac/utils/log.dart';
import 'package:dilaac/utils/navigator.dart';
import 'package:flutter/material.dart';

import '../../../core/providers.dart';
import '../../../models/trans_history_model.dart';
import '../../widgets/app_bar_widget.dart';

class TransactionListScreen extends StatefulHookWidget {
  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen>
    with
        AfterLayoutMixin<TransactionListScreen>,
        SingleTickerProviderStateMixin {
  Transactions? data;
  late TabController _controller;
  int _selectedTab = 0;

  final _listOfTabs = [
    TranslationConstants.all,
    TranslationConstants.inflow,
    TranslationConstants.payout
  ];
  @override
  void initState() {
    _controller = TabController(
      initialIndex: 0,
      length: _listOfTabs.length,
      vsync: this,
    );

    _controller.addListener(() async {
      if (!_controller.indexIsChanging) {
        setState(() {
          _selectedTab = _controller.index;
        });
      }

      if (_controller.index == 0) {
        context
            .read(transHistoryVM)
            .getTransHist(type: null, start: null, end: null);
      } else if (_controller.index == 1) {
        context
            .read(transHistoryVM)
            .getTransHist(type: "payin", start: null, end: null);
      } else {
        context
            .read(transHistoryVM)
            .getTransHist(type: "payout", start: null, end: null);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // context.read(transHistoryVM).getTransHist();
  }

  @override
  Widget build(BuildContext context) {
    var transProvider =
        useProvider(transHistoryVM.select((value) => value.transHistoryModel));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: DilaacAppBarWidget(
          showMenu: false,
          title: TranslationConstants.transHistory,
        ),
        body: Column(
          children: [
            const YMargin(Sizes.dimen_20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Sizes.dimen_12),
                child: Material(
                  color: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: AppColor.deepOrange),
                      borderRadius: BorderRadius.circular(Sizes.dimen_12)),
                  child: TabBar(
                    unselectedLabelColor: Colors.blue,
                    labelColor: Colors.blue,
                    indicatorColor: Colors.white,
                    controller: _controller,
                    labelPadding: const EdgeInsets.all(0.0),
                    tabs: [
                      _getTab(0, _listOfTabs[0]),
                      _getTab(1, _listOfTabs[1]),
                      _getTab(2, _listOfTabs[2]),
                    ],
                  ),
                ),
              ),
            ),
            const YMargin(Sizes.dimen_24),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                children: [
                  _transHistoryList(transProvider),
                  _transHistoryList(transProvider),
                  _transHistoryList(transProvider),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _transHistoryList(TransHistoryModel? transProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_16),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          if (transProvider != null)
            data = transProvider.data!.transactions![index];
          return TransactionWidget(
              type: data?.type ?? '',
              narration: data?.narration ?? '',
              date: data?.date ?? '',
              amount: data?.amount.toString() ?? '');
        },
        separatorBuilder: (context, index) => Container(height: Sizes.dimen_16),
        itemCount: transProvider != null
            ? transProvider.data!.transactions!.length
            : 0,
      ),
    );
  }

  _getTab(index, title) {
    return Tab(
      child: SizedBox.expand(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_12),
          child: Container(
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: Sizes.dimen_18,
                    color: _selectedTab == index
                        ? AppColor.white
                        : AppColor.textFormPlaceHolderColor),
              ),
            ),
            decoration: BoxDecoration(
              gradient: _selectedTab == index ? kLinearGrad : null,
            ),
          ),
        ),
      ),
    );
  }
}
