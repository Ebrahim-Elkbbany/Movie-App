import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/utils/extensions/context_extension.dart';

class GenreSelector extends StatefulWidget {
  final List<String> genres;
  final ValueChanged<int> onGenreChanged;

  const GenreSelector({
    super.key,
    required this.genres,
    required this.onGenreChanged,
  });

  @override
  State<GenreSelector> createState() => _GenreSelectorState();
}

class _GenreSelectorState extends State<GenreSelector> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.genres.length,
        separatorBuilder: (context, index) => 10.horizontalSpace,
        itemBuilder: (context, index) {
          final bool isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
              widget.onGenreChanged(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: REdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? context.customColors.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15.r),
                border: isSelected
                    ? null
                    : Border.all(
                        color: context.customColors.primary,
                        width: 1.5,
                      ),
              ),
              child: Center(
                child: Text(
                  widget.genres[index],
                  style: context.textTheme.titleMedium?.copyWith(
                    color: isSelected
                        ? context.customColors.background
                        : context.customColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
