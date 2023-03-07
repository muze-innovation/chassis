import 'package:basic/utils/readability.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chassis/flutter_chassis.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('Test schema validator', () {
    late SchemaValidator validator;
    late Map<String, dynamic> schema;
    late Map<String, dynamic> source;
    late Map<String, dynamic> mockResp;
    late List<dynamic> items;

    setUp(() async {
      schema = await Readability.readFrom('assets/schema.json');
      source = await Readability.readFrom('assets/source.json');
      mockResp =
          await Readability.readFrom('test/mocks/mock_response_schema.json');
      items = source['items'] as List<dynamic>;
      validator = SchemaValidator(schema: schema);
    });

    test('Payload type static should be true', () {
      final chassieItems = items.map((e) => ChassisItem.fromJson(e));
      expect(validator.validate(chassieItems.first), true);
    });

    test('Payload type static should be false', () {
      items.first['payload']['data'] = null;
      final chassieItems = items.map((e) => ChassisItem.fromJson(e));
      expect(validator.validate(chassieItems.first), false);
    });

    test('Payload type remote should be true', () {
      final chassieItems = items.map((e) => ChassisItem.fromJson(e));
      expect(validator.validate(chassieItems.elementAt(2)), true);
    });

    test('Payload type remote should be false', () {
      items.elementAt(2)['payload']['resolvedWith'] = null;
      final chassieItems = items.map((e) => ChassisItem.fromJson(e));
      expect(validator.validate(chassieItems.elementAt(2)), false);
    });

    test('Data from service should be true', () {
      final validData = mockResp['itemsValid'];
      final response = ChassisResponse(resolvedWith: '', output: validData);
      expect(validator.validate(response), true);
    });

    test('Data from service should be false', () {
      final inValidData = mockResp['itemsInValid'];
      final response = ChassisResponse(resolvedWith: '', output: inValidData);
      expect(validator.validate(response), false);
    });
  });
}
