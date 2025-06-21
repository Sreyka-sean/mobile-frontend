import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BecomeSellerPage extends StatefulWidget {
  const BecomeSellerPage({Key? key}) : super(key: key);

  @override
  _BecomeSellerPageState createState() => _BecomeSellerPageState();
}

class _BecomeSellerPageState extends State<BecomeSellerPage> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _districtController = TextEditingController();
  final _communeController = TextEditingController();
  String? _selectedProvince;
  bool _checkingStatus = true;

  final List<String> _provinces = [
    'Bangkok',
    'Chiang Mai',
    'Phuket',
    'Khon Kaen',
    'Nakhon Ratchasima',
    'Surat Thani',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final status = await ApiService.getSellerApplicationStatus();
    if (status == 'pending') {
      Navigator.pushReplacementNamed(context, '/pending-seller-page');
    } else if (status == 'approved') {
      Navigator.pushReplacementNamed(context, '/earning-dashboard-page');
    } else {
      setState(() {
        _checkingStatus = false; // Show the form
      });
    }
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _districtController.dispose();
    _communeController.dispose();
    super.dispose();
  }

  Future<void> _submitApplication() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must be logged in to apply.')),
        );
        return;
      }

      final success = await ApiService.applyFarmer(
        shopName: _businessNameController.text,
        province: _selectedProvince ?? '',
        district: _districtController.text,
        commune: _communeController.text,
      );
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application submitted successfully!')),
        );
        Navigator.pushReplacementNamed(context, '/pending-seller-page');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Submission failed!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingStatus) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Become a Seller"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text(
                  'Please fill in your details to apply as a seller.',
                  style: TextStyle(fontSize: 16, color: Colors.green),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _businessNameController,
                  decoration: InputDecoration(
                    labelText: 'Business Name',
                    labelStyle: const TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your business name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  value: _selectedProvince,
                  decoration: InputDecoration(
                    labelText: 'Province',
                    labelStyle: const TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: _provinces.map((province) {
                    return DropdownMenuItem<String>(
                      value: province,
                      child: Text(province),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProvince = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a province';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _districtController,
                  decoration: InputDecoration(
                    labelText: 'District',
                    labelStyle: const TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your district';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _communeController,
                  decoration: InputDecoration(
                    labelText: 'Commune',
                    labelStyle: const TextStyle(color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your commune';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitApplication,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: const Text(
                      'Submit Application',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}