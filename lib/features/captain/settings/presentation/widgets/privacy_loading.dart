import 'package:flutter/material.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:shimmer/shimmer.dart';

class PrivacyPolicyShimmer extends StatelessWidget {
  const PrivacyPolicyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.bodyHeight * .2),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  List.generate(10, (index) => _buildShimmerLine(context)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        height: 15.0,
        color: Colors.white,
      ),
    );
  }
}
