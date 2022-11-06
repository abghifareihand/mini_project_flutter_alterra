import 'package:mini_project_flutter_alterra/models/restaurant_model.dart';
import 'package:mini_project_flutter_alterra/services/api_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'restaurant_api_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  group('Unit Api Test', () {
    ApiService apiService = MockApiService();

    test('get all restaurants', () async {
      when(apiService.restaurantList()).thenAnswer(
        (realInvocation) async => <RestaurantModel>[
          RestaurantModel(
            id: 'a',
            name: 'name',
            description: 'description',
            pictureId: 'pictureId',
            city: 'city',
            rating: 0,
          ),
        ],
      );
      var resto = await ApiService().restaurantList();
      expect(resto.isNotEmpty, true);
    });
  });
}
