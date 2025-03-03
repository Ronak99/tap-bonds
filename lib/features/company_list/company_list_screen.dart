import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tap_bonds/core/models/company.dart';
import 'package:tap_bonds/core/services/api_service.dart';
import 'package:tap_bonds/features/company_details/bloc/company_detail_bloc.dart';
import 'package:tap_bonds/features/company_details/company_detail_screen.dart';
import 'package:tap_bonds/features/company_list/bloc/company_list_bloc.dart';
import 'package:tap_bonds/features/company_list/bloc/company_list_state.dart';
import 'package:tap_bonds/features/company_list/view_models/company_list_view_model.dart';
import 'package:tap_bonds/shared/widgets/loading_indicator.dart';

import '../../shared/widgets/content_container.dart';

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
              Container(
                height: 80,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Home',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              ContentContainer(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/MagnifyingGlass.svg'),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CupertinoTextField(
                        controller: _viewModel.searchController,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0,
                            color: Colors.transparent,
                          ),
                        ),
                        placeholder: "Search by Issuer Name or ISIN",
                        placeholderStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff99A1AF),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<CompanyListBloc, CompanyListState>(
                builder: (context, state) {
                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 4, bottom: 8),
                          child: Text(
                            state is CompanySearchResult
                                ? 'Search Results'.toUpperCase()
                                : 'Suggested Results'.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              height: 1.5,
                              letterSpacing: 1.2,
                              color: Color(
                                0xff99A1AF,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: BlocBuilder<CompanyListBloc, CompanyListState>(
                            builder: (context, state) {
                              if (state is CompanyListLoading) {
                                return const LoadingIndicator();
                              } else if (state is CompanyListLoaded) {
                                return _buildCompanyList(state.companies);
                              } else if (state is CompanySearchResult) {
                                return _buildCompanyList(
                                  state.companies,
                                  searchTerms: state.searchTerms,
                                );
                              } else if (state is CompanyListError) {
                                return Center(
                                    child: Text('Error: ${state.message}'));
                              }
                              return const Center(
                                child: Text('No companies found'),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius? getItemBorderRadius(bool isFirst, bool isLast) {
    if (isFirst && isLast) {
      return BorderRadius.circular(8);
    } else if (isFirst) {
      return const BorderRadius.vertical(top: Radius.circular(8));
    } else if (isLast) {
      return const BorderRadius.vertical(
        bottom: Radius.circular(8),
      );
    } else {
      return null;
    }
  }

  Border? getItemBorder(
    bool isFirst,
    bool isLast, {
    List<String>? searchTerms,
  }) {
    return Border(
      top: isFirst
          ? const BorderSide(
              width: 0.5,
              color: Color(0xffe5e7eb),
            )
          : BorderSide.none,
      left: const BorderSide(
        width: 0.5,
        color: Color(0xffe5e7eb),
      ),
      right: const BorderSide(
        width: 0.5,
        color: Color(0xffe5e7eb),
      ),
      bottom: isLast || searchTerms != null
          ? const BorderSide(
              width: 0.5,
              color: Color(0xffe5e7eb),
            )
          : BorderSide.none,
    );
  }

  Widget _buildCompanyList(List<Company> companies,
      {List<String>? searchTerms}) {
    if (companies.isEmpty) {
      return const Center(
        child: Text('No companies found.'),
      );
    }

    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        final company = companies[index];
        final bool isFirst = index == 0;
        final bool isLast = index == companies.length - 1;

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => {
            HapticFeedback.mediumImpact(),
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => CompanyDetailBloc(
                    apiService: Get.find<ApiService>(),
                  ),
                  child: const CompanyDetailScreen(),
                ),
              ),
            ),
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: searchTerms != null
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: getItemBorderRadius(isFirst, isLast),
                    border: getItemBorder(
                      isFirst,
                      isLast,
                      searchTerms: searchTerms,
                    ),
                  )
                : BoxDecoration(
                    color: Colors.white,
                    borderRadius: getItemBorderRadius(isFirst, isLast),
                    border: getItemBorder(isFirst, isLast),
                  ),
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: .4,
                            color: const Color(0xffE5E7EB),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            company.logo,
                            fit: BoxFit.contain,
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHighlightedIsin(
                              company.isin, searchTerms ?? []),
                          const SizedBox(height: 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                company.rating,
                                style: const TextStyle(
                                  color: Color(0xff99A1AF),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: const Text(
                                  "·",
                                  style: TextStyle(
                                    color: Color(0xff99A1AF),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              _buildHighlightedCompanyName(
                                company.companyName,
                                searchTerms ?? [],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      SvgPicture.asset('assets/CaretRight.svg')
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// New method to highlight ISIN with search terms
  Widget _buildHighlightedIsin(String isin, List<String> searchTerms) {
    if (searchTerms.isEmpty) {
      // Original formatting without highlighting
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: isin.substring(0, isin.length - 4),
              style: const TextStyle(
                color: Color(0xff6A7282),
                fontWeight: FontWeight.w400,
                fontSize: 12,
                letterSpacing: .5,
              ),
            ),
            TextSpan(
              text: isin.substring(isin.length - 4),
              style: const TextStyle(
                color: Color(0xff1E2939),
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: .5,
              ),
            ),
          ],
        ),
      );
    }

    // Create a version of the text that will be used for highlighting
    List<InlineSpan> spans = [];

    // Process first part of ISIN
    String firstPart = isin.substring(0, isin.length - 4);
    _addHighlightedSpans(
      spans,
      firstPart,
      searchTerms,
      const TextStyle(
        color: Color(0xff6A7282),
        fontWeight: FontWeight.w400,
        fontSize: 12,
        letterSpacing: .5,
      ),
    );

    // Process last 4 characters of ISIN
    String lastPart = isin.substring(isin.length - 4);
    _addHighlightedSpans(
      spans,
      lastPart,
      searchTerms,
      const TextStyle(
        color: Color(0xff1E2939),
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: .5,
      ),
    );

    return RichText(text: TextSpan(children: spans));
  }

// New method to highlight company name with search terms
  Widget _buildHighlightedCompanyName(
    String companyName,
    List<String> searchTerms,
  ) {
    if (searchTerms.isEmpty) {
      // Original formatting without highlighting
      return Text(
        companyName,
        style: const TextStyle(
          color: Color(0xff99A1AF),
          fontWeight: FontWeight.w400,
          fontSize: 10,
        ),
      );
    }

    List<InlineSpan> spans = [];
    _addHighlightedSpans(
      spans,
      companyName,
      searchTerms,
      const TextStyle(
        color: Color(0xff99A1AF),
        fontWeight: FontWeight.w400,
        fontSize: 10,
      ),
    );

    return RichText(text: TextSpan(children: spans));
  }

// Helper method to add highlighted spans to a list
  void _addHighlightedSpans(List<InlineSpan> spans, String text,
      List<String> searchTerms, TextStyle baseStyle) {
    if (searchTerms.isEmpty) {
      spans.add(TextSpan(text: text, style: baseStyle));
      return;
    }

    // Create a case-insensitive pattern from all search terms joined with OR
    final pattern = RegExp(
      searchTerms.map((term) => RegExp.escape(term)).join('|'),
      caseSensitive: false,
    );

    // Keep track of where we are in the original string
    int lastMatchEnd = 0;

    // Find all matches in the text
    for (var match in pattern.allMatches(text.toLowerCase())) {
      // Add text before the match
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: baseStyle,
        ));
      }

      // Add the highlighted match - using the ORIGINAL case from the text, not the lowercase match
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 1300),
          padding: const EdgeInsets.symmetric(horizontal: .25, vertical: 2.0),
          decoration: BoxDecoration(
            color: const Color(0xffD97706).withOpacity(.16),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            text.substring(match.start, match.end),
            style: baseStyle,
          ),
        ),
      ));

      lastMatchEnd = match.end;
    }

    // Add any remaining text after the last matcha
    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastMatchEnd),
        style: baseStyle,
      ));
    }
  }
}
