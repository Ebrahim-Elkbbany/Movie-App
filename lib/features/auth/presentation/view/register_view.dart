import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_styles.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';
import 'package:movie_app/features/auth/presentation/view/widgets/register_avatar_selector.dart';
import 'package:movie_app/features/auth/presentation/view/widgets/register_form.dart';
import 'package:movie_app/features/auth/presentation/view/widgets/signup_bloc_listener.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  static const _avatarList = [
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
    AppImages.avatar4,
    AppImages.avatar5,
    AppImages.avatar6,
    AppImages.avatar7,
    AppImages.avatar8,
    AppImages.avatar9,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colors.primary,
            size: 24.r,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Register',
          style: FontStyles.font18Bold.copyWith(color: colors.primary),
        ),
        centerTitle: true,
      ),
      body: SignupBlocListener(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                const RegisterAvatarSelector(avatars: _avatarList),
                SizedBox(height: 24.h),
                RegisterForm(
                  formKey: _formKey,
                  nameController: _nameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  phoneController: _phoneController,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already Have Account ? ',
                      style: FontStyles.font14.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'Login',
                        style: FontStyles.font14.copyWith(
                          color: colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

