import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shom_gn/consts/app_colors.dart';
import 'package:shom_gn/l10n/app_localizations.dart';
import 'package:shom_gn/models/flight_order_model.dart';
import 'package:shom_gn/models/order_model.dart';
import 'package:shom_gn/providers/providers.dart';
import 'package:shom_gn/widgets/flight_order_widget.dart';

class ShoppingCartScreen extends ConsumerStatefulWidget {
  /*
  final String? departure;
  final String? arrival;
  final String? date;
  final int? passengers;
  final String? cabinClass;
  final double? ticketPrice;
  final double? taxes;
  final double? serviceFee;
  final VoidCallback? onContinue;
  */

  const ShoppingCartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ShoppingCartScreenState();
}

class ShoppingCartScreenState extends ConsumerState<ShoppingCartScreen> {
  bool _initialized = false;
  List<OrderModel> orders = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      await initOrder();
    }
  }

  Future<void> initOrder() async {
    orders = ref.read(shoppingProviderState).orders;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.no_trips,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge!.copyWith(color: AppColors.error),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final order = orders[index];
        return FlightOrderWidget(order: order as FlightOrderModel);
      },
    );

    //  final total = ticketPrice! + taxes! + serviceFee!;
  }
}
