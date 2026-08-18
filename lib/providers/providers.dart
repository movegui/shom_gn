import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shom_gn/models/address_model.dart';
import 'package:shom_gn/providers/address_provider.dart';
import 'package:shom_gn/providers/appbar_title_provider.dart';
import 'package:shom_gn/providers/shopping_provider.dart';
import 'package:shom_gn/providers/store_provider.dart';
import 'package:shom_gn/providers/user_provider.dart';
import 'package:shom_gn/services/address_service.dart';
import 'package:shom_gn/services/register_services.dart';


final shoppingProviderState = ChangeNotifierProvider<ShoppingProvider>((ref) {
  return ShoppingProvider();
});

final storeProviderState = ChangeNotifierProvider<StoreProvider>((ref) {
  return StoreProvider();
});

final userProviderState = ChangeNotifierProvider<UserProvider>((ref) {
  return UserProvider();
});

final appbarTitleProviderState = ChangeNotifierProvider<AppbarTitleProvider>((ref) {
  return AppbarTitleProvider();
});

final addressProviderState = ChangeNotifierProvider<AddressProvider>((ref) {
  return AddressProvider();
});

/*
final previousRouteProviderState = ChangeNotifierProvider<PreviousRouteProvider>((ref) {
  return PreviousRouteProvider();
});
*/

final currentAddressProvider =
FutureProvider<AddressModel?> ((ref) async {
final service = getIt<AddressService>();
return service.getCurrentAddress(null);
});

 // previousRouteProvider
