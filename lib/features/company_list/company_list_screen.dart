import 'package:flutter/material.dart';
import 'package:tap_bonds/features/company_list/view_models/company_list_view_model.dart';
import 'package:tap_bonds/features/company_list/widgets/content/main_content_view.dart';
import 'package:tap_bonds/features/company_list/widgets/search_field.dart';

class CompanyListScreen extends StatefulWidget {
  const CompanyListScreen({super.key});

  @override
  State<CompanyListScreen> createState() => _CompanyListScreenState();
}

class _CompanyListScreenState extends State<CompanyListScreen> {
  late CompanyListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    // initialize the view model.
    _viewModel = CompanyListViewModel(context);
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Home header
              Container(
                height: 80,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Home',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),

              SearchField(viewModel: _viewModel),

              const SizedBox(height: 20),

              const MainContentView(),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
