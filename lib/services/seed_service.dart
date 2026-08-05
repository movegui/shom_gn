import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:shom_gn/models/adress_model.dart';
import 'package:shom_gn/models/geo_cordinates_model.dart';
import 'package:shom_gn/services/api_service.dart';
import 'package:uuid/uuid.dart';

class SeedService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ApiService api;
  final Faker faker;

  SeedService({required this.api, required this.faker});

  /*

  Future<PressingModel> generatePressing() async => PressingModel(
    id: Uuid().v4(),
    name: faker.company.name(),
    createdAt: DateTime.now(),
    description: faker.company.random.fromPattern(['description']),
    address: AdressModel(
      address: faker.address.streetName(),
      id: Uuid().v4(),
      name: faker.address.streetAddress(),
      createdAt: DateTime.now(),
      district: faker.address.city(),
      minucipality: faker.address.city(),
      geoCordinates: GeoCordinatesModel(
        longitude: faker.geo.longitude(),
        latitude: faker.geo.latitude(),
      ), adressType: 'h',
    ),
    staff: [
      UserModel(
        updatedAt: DateTime.now(),
        id: Uuid().v4(),
        name: '',
        createdAt: DateTime.now(),
        username: null,
        isVerified: false,
        role: UserRole.Guest.name,
        personModel: PersonModel(
          id: Uuid().v4(),
          name: faker.person.name(),
          createdAt: DateTime.now(),
          firstName: faker.person.firstName(),
          lastName: faker.person.lastName(),
          profileImageUrl: faker.image.toString(),
          email: faker.internet.email(),
          phone: faker.phoneNumber.de(),
          gender: 'm',
          birthDate: faker.date.dateTime(),
          addresses: [
            AdressModel(
              address: faker.address.streetName(),
              id: Uuid().v4(),
              name: faker.address.streetAddress(),
              createdAt: DateTime.now(),
              district: faker.address.city(),
              minucipality: faker.address.city(),
              geoCordinates: GeoCordinatesModel(
                longitude: faker.geo.longitude(),
                latitude: faker.geo.latitude(),
              ), adressType: 'h',
            ),
          ],
        ),
      ),
    ],
    email: faker.internet.email(),
    imageUrl: faker.image.toString(),
    phone: faker.phoneNumber.de(),
    weeklyHours: [
      OpenHoursModel(
        day: 'lundi',
        openTime: TimeOfDay(hour: 09, minute: 00),
        closeTime: TimeOfDay(hour: 17, minute: 30),
      ),
    ],
    storeType: RestaurantTypeModel(
      id: Uuid().v4(),
      name: faker.company.name(),
      createdAt: DateTime.now(),
    ),
    rating: 0.0,
    reviewCount: 0,
  );

  Future<PressingServiceModel> getGeneratedPressingService() async =>
      PressingServiceModel(
        id: Uuid().v4(),
        product: PressingArticleModel(
          id: Uuid().v4(),
          name: faker.lorem.word(),
          imageUrl: '',
          createdAt: DateTime.now(),
          price: faker.currency.random.decimal(),
          supplier: null,
          category: '',
          isAvailable: true,
          currency: '',
        ),
        serviceType: PressingServiceTypeModel(
          id: Uuid().v4(),
          name: faker.lorem.word(),
          description: faker.job.title(),
          pricingType: PricingType.fixed.name,
          createdAt: DateTime.now(),
        ),
        minPrice: 1000,
        maxPrice: 5000,
        basePrice: 1000,
        estimatedDuration: Duration(),
        name: faker.food.restaurant(),
        createdAt: DateTime.now(),
      );

  Future<PersonModel> getGeneratedPerson() async => PersonModel(
    id: Uuid().v4(),
    name: faker.person.name(),
    createdAt: DateTime.now(),
    firstName: faker.person.firstName(),
    lastName: faker.person.lastName(),
    profileImageUrl: faker.image.toString(),
    email: faker.internet.email(),
    phone: faker.phoneNumber.de(),
    gender: 'm',
    birthDate: faker.date.dateTime(),
    addresses: [
      AdressModel(
        address: faker.address.streetName(),
        id: Uuid().v4(),
        name: faker.address.streetAddress(),
        createdAt: DateTime.now(),
        district: faker.address.city(),
        minucipality: faker.address.city(),
        geoCordinates: GeoCordinatesModel(
          longitude: faker.geo.longitude(),
          latitude: faker.geo.latitude(),
        ),
        adressType: 'h',
      ),
    ],
  );
  */

  Future<AdressModel> getgeneratedAdress() async => AdressModel(
    address: faker.address.streetName(),
    id: Uuid().v4(),
    name: faker.address.streetAddress(),
    createdAt: DateTime.now(),
    district: faker.address.city(),
    minucipality: 'di',
    geoCordinates: GeoCordinatesModel(
      longitude: faker.geo.longitude(),
      latitude: faker.geo.latitude(),
    ),
    adressType: 'h',
  );
}
