import 'package:export_support_customer/Models/offers_model.dart';
import 'package:export_support_customer/Screens/Offers/child_widgets/offers_list_row.dart';
import 'package:flutter/material.dart';

class OffersListContentBody extends StatelessWidget {
  OffersListContentBody({Key? key, required this.offerList}) : super(key: key);

  final List<OffersModel> offerList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: ListView.builder(
          itemCount: offerList.length,
          itemBuilder: (_, index) {
            final OffersModel offer = offerList[index];
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  index == 0
                      ? Container()
                      : Container(
                          height: 16,
                        ),
                  OffersListRowHeader(
                    offer: offer,
                  ),
                  OffersListRowBdoy(
                    offer: offer,
                  )
                ],
              ),
            );
          }),
    );
  }
}
