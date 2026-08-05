import 'package:movegui/models/adress_model.dart';
import 'package:movegui/models/order_item_model.dart';
import 'package:movegui/models/order_model.dart';
import 'package:movegui/models/store/store_model.dart';
import 'package:movegui/models/user_model.dart';
import 'package:movegui/services/form_services/form_service.dart';
import 'package:movegui/widgets/formsControllers/address_form_controller.dart';
import 'package:movegui/widgets/formsControllers/form_controller.dart';

abstract class OrderFormController<
  M extends StoreModel,
  U extends UserModel,
  I extends OrderItemModel,
  OM extends OrderModel<U, I>,
  F extends FormController<M>,
  FS extends FormService<M,F>>
    extends FormController<OM> {
  final OM order;
  final pickupAddressForm = AddressFormController();
  final deliveryAdressForm = AddressFormController();
  AdressModel? selectedPickupAdress;
  AdressModel? selectedDeliveryAdress;

  OrderFormController({required this.order });

  void dispose() {
    pickupAddressForm.dispose();
    deliveryAdressForm.dispose();
    selectedPickupAdress = null;
    selectedDeliveryAdress = null;
  }

  void clear() {
    pickupAddressForm.clear();
    deliveryAdressForm.clear();
  }

}

/*
  Future<List<AddressFormController>> getUserAddresses() async {
    final adressFormService = getIt<AdressFormService>();
    final adresses = order.user.personModel?.addresses;
     addressesForms = await adressFormService.getFormControllers(adresses!);
     
    int size = adresses?.length ?? 0;
    if (size > 0) {
      for (int i = 0; i < size; i++) {
        final adressForm = AddressFormController();
        adressForm.setData(adresses?[i] ?? AdressModel.getDaulftObject());
        if(adresses?[i] != null){
          adressForm.isRegisted = true;
        }
        addressesForms.add(adressForm);
      }
    } else {
      final seedService = getIt<SeedService>();
      if (seedService.api.env is EnvDev) {
        final adressTestData = await seedService.getgeneratedAdress();

        addressesForms.add(AddressFormController());
        addressesForms[0].setData(adressTestData);
      } else {
        addressesForms.add(AddressFormController());
      }
    }
    
  } 

// PressingModel, UserModel, PressingOrderItem

*/
