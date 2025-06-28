import 'package:fuellogic/core/enums/enum.dart';
import 'package:get/get.dart';

class AllOrdersController extends GetxController {
  int selectedIndex = 0;
  List<String> orderFilter = [
    "All",
    "Pending",
    "Accepted",
    "On the way",
    "Delivered",
  ];

  
  List<OrderStatus> allOrders = [
    OrderStatus.pending,
    OrderStatus.pending,
    OrderStatus.approved,
    OrderStatus.onTheWay,
    OrderStatus.delivered,
    OrderStatus.delivered,
  ];

  List<OrderStatus> get filteredOrders {
    if (selectedIndex == 0) return allOrders; 
    
    switch (orderFilter[selectedIndex]) {
      case "Pending":
        return allOrders
            .where((order) => order == OrderStatus.pending)
            .toList();
      case "Accepted":
        return allOrders
            .where((order) => order == OrderStatus.approved)
            .toList();
      case "On the way":
        return allOrders
            .where((order) => order == OrderStatus.onTheWay)
            .toList();
      case "Delivered":
        return allOrders
            .where((order) => order == OrderStatus.delivered)
            .toList();
      default:
        return allOrders;
    }
  }

  void selectFilter(int index) {
    selectedIndex = index;
    update();
  }
}
