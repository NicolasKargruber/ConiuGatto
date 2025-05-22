import 'dart:io';

import 'package:coniugatto/data/utils/verb_data_source.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MockHttpClient extends Mock implements http.Client {}
class MockUri extends Mock implements Uri {}

class MockLocalVerbsFile extends Mock implements LocalVerbsFile {}
class MockFile extends Mock implements File {}

void main() {
  late MockHttpClient mockHttpClient;
  late MockLocalVerbsFile mockLocalVerbsFile;
  late MockFile mockFile;
  late VerbDataSource dataSource;

  final localJsonString = json.encode({
    "meta": {"version": 1.0},
    "verbs": [{"id": "parlare"}]
  });

  final remoteJsonString = json.encode({
    "meta": {"version": 2.0},
    "verbs": [{"id": "andare"}]
  });

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    mockHttpClient = MockHttpClient();
    mockLocalVerbsFile = MockLocalVerbsFile();
    mockFile = MockFile();

    GetIt.I.registerSingleton<http.Client>(mockHttpClient);
    GetIt.I.registerSingleton<LocalVerbsFile>(mockLocalVerbsFile);

    registerFallbackValue(MockUri());

    when(() => mockLocalVerbsFile.instance).thenAnswer((_) async => mockFile);
    dataSource = VerbDataSource();
  });

  tearDown(() {
    GetIt.I.reset();
  });

  test('loadLocalJson returns decoded map', () async {
    when(() => mockFile.readAsString()).thenAnswer((_) async => localJsonString);

    final json = await dataSource.loadLocalJson();

    expect(json, isA<Map<String, dynamic>>());
    expect(json?['verbs'][0]['id'], equals('parlare'));
  });

  test('writeLocalJson writes JSON string to file', () async {
    when(() => mockFile.writeAsString(any())).thenAnswer((_) async => mockFile);

    final data = json.decode(localJsonString) as Map<String, dynamic>;

    await dataSource.writeLocalJson(data);

    verify(() => mockFile.writeAsString(json.encode(data))).called(1);
  });

  test('loadRemoteJson returns parsed JSON on success', () async {
    final uri = Uri.parse('https://raw.githubusercontent.com/NicolasKargruber/ConiuGatto-Verbs/main/coniugatto_verbs.json');
    when(() => mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(remoteJsonString, 200),
    );

    final json = await dataSource.loadRemoteJson();

    expect(json, isA<Map<String, dynamic>>());
    expect(json?['verbs'][0]['id'], equals('andare'));
  });

  test('loadRemoteJson returns null on failure', () async {
    final uri = Uri.parse('https://raw.githubusercontent.com/NicolasKargruber/ConiuGatto-Verbs/main/coniugatto_verbs.json');
    when(() => mockHttpClient.get(uri)).thenThrow(Exception('Network error'));

    final result = await dataSource.loadRemoteJson();

    expect(result, isNull);
  });

  test('loadAndUpdateJson returns local when remote version is older', () async {
    final olderRemote = json.encode({
      "meta": {"version": 1.0},
      "verbs": [{"id": "mangiare"}]
    });

    when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => http.Response(olderRemote, 200),
    );
    when(() => mockFile.readAsString()).thenAnswer((_) async => remoteJsonString);

    final verbs = await dataSource.loadAndUpdateJson();

    expect(verbs, isA<List>());
    expect(verbs?[0]['id'], equals('andare')); // From local file
  });

  test('loadAndUpdateJson updates when remote is newer', () async {
    when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => http.Response(remoteJsonString, 200),
    );
    when(() => mockFile.readAsString()).thenAnswer((_) async => localJsonString);
    when(() => mockFile.writeAsString(any())).thenAnswer((_) async => mockFile);

    final verbs = await dataSource.loadAndUpdateJson();

    expect(verbs, isA<List>());
    expect(verbs?[0]['id'], equals('andare')); // From remote
  });

  test('loadJsonFromAssets loads verbs from asset file', () async {
    const assetJson = '[{"id": "essere"}]';

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
          (message) async {
        final key = utf8.decode(message!.buffer.asUint8List());
        if (key == 'assets/data/verbs.json') {
          return ByteData.view(Uint8List.fromList(utf8.encode(assetJson)).buffer);
        }
        return null;
      },
    );

    final data = await dataSource.loadJsonFromAssets();

    expect(data, isA<List>());
    expect(data.first['id'], equals('essere'));
  });
}
