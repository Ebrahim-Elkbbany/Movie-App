import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_styles.dart';
import 'package:movie_app/features/auth/presentation/manager/signup_cubit/signup_cubit.dart';

class RegisterAvatarSelector extends StatefulWidget {
  const RegisterAvatarSelector({super.key, required this.avatars});

  final List<String> avatars;

  @override
  State<RegisterAvatarSelector> createState() => _RegisterAvatarSelectorState();
}

class _RegisterAvatarSelectorState extends State<RegisterAvatarSelector> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Start at a high number that is a multiple of avatars.length
    // so we can scroll infinitely in both directions.
    final initialPage = widget.avatars.length * 1000;
    _pageController = PageController(viewportFraction: 0.4, initialPage: initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (p, c) => c is SignupAvatarChanged,
      builder: (context, state) {
        final cubit = context.read<SignupCubit>();
        final selected = cubit.selectedAvatar;

        return Column(
          children: [
            SizedBox(
              height: 140.h,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  final realIndex = index % widget.avatars.length;
                  cubit.selectAvatar(widget.avatars[realIndex]);
                },
                itemBuilder: (context, i) {
                  final realIndex = i % widget.avatars.length;
                  final isSelected = widget.avatars[realIndex] == selected;
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        i,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      cubit.selectAvatar(widget.avatars[realIndex]);
                    },
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      scale: isSelected ? 1.0 : 0.75,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: isSelected ? 1.0 : 0.6,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            widget.avatars[realIndex],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Avatar',
              style: FontStyles.font16SemiBold.copyWith(color: colors.textPrimary),
            ),
          ],
        );
      },
    );
  }
}
