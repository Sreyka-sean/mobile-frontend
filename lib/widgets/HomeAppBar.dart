import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 18), // Add space above to lower the bar
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
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/LoginSignupPage'); // Updated route name
                },
                child: const Icon(
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
                    Navigator.pushNamed(context, 'CartPage'); // Updated route name
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