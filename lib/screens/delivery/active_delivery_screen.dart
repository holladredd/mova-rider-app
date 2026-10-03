import 'package:flutter/material.dart';
import '../../data/mock_data.dart';

class ActiveDeliveryScreen extends StatefulWidget {
  const ActiveDeliveryScreen({super.key});

  @override
  State<ActiveDeliveryScreen> createState() => _ActiveDeliveryScreenState();
}

class _ActiveDeliveryScreenState extends State<ActiveDeliveryScreen> {
  final _delivery = MockData.allDeliveries.firstWhere((d) => d['status'] == 'IN_TRANSIT');
  bool _arrivedAtPickup = false;
  bool _pickedUp = false;

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFD4AF37);
    final charcoal = const Color(0xFF0F172A);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Delivery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Colors.green),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Map Placeholder
          Expanded(
            child: Container(
              color: isDark ? const Color(0xFF1E293B) : Colors.grey.shade200,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.navigation, size: 60, color: gold.withValues(alpha: 0.8)),
                    const SizedBox(height: 12),
                    Text(
                      _pickedUp ? 'Navigating to Dropoff...' : 'Navigating to Pickup...',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Sheet / Controls
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, -5)),
              ],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order ${_delivery['trackingId']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 4),
                        Text('₦${_delivery['estimatedPrice']}', style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                      child: const Text('~15 mins', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const Divider(height: 32),
                
                // Destination details
                Row(
                  children: [
                    Icon(_pickedUp ? Icons.location_on : Icons.my_location, color: _pickedUp ? Colors.red : Colors.green),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_pickedUp ? 'Dropoff Address' : 'Pickup Address', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          Text(
                            _pickedUp ? _delivery['dropoffAddress'] : _delivery['pickupAddress'],
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Recipient / Sender info
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: charcoal.withValues(alpha: 0.1),
                      child: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_pickedUp ? 'Recipient' : 'Sender', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          Text(_pickedUp ? _delivery['recipient']['name'] : 'John Doe', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Package Contents (Now Visible)
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.green.withValues(alpha: 0.1),
                      child: const Icon(Icons.verified_user_outlined, color: Colors.green),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Declared Contents', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          Text(_delivery['package']['description'] ?? 'Not specified', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_arrivedAtPickup) {
                        setState(() => _arrivedAtPickup = true);
                      } else if (!_pickedUp) {
                        setState(() => _pickedUp = true);
                      } else {
                        // Complete Delivery
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: charcoal,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                      !_arrivedAtPickup ? 'Arrived at Pickup' : !_pickedUp ? 'Confirm Pickup' : 'Mark as Delivered',
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
