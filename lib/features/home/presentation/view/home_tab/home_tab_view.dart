import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    print(AppIcons.star);
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(AppImages.availableNow, width: 263.w, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: CarouselSlider(
              items: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Stack(
                    children: [
                      /// الصورة
                      Image.asset(
                        AppImages.onBoarding1,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),

                      /// الـ Rating
                      Positioned(
                        top: 10.h,
                        left: 10.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColorsExtension.light.primary.withOpacity(
                              0.7,
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "7. ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(width: 4.w),
                              SvgPicture.asset(
                                AppIcons.star,
                                width: 15.w,

                                height: 15.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              options: CarouselOptions(
                autoPlay: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                viewportFraction: 0.55,
                enlargeFactor: .25,
                height: 340,
              ),
            ),
          ),
          Image.asset(AppImages.watchNow, width: 354.w, fit: BoxFit.cover),
        ],
      ),
    );
  }
}
