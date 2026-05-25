import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/features/home/presentation/manager/movies_cubit.dart';
import 'package:movie_app/features/home/presentation/manager/movies_states.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/widgets/home_tab_content.dart';

// class HomeTabView extends StatelessWidget {

//   const HomeTabView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<MoviesCubit, MoviesState>(
//       builder: (context, state) {
//         if (state is MoviesLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (state is MoviesError) {
//           return Center(child: Text(state.message));
//         }

//         if (state is MoviesLoaded) {
//           final movies = state.movies;
//           final featured = movies.take(10).toList();
//           final currentMovie = featured[state.currentIndex];

//           return SingleChildScrollView(
//             child: Stack(
//               children: [
//                 /// BACKGROUND IMAGE
//                 Positioned.fill(
//                   child: CachedNetworkImage(
//                     imageUrl: currentMovie.imageUrl,
//                     fit: BoxFit.cover,

//                     placeholder: (context, url) =>
//                         Container(color: AppColorsExtension.light.primary),

//                     errorWidget: (context, url, error) => Container(
//                       color: AppColorsExtension.light.primary,
//                       child: const Icon(
//                         Icons.broken_image,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),

//                 /// GRADIENT
//                 Positioned.fill(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.transparent,
//                           AppColorsExtension.light.primary.withValues(
//                             alpha: 0.6,
//                           ),
//                           AppColorsExtension.light.primary.withValues(
//                             alpha: 1.0,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//                 /// CONTENT
//                 Column(
//                   children: [
//                     SizedBox(height: 10.h),

//                     Image.asset(AppImages.availableNow, width: 263.w),

//                     Padding(
//                       padding: REdgeInsets.symmetric(vertical: 20.0),
//                       child: CarouselSlider(
//                         items: featured.map((movie) {
//                           return ClipRRect(
//                             borderRadius: BorderRadius.circular(18.r),
//                             child: Stack(
//                               children: [
//                                 Positioned.fill(
//                                   child: CachedNetworkImage(
//                                     imageUrl: movie.imageUrl,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),

//                                 Positioned.fill(
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter,
//                                         colors: [
//                                           Colors.transparent,
//                                           AppColorsExtension.light.primary
//                                               .withValues(alpha: 0.3),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),

//                                 Positioned(
//                                   top: 10.h,
//                                   left: 10.w,
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: 8.w,
//                                       vertical: 4.h,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: AppColorsExtension.light.primary
//                                           .withValues(alpha: 0.9),
//                                       borderRadius: BorderRadius.circular(12.r),
//                                     ),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                           movie.rating.toStringAsFixed(1),
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium
//                                               ?.copyWith(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                         ),
//                                         SizedBox(width: 4.w),
//                                         SvgPicture.asset(
//                                           AppIcons.star,
//                                           width: 15.w,
//                                           height: 15.h,
//                                           colorFilter: const ColorFilter.mode(
//                                             Colors.amber,
//                                             BlendMode.srcIn,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }).toList(),

//                         options: CarouselOptions(
//                           height: 352.h,
//                           viewportFraction: 0.55,
//                           enlargeCenterPage: true,
//                           enlargeFactor: 0.25,
//                           initialPage: 0,
//                           autoPlay: true,
//                           enableInfiniteScroll: true,
//                           autoPlayInterval: const Duration(seconds: 4),
//                           autoPlayAnimationDuration: const Duration(
//                             milliseconds: 800,
//                           ),
//                           scrollPhysics: const BouncingScrollPhysics(),
//                           onPageChanged: (index, reason) {
//                             context.read<MoviesCubit>().changeIndex(index);
//                           },
//                         ),
//                       ),
//                     ),

//                     Image.asset(AppImages.watchNow, width: 320.w),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         }

//         return const SizedBox();
//       },
//     );
//   }
// }

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is MoviesError) {
          return Center(child: Text(state.message));
        }

        if (state is MoviesLoaded) {
          return HomeContent(state: state);
        }

        return const SizedBox();
      },
    );
  }
}
