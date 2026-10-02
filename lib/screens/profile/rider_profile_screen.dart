import 'package:flutter/material.dart';

class RiderProfileScreen extends StatelessWidget {
  const RiderProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final charcoal = const Color(0xFF0F172A);
    final gold = const Color(0xFFD4AF37);
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 16),
          Center(child: Column(children: [
            Stack(children: [
              CircleAvatar(radius: 52, backgroundColor: charcoal,
                child: const Text('E', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white))),
              Positioned(bottom: 0, right: 0, child: Container(
                width: 32, height: 32,
                decoration: BoxDecoration(color: gold, shape: BoxShape.circle),
                child: const Icon(Icons.edit, color: Colors.black, size: 16),
              )),
            ]),
            const SizedBox(height: 12),
            const Text('Emeka Adeyemi', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('emeka.adeyemi@mova.ng', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.star, color: Color(0xFFD4AF37), size: 18),
              const SizedBox(width: 4),
              const Text('4.9 rating  ·  ', style: TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF22C55E).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20)),
                child: const Text('Verified Rider', style: TextStyle(color: Color(0xFF22C55E), fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ]),
          ])),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(children: [
              _stat('142', 'Deliveries'),
              _stat('₦284,500', 'Total Earned'),
              _stat('4.9', 'Rating'),
            ]),
          ),
          const SizedBox(height: 32),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: charcoal.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.two_wheeler, color: Color(0xFF0F172A)),
            ),
            title: const Text('Vehicle Info', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Kawasaki Bike  ·  LGA-4821-BD', style: TextStyle(color: Colors.grey, fontSize: 12)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: charcoal.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.description_outlined, color: Color(0xFF0F172A)),
            ),
            title: const Text('Documents', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('All documents verified', style: TextStyle(color: Color(0xFF22C55E), fontSize: 12)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: charcoal.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.notifications_outlined, color: Color(0xFF0F172A)),
            ),
            title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            leading: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.logout, color: Colors.red),
            ),
            title: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
            onTap: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }

  Widget _stat(String value, String label) => Expanded(child: Column(children: [
    Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    const SizedBox(height: 4),
    Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
  ]));
}
