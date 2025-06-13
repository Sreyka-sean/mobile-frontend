import 'package:flutter/material.dart';

class EarningDashboardPage extends StatelessWidget {
  const EarningDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'Earning Dashboard',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/homepage'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ),
                      child: const Text(
                        'Home',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.notifications, color: Colors.yellow, size: 30),
                      onPressed: () => Navigator.pushNamed(context, '/farmer-notifications-page'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Monthly', style: TextStyle(fontSize: 16, color: Colors.grey)),
                Text('Yearly', style: TextStyle(fontSize: 16, color: Colors.blue)), // Simplified toggle
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Order History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildCard('Orders', '14', Colors.white, Colors.black),
                _buildCard('Ongoing', '11', Colors.white, Colors.black),
                _buildCard('Cancel', '3', Colors.red[100]!, Colors.red),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Item posted',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildCard('Items posted', '35', Colors.white, Colors.black),
                _buildCard('Popular', '24', Colors.white, Colors.black),
                _buildCard('Rejected', '5', Colors.red[100]!, Colors.red),
              ],
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/item-information-page'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Sell item', style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String label, String value, Color bgColor, Color textColor) {
    return Expanded(
      child: Card(
        color: bgColor,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
              const SizedBox(height: 5),
              Text(label, style: TextStyle(fontSize: 12, color: textColor == Colors.red ? Colors.red : Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}