import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class HomeAppBar extends StatefulWidget {
  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  String? userName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      // Fetch user profile from backend
      final user = await ApiService.getProfile();
      setState(() {
        userName = user?.name ?? '';
        isLoading = false;
      });
    } else {
      setState(() {
        userName = null;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(35),
          child: Row(
            children: [
              const Icon(
                Icons.sort,
                size: 30,
                color: Colors.green,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Agriculture market",
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              const Spacer(),
              isLoading
                  ? const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : InkWell(
                onTap: () {
                  if (userName != null && userName!.isNotEmpty) {
                    Navigator.pushNamed(context, '/my-profile-page');
                  } else {
                    Navigator.pushNamed(context, '/LoginSignupPage');
                  }
                },
                child: userName != null && userName!.isNotEmpty
                    ? Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      userName!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
                    : const Icon(
                  Icons.person_outline,
                  size: 30,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 10),
              badges.Badge(
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.red,
                ),
                badgeContent: const Text(
                  "3",
                  style: TextStyle(color: Colors.white),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'CartPage');
                  },
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 30,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}