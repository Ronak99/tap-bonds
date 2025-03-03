import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tap_bonds/core/models/company/company.dart';

class CompanyListItem extends StatelessWidget {
  final Company company;
  final bool isFirst;
  final bool isLast;
  final List<String>? searchTerms;
  const CompanyListItem({
    super.key,
    required this.company,
    required this.isFirst,
    required this.isLast,
    required this.searchTerms,
  });

  Widget _buildHighlightedIsin(String isin, List<String> searchTerms) {
    if (searchTerms.isEmpty) {
      // When the search terms are empty, in other words, no search has been made yet.
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

// Highlihgt the company name.
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

// Helper method.
  void _addHighlightedSpans(List<InlineSpan> spans, String text,
      List<String> searchTerms, TextStyle baseStyle) {
    if (searchTerms.isEmpty) {
      spans.add(TextSpan(text: text, style: baseStyle));
      return;
    }

    // Create a pattern from all search terms joined with | or the OR operator.
    final pattern = RegExp(
      searchTerms.map((term) => RegExp.escape(term)).join('|'),
      caseSensitive: false,
    );

    // Trakcer
    int lastMatchEnd = 0;

    // Match against the pattern
    for (var match in pattern.allMatches(text.toLowerCase())) {
      // Add text before the match
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: text.substring(lastMatchEnd, match.start),
          style: baseStyle,
        ));
      }

      /// Add the highlighted match - using the ORIGINAL case from the text, not the lowercase match
      /// I wanted to replicate the UI exactly by adding the WidgetSpan, but then it makes the text flicker and does not look as good.

      // spans.add(WidgetSpan(
      //   alignment: PlaceholderAlignment.middle,
      //   child: AnimatedContainer(
      //     duration: const Duration(milliseconds: 1300),
      //     padding: const EdgeInsets.symmetric(horizontal: .25, vertical: 2.0),
      //     decoration: BoxDecoration(
      //       color: const Color(0xffD97706).withOpacity(.16),
      //       borderRadius: BorderRadius.circular(4.0),
      //     ),
      //     child: Text(
      //       text.substring(match.start, match.end),
      //       style: baseStyle,
      //     ),
      //   ),
      // ));

      /// Using normal TextSpan instead.
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: baseStyle.copyWith(
          backgroundColor: const Color(0xffD97706).withOpacity(.16),
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

  /// Addresses dynamic border radius for the top, last and the middle list items.
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

  /// Handles border for each item and also adds a bottom border when the UI is in search mode.
  /// Exactly how the Figma design describes.
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

  Widget _buildCompanyLogo() {
    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: getItemBorderRadius(isFirst, isLast),
        border: getItemBorder(
          isFirst,
          isLast,
          searchTerms: searchTerms,
        ),
      ),
      child: Row(
        children: [
          _buildCompanyLogo(),

          const SizedBox(width: 10),

          // Company Details
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHighlightedIsin(company.isin, searchTerms ?? []),
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
                    margin: const EdgeInsets.symmetric(horizontal: 4),
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
    );
  }
}
