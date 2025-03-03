import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_bonds/core/models/company_detail/company_detail.dart';
import '../models/company/company.dart';
import '../models/company_detail.dart';

@injectable
class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<List<Company>> getCompanies() async {
    try {
      final response =
          await _dio.get('https://eol122duf9sy4de.m.pipedream.net/');
      final data = response.data['data'] as List;
      return data.map((json) => Company.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load companies: $e');
    }
  }

  Future<CompanyDetail> getCompanyDetail() async {
    try {
      final response =
          await _dio.get('https://eo61q3zd4heiwke.m.pipedream.net/');
      return CompanyDetail.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load company detail: $e');
    }
  }
}
