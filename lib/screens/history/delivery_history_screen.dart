import 'package:flutter/material.dart';

class DeliveryHistoryScreen extends StatelessWidget {
  const DeliveryHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFD4AF37);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF050505) : const Color(0xFFF8F9FA);
    final cardBg = isDark ? const Color(0xFF1A1A1A) : Colors.white;

    final history = [
      {'id': 'MOVA-8291', 'from': '123 Victoria Island', 'to': 'Lekki Phase 1', 'price': 2500, 'date': 'Today, 2:30 PM', 'rating': 4.9, 'status': 'COMPLETED'},
      {'id': 'MOVA-7834', 'from': 'Yaba Bus Stop', 'to': '3 Surulere Close', 'price': 1800, 'date': 'Today, 10:15 AM', 'rating': 5.0, 'status': 'COMPLETED'},
      {'id': 'MOVA-7102', 'from': 'Ikeja Under Bridge', 'to': '7 Maryland Ave', 'price': 3200, 'date': 'Yesterday, 4:45 PM', 'rating': 4.7, 'status': 'COMPLETED'},
      {'id': 'MOVA-6891', 'from': 'Oshodi Terminal', 'to': '12 Isolo Rd', 'price': 1500, 'date': 'Yesterday, 1:00 PM', 'rating': null, 'status': 'CANCELLED'},
    ];

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(title: const Text('Delivery History')),
      body: history.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text('No delivery history yet', style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: history.length,
              itemBuilder: (context, i) {
                final d = history[i];
                final isDone = d['status'] == 'COMPLETED';
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: isDark ? Colors.white10 : Colors.transparent),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(d['id'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: (isDone ? Colors.green : Colors.red).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              isDone ? 'Completed' : 'Cancelled',
                              style: TextStyle(color: isDone ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(children: [
                        const Icon(Icons.my_location, size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        Expanded(child: Text(d['from'] as String, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis)),
                      ]),
                      const SizedBox(height: 4),
                      Row(children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.red),
                        const SizedBox(width: 6),
                        Expanded(child: Text(d['to'] as String, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis)),
                      ]),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(d['date'] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          if (d['rating'] != null) Row(children: [
                            Icon(Icons.star, color: gold, size: 14),
                            const SizedBox(width: 4),
                            Text('${d['rating']}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ]),
                          Text('₦${d['price']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
