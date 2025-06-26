import 'package:flutter/material.dart';
import 'package:map_pro/core/theme/app_color.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CommonAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      title: Text(title),
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.dashboard, color: AppColors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        },
      ),
    );
  }
}
