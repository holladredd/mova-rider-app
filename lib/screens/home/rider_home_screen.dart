import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/mock_data.dart';

class RiderHomeScreen extends StatefulWidget {
  const RiderHomeScreen({super.key});
  @override
  State<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  int _currentIndex = 0;
  bool isOnline = true;
  bool hasRequest = true;
  
  final _rider = mockRider;
  final _activeDelivery = mockDeliveries.firstWhere((d) => d['status'] == 'IN_TRANSIT');
  final _incomingRequest = mockDeliveries.firstWhere((d) => d['status'] == 'SEARCHING_RIDER');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _dashboardTab(isDark),
          const _HistoryTabPlaceholder(),
          const _EarningsTabPlaceholder(),
          const _ProfileTabPlaceholder(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        selectedItemColor: const Color(0xFFD4AF37),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), activeIcon: Icon(Icons.account_balance_wallet), label: 'Earnings'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _dashboardTab(bool isDark) {
    final gold = const Color(0xFFD4AF37);
    final charcoal = const Color(0xFF0F172A);
    final cardBg = isDark ? const Color(0xFF1A1A1A) : Colors.white;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            backgroundColor: charcoal,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft, end: Alignment.bottomRight,
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        SvgPicture.asset('assets/logo-dark.svg', height: 32),
                        Row(children: [
                          const Text('Online', style: TextStyle(color: Colors.white70, fontSize: 13)),
                          const SizedBox(width: 8),
                          Switch(
                            value: isOnline,
                            activeColor: gold,
                            onChanged: (v) => setState(() => isOnline = v),
                          ),
                        ]),
                      ]),
                      const SizedBox(height: 8),
                      Row(children: [
                        Container(width: 8, height: 8, decoration: BoxDecoration(
                          color: isOnline ? const Color(0xFF22C55E) : Colors.red,
                          shape: BoxShape.circle,
                        )),
                        const SizedBox(width: 6),
                        Text(
                          isOnline ? 'You are online — receiving requests' : 'You are offline',
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ]),
                    ]),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Today stats
                  Row(children: [
                    _statCard('₦${_rider['balance']}', 'Today\'s Earnings', Icons.trending_up, const Color(0xFF22C55E), cardBg),
                    const SizedBox(width: 12),
                    _statCard('7', 'Deliveries', Icons.local_shipping_outlined, gold, cardBg),
                  ]),
                  const SizedBox(height: 20),

                  if (isOnline && hasRequest) ...[
                    const Text('Incoming Request', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _requestCard(charcoal, gold, cardBg),
                    const SizedBox(height: 24),
                  ],

                  // Route info (active delivery)
                  const Text('Current Delivery', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Column(children: [
                      // Mock map
                      Container(
                        height: 140,
                        decoration: BoxDecoration(color: charcoal, borderRadius: BorderRadius.circular(12)),
                        child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.map, color: gold.withValues(alpha: 0.5), size: 36),
                          const SizedBox(height: 6),
                          const Text('Navigation Map', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ])),
                      ),
                      const SizedBox(height: 16),
                      _routeRow(Icons.my_location, _activeDelivery['pickupAddress'], Colors.grey),
                      const SizedBox(height: 8),
                      _routeRow(Icons.location_on, _activeDelivery['dropoffAddress'], Colors.red),
                      const Divider(height: 24),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(_activeDelivery['trackingId'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('${_activeDelivery['package']['size']} Package', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                        ]),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF22C55E), foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Mark Delivered', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        ),
                      ]),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label, IconData icon, Color color, Color bg) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))]),
        child: Row(children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20)),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ]),
        ]),
      ),
    );
  }

  Widget _requestCard(Color charcoal, Color gold, Color bg) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bg, borderRadius: BorderRadius.circular(20),
        border: Border.all(color: gold, width: 2),
        boxShadow: [BoxShadow(color: gold.withValues(alpha: 0.15), blurRadius: 20, spreadRadius: 4)],
      ),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Pickup in 2.5 km', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('New request • 30s remaining', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ]),
          Text('₦${_incomingRequest['estimatedPrice']}', style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 22)),
        ]),
        const Divider(height: 24),
        _routeRow(Icons.my_location, _incomingRequest['pickupAddress'], Colors.grey),
        const SizedBox(height: 8),
        _routeRow(Icons.location_on, _incomingRequest['dropoffAddress'], Colors.red),
        const SizedBox(height: 4),
        Row(children: [
          const Icon(Icons.inventory_2_outlined, color: Colors.grey, size: 16),
          const SizedBox(width: 6),
          Text('${_incomingRequest['package']['size']} package  ·  ${_incomingRequest['distanceKm']} km distance', style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: OutlinedButton(
            onPressed: () => setState(() => hasRequest = false),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Decline', style: TextStyle(fontWeight: FontWeight.bold)),
          )),
          const SizedBox(width: 12),
          Expanded(child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/incoming-request');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: gold, foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Accept', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          )),
        ]),
      ]),
    );
  }

  Widget _routeRow(IconData icon, String text, Color iconColor) {
    return Row(children: [
      Icon(icon, size: 18, color: iconColor),
      const SizedBox(width: 8),
      Expanded(child: Text(text, style: const TextStyle(fontSize: 14), overflow: TextOverflow.ellipsis)),
    ]);
  }
}

class _HistoryTabPlaceholder extends StatelessWidget {
  const _HistoryTabPlaceholder();
  @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Delivery History')));
}

class _EarningsTabPlaceholder extends StatelessWidget {
  const _EarningsTabPlaceholder();
  @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Earnings')));
}

class _ProfileTabPlaceholder extends StatelessWidget {
  const _ProfileTabPlaceholder();
  @override Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Profile')));
}
