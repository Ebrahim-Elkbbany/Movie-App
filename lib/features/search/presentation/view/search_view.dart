import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';
import 'package:movie_app/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:movie_app/features/search/presentation/manager/search_cubit.dart';
import 'package:movie_app/features/search/presentation/manager/search_state.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/movie_card.dart';

class SearchViewTab extends StatelessWidget {
  const SearchViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: Column(
            children: [
              CustomTextFormField(
                inputTextStyle: TextStyle(
                  color: AppColorsExtension.dark.textPrimary,
                ),
                backgroundColor: AppColorsExtension.dark.surface,
                prefixIcon: Icons.search,
                hintText: 'Search',

                onFieldSubmitted: (value) {
                  context.read<SearchCubit>().searchMovies(value);
                },
              ),

              SizedBox(height: 20.h),

              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    final cubit = context.read<SearchCubit>();

                    if (state is SearchLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColorsExtension.light.textPrimary,
                        ),
                      );
                    }

                    if (state is SearchError) {
                      return Center(child: Text(state.message));
                    }

                    if (cubit.movies.isEmpty) {
                      return Center(
                        child: Image.asset(
                          AppImages.empty,
                          width: 130,
                          height: 130,
                        ),
                      );
                    }

                    return GridView.builder(
                      controller: cubit.scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: cubit.movies.length,
                      itemBuilder: (context, index) {
                        return MoviesCard(movie: cubit.movies[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
