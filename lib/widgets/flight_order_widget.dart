import 'package:flutter/material.dart';
import 'package:shom_gn/models/flight_order_model.dart';

class FlightOrderWidget extends StatelessWidget {
  final FlightOrderModel order;

  const FlightOrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking Summary",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Icon(Icons.flight_takeoff, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${order.items[0].service.product.departure?.address} → ${order.items[0].service.product.arrival?.address}",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(order.items[0].service.createdAt.toIso8601String() ?? '', style: TextStyle(color: Colors.grey.shade600)),

            const Divider(height: 30),

            Row(
              children: [
                const Icon(Icons.people_outline),
                const SizedBox(width: 8),
                Text("${order.items[0].service.product.passengers.length} Passenger(s)"),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.airline_seat_recline_normal),
                const SizedBox(width: 8),
                Text(order.items[0].service.cabinClass ?? ''),
              ],
            ),

            const Divider(height: 30),

            _priceRow("Ticket Price", "${order.items[0].service.ticketPrice!.toStringAsFixed(0)} €"),

            _priceRow("Taxes", "${order.items[0].service.taxes!.toStringAsFixed(0)} €"),

            _priceRow("Service Fee", "${order.items[0].service.serviceFee!.toStringAsFixed(0)} €"),

            const Divider(),

            _priceRow("Total", "${order.items[0].service.ticketPrice?.toStringAsFixed(0)} €", isTotal: true),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: (){},
                icon: const Icon(Icons.arrow_forward),
                label: const Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
