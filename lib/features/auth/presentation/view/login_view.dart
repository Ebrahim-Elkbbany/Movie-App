import 'package:flutter/material.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/features/auth/presentation/view/widgets/login_bloc_listener.dart';
import 'package:movie_app/features/auth/presentation/view/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Scaffold(
      backgroundColor: colors.background,
      body: const LoginBlocListener(
        child: LoginViewBody(),
      ),
    );
  }
}
