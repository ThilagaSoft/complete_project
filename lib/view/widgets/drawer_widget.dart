import 'package:flutter/material.dart';

class CommonDrawer extends StatelessWidget {
  final VoidCallback? onHomeTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onLogoutTap;
  final String title;
  final Color headerColor;

  const CommonDrawer({
    super.key,
    this.onHomeTap,
    this.onProfileTap,
    this.onLogoutTap,
    this.title = 'Welcome!',
    this.headerColor = Colors.blue, // or AppColors.primary if imported
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: headerColor),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              onHomeTap?.call();
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat'),
            onTap: () {
              Navigator.pop(context);
              onHomeTap?.call();
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              onProfileTap?.call();
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Language'),
            onTap: () {
              Navigator.pop(context);
              onHomeTap?.call();
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              onLogoutTap?.call();
            },
          ),
        ],
      ),
    );
  }
}
