import 'package:flutter/material.dart';
import '../widgets/HomeAppBar.dart';

class FarmerNotificationsPage extends StatelessWidget {
  const FarmerNotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample notification data
    final List<Map<String, String>> notifications = [
      {
        'title': 'Newest',
        'message': 'Da Da has ordered Lettuce',
        'status': 'In progress',
        'action': 'click here to confirm',
        'date': '2025-05-24'
      },
      {
        'title': 'Completed',
        'message': 'Order #1234 has been delivered',
        'status': 'Paid',
        'action': '',
        'date': '2025-05-23'
      },
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: HomeAppBar(),
      ),
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
                      'Notifications',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/homepage');
                  },
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
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        notification['title']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          Text(
                            notification['message']!,
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Status: ${notification['status']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: notification['status'] == 'In progress'
                                  ? Colors.grey
                                  : Colors.green,
                            ),
                          ),
                          if (notification['action']!.isNotEmpty)
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/farmer-order-confirmation-page',
                                  arguments: notification['message'],
                                );
                              },
                              child: Text(
                                notification['action']!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          Text(
                            'Date: ${notification['date']}',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}