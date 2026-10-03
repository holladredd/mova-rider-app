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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order ${_delivery['trackingId']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 4),
                          Text('₦${_delivery['estimatedPrice']}', style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
                        ],
                      ),
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
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Sender/Recipient info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: charcoal.withValues(alpha: 0.1),
                      child: const Icon(Icons.person, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_pickedUp ? 'Recipient' : 'Sender', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          Text(_pickedUp ? (_delivery['recipient'] != null ? _delivery['recipient']['name'] : 'Receiver') : 'John Doe',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),

                if (_pickedUp) ...[
                  const SizedBox(height: 16),
                  // Package Contents revealed after pickup
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.green.withValues(alpha: 0.1),
                        child: const Icon(Icons.verified_user, color: Colors.green, size: 18),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Declared Contents', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            Text(_delivery['package'] != null && _delivery['package']['description'] != null
                                ? _delivery['package']['description']
                                : '2 Laptops, documents',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 24),

                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_arrivedAtPickup) {
                        setState(() => _arrivedAtPickup = true);
                      } else if (!_pickedUp) {
                        _showCodeModal(
                          context,
                          'Pickup Code',
                          'Ask the sender for the 4-digit pickup code to verify you are collecting the right package.',
                          '1234',
                          () => setState(() => _pickedUp = true),
                        );
                      } else {
                        _showCodeModal(
                          context,
                          'Delivery Code',
                          'Ask the receiver to provide the 4-digit delivery code to complete this delivery.',
                          '9876',
                          () => Navigator.pushNamedAndRemoveUntil(context, '/review', (_) => false),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: charcoal,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(
                      !_arrivedAtPickup
                          ? 'Arrived at Pickup'
                          : !_pickedUp
                              ? 'Verify & Confirm Pickup'
                              : 'Verify & Complete Delivery',
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

  void _showCodeModal(BuildContext context, String title, String subtitle, String expectedCode, VoidCallback onSuccess) {
    final codeCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 20),
              const Icon(Icons.lock_outline, size: 48, color: Color(0xFF0F172A)),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const SizedBox(height: 8),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              TextField(
                controller: codeCtrl,
                keyboardType: TextInputType.number,
                maxLength: 4,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 36, letterSpacing: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                decoration: InputDecoration(
                  counterText: '',
                  hintText: '----',
                  hintStyle: const TextStyle(color: Colors.grey, letterSpacing: 12, fontSize: 36),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF0F172A), width: 2)),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (codeCtrl.text == expectedCode) {
                      Navigator.pop(ctx);
                      onSuccess();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('❌ Invalid Code! Try again.'), backgroundColor: Colors.red),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Verify Code', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
