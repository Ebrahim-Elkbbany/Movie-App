import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/constants/app_constants.dart';
import 'package:movie_app/core/widgets/buttons/custom_button_primary.dart';

class OnboardingItem extends StatelessWidget {
  final bool isLastPage;
  final bool isFirstPage;
  final bool showBackButton;
  final void Function() nextPage;
  final void Function() backPage;
  final String image;
  final String title;
  final String? description;

  const OnboardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,

    this.isLastPage = false,
    this.isFirstPage = true,
    this.showBackButton = false,
    required this.nextPage,
    required this.backPage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),

              color: isFirstPage
                  ? Colors.transparent
                  : theme.scaffoldBackgroundColor,
            ),

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 12.h),

                  if (description != null) ...[
                    SizedBox(height: 12.h),

                    Text(
                      description!,
                      style: theme.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],

                  SizedBox(height: 16.h),

                  PrimaryButton(
                    text: isFirstPage
                        ? AppConstants.exploreNow
                        : isLastPage
                        ? AppConstants.finish
                        : AppConstants.next,
                    onPressed: nextPage,
                  ),

                  if (showBackButton) ...[
                    SizedBox(height: 16.h),

                    TransparentButton(
                      text: AppConstants.back,
                      onPressed: backPage,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
