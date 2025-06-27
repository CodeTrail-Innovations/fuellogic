import 'package:flutter/material.dart';
import 'package:fuellogic/core/enums/enum.dart';
import 'package:fuellogic/modules/home/screens/components/order_card.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                OrderCard(status: OrderStatus.pending),
                OrderCard(status: OrderStatus.approved),
                OrderCard(status: OrderStatus.onTheWay),
                OrderCard(status: OrderStatus.delivered),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
