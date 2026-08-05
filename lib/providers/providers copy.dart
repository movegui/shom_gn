


import 'package:flutter_riverpod/legacy.dart';
import 'package:shom_gn/providers/address_provider.dart';
import 'package:shom_gn/providers/appbar_title_provider.dart';
import 'package:shom_gn/providers/shopping_provider.dart';
import 'package:shom_gn/providers/store_provider%20copy.dart';
import 'package:shom_gn/providers/user_provider.dart';

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

 
