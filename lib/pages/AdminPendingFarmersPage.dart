import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AdminPendingFarmersPage extends StatefulWidget {
  const AdminPendingFarmersPage({Key? key}) : super(key: key);

  @override
  _AdminPendingFarmersPageState createState() => _AdminPendingFarmersPageState();
}

class _AdminPendingFarmersPageState extends State<AdminPendingFarmersPage> {
  List<Map<String, dynamic>> _pendingApplications = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchPendingApplications();
  }

  Future<void> _fetchPendingApplications() async {
    setState(() => _loading = true);
    final applications = await ApiService.getPendingFarmerApplications();
    setState(() {
      _pendingApplications = applications;
      _loading = false;
    });
  }

  // You can implement approve/reject logic here if you have endpoints for that

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Seller Applications'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _pendingApplications.isEmpty
          ? const Center(child: Text('No pending applications.'))
          : ListView.builder(
        itemCount: _pendingApplications.length,
        itemBuilder: (context, index) {
          final app = _pendingApplications[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(app['shop_name'] ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User ID: ${app['user_id'] ?? ''}'),
                  Text('Province: ${app['province'] ?? ''}'),
                  Text('District: ${app['district'] ?? ''}'),
                  Text('Commune: ${app['commune'] ?? ''}'),
                  Text('Status: ${app['status'] ?? ''}'),
                ],
              ),
              // Add approve/reject buttons here if you have endpoints for them
            ),
          );
        },
      ),
    );
  }
}