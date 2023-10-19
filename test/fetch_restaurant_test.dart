import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant_list.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'fetch_restaurant_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  const String jsonString = '''
  {
	"error": false,
	"message": "success",
	"count": 20,
	"restaurants": [
		{
			"id": "vfsqv0t48jkfw1e867",
			"name": "Gigitan Makro",
			"description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
			"pictureId": "04",
			"city": "Surabaya",
			"rating": 4.9
		}
	]
}
  ''';

  group('Test Restaurant API', () {
    final MockClient mockClient = MockClient();
    final ApiService apiService = ApiService(mockClient);
    final Uri uri = Uri.parse('${ApiService.baseUrl}list');

    test('verify json parsing fetch all restaurant', () async {
      when(mockClient.get(uri, headers: null))
          .thenAnswer((_) async => http.Response(jsonString, 200));
      final result = await apiService.getListRestaurant();
      expect(result, isA<RestaurantList>());
    });

    test('should throw an error when status code is not 200', () async {
      // arrange
      when(mockClient.get(uri)).thenAnswer((_) async => http.Response('', 404));
      // act
      final call = apiService.getListRestaurant();
      // assert
      expect(() => call, throwsA(isA<Exception>()));
      verify(mockClient.get(uri));
    });
  });
}
