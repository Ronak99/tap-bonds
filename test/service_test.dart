import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tap_bonds/core/models/company/company.dart';
import 'package:tap_bonds/core/models/company_detail/company_detail.dart';
import 'package:tap_bonds/core/services/api_service.dart';

import 'service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late ApiService apiService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    apiService = ApiService(mockDio);
  });

  group('ApiService', () {
    test('getCompanies returns list of companies when API call is successful',
        () async {
      // Arrange
      final mockResponse = Response(
        data: {
          'data': [
            {
              'logo': 'logo1.png',
              'isin': 'ISIN1',
              'rating': 'AAA',
              'company_name': 'Company 1',
              'tags': ['tag1', 'tag2']
            },
            {
              'logo': 'logo2.png',
              'isin': 'ISIN2',
              'rating': 'AA',
              'company_name': 'Company 2',
              'tags': ['tag3', 'tag4']
            },
          ]
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get('https://eol122duf9sy4de.m.pipedream.net/'))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await apiService.getCompanies();

      // Assert
      expect(result, isA<List<Company>>());
      expect(result.length, 2);
      expect(result[0].companyName, 'Company 1');
      expect(result[1].companyName, 'Company 2');
      expect(result[0].isin, 'ISIN1');
      expect(result[1].tags, ['tag3', 'tag4']);

      verify(mockDio.get('https://eol122duf9sy4de.m.pipedream.net/')).called(1);
    });

    test('getCompanies throws an exception when API call fails', () async {
      // Arrange
      when(mockDio.get('https://eol122duf9sy4de.m.pipedream.net/'))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'Network error',
      ));

      // Act & Assert
      expect(() => apiService.getCompanies(), throwsException);
      verify(mockDio.get('https://eol122duf9sy4de.m.pipedream.net/')).called(1);
    });

    test('getCompanyDetail returns company detail when API call is successful',
        () async {
      // Arrange
      final mockResponse = Response(
        data: {
          'logo': 'logo1.png',
          'company_name': 'Company 1',
          'description': 'Description 1',
          'isin': 'ISIN1',
          'status': 'Active',
          'pros_and_cons': {
            'pros': ['pro1', 'pro2'],
            'cons': ['con1', 'con2']
          },
          'financials': {
            'ebitda': [
              {'month': 'Jan', 'value': 1000},
              {'month': 'Feb', 'value': 1200}
            ],
            'revenue': [
              {'month': 'Jan', 'value': 5000},
              {'month': 'Feb', 'value': 5500}
            ]
          },
          'issuer_details': {
            'issuer_name': 'Issuer 1',
            'type_of_issuer': 'Corporate',
            'sector': 'Technology',
            'industry': 'Software',
            'issuer_nature': 'Private',
            'cin': 'CIN123456',
            'lead_manager': 'Manager 1',
            'registrar': 'Registrar 1',
            'debenture_trustee': 'Trustee 1'
          }
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get('https://eo61q3zd4heiwke.m.pipedream.net/'))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await apiService.getCompanyDetail();

      // Assert
      expect(result, isA<CompanyDetail>());
      expect(result.companyName, 'Company 1');
      expect(result.isin, 'ISIN1');
      expect(result.prosAndCons.pros, ['pro1', 'pro2']);
      expect(result.financials.ebitda[1].value, 1200);
      expect(result.issuerDetails.issuerName, 'Issuer 1');

      verify(mockDio.get('https://eo61q3zd4heiwke.m.pipedream.net/')).called(1);
    });

    test('getCompanyDetail throws an exception when API call fails', () async {
      // Arrange
      when(mockDio.get('https://eo61q3zd4heiwke.m.pipedream.net/'))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'Network error',
      ));

      // Act & Assert
      expect(() => apiService.getCompanyDetail(), throwsException);
      verify(mockDio.get('https://eo61q3zd4heiwke.m.pipedream.net/')).called(1);
    });
  });
}
