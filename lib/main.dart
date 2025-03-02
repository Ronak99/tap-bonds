import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:tap_bonds/core/services/api_service.dart';
import 'package:tap_bonds/features/company_list/bloc/company_list_bloc.dart';
import 'package:tap_bonds/features/company_list/company_list_screen.dart';
import 'package:tap_bonds/locator.dart';
import 'package:tap_bonds/theme/app_theme.dart';

void main() {
  Locator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyListBloc(apiService: Get.find<ApiService>()),
      child: MaterialApp(
        title: 'Company Insights',
        theme: AppTheme.appTheme,
        home: const CompanyListScreen(),
      ),
    );
  }
}
