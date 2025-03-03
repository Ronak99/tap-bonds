import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../models/company.dart';
import '../models/company_detail.dart';

@injectable
class ApiService {
  final Dio _dio = Dio();

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
