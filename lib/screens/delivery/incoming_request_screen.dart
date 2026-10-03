import 'package:flutter/material.dart';
import '../../data/mock_data.dart';

class IncomingRequestScreen extends StatelessWidget {
  const IncomingRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _incomingRequest = MockData.allDeliveries.firstWhere((d) => d['status'] == 'SEARCHING_RIDER');
    final gold = const Color(0xFFD4AF37);
    final charcoal = const Color(0xFF0F172A);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: charcoal,
          image: DecorationImage(
            image: const AssetImage('assets/map-pattern.png'), // Placeholder pattern
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(charcoal.withValues(alpha: 0.8), BlendMode.dstATop),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: gold.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: gold),
                ),
                child: const Text(
                  'NEW DELIVERY REQUEST',
                  style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
              ),
              const Spacer(),
              
              // Request Card
              Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: gold.withValues(alpha: 0.2), blurRadius: 40, spreadRadius: 5),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Submit Your Offer', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    const Text('Enter the amount you want to charge for this trip. The user will review your offer.', style: TextStyle(color: Colors.grey, fontSize: 13), textAlign: TextAlign.center),
                    const SizedBox(height: 24),
                    
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.payments, color: Colors.green),
                        prefixText: '₦ ',
                        hintText: 'e.g. 2500',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: charcoal, width: 2)),
                      ),
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    
                    const Divider(height: 40),
                    
                    _routeRow(Icons.my_location, _incomingRequest['pickupAddress'], 'Pickup (2km away)', Colors.grey),
                    const SizedBox(height: 16),
                    _routeRow(Icons.location_on, _incomingRequest['dropoffAddress'], 'Dropoff (${_incomingRequest['distanceKm']}km trip)', Colors.red),
                    
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            child: const Text('Reject', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                              Future.delayed(const Duration(milliseconds: 300), () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('✅ Your offer was submitted! Waiting for user to accept.'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 4),
                                  ),
                                );
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: charcoal,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            child: const Text('Submit Offer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _routeRow(IconData icon, String address, String subtitle, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
