
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shom_gn/providers/providers.dart';

class CurrentPositionWidget extends ConsumerWidget {

const CurrentPositionWidget({super.key});

@override
Widget build(BuildContext context , WidgetRef ref) {
  final addressAsync = ref.watch(currentAddressProvider);

  return addressAsync.when(
    data: (address) {
      return Text('${address?.address}  ${address?.district}  ${address?.minucipality}' );
    },
    loading: () => const CircularProgressIndicator(semanticsLabel: 'Chargement address...',),
    error: (error, stack) => Text(error.toString()),
  );
}

}







/*
@override
Widget build(BuildContext context) {
  final addressAsync = ref.watch(currentAddressProvider);

  return addressAsync.when(
    data: (address) {
      return Text(address?.name ?? '');
    },
    loading: () => const CircularProgressIndicator(),
    error: (error, stack) => Text(error.toString()),
  );
}
*/