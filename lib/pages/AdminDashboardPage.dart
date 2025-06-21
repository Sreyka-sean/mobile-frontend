import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.assignment_ind, color: Colors.green),
            title: const Text('Pending Seller Applications'),
            onTap: () => Navigator.pushNamed(context, '/admin-pending-farmers'),
          ),
          ListTile(
            leading: const Icon(Icons.people, color: Colors.green),
            title: const Text('All Users'),
            onTap: () => Navigator.pushNamed(context, '/admin-users'),
          ),
          // Add more admin features here as needed
        ],
      ),
    );
  }
}