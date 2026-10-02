import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MovaRiderApp());
}

class MovaRiderApp extends StatelessWidget {
  const MovaRiderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOVA Rider',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0F172A),
          secondary: Color(0xFFD4AF37),
        ),
        fontFamily: 'Inter',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF050505),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFFFFF),
          secondary: Color(0xFFD4AF37),
        ),
        fontFamily: 'Inter',
      ),
      themeMode: ThemeMode.system,
      home: const RiderHomeMock(),
    );
  }
}

class RiderHomeMock extends StatefulWidget {
  const RiderHomeMock({super.key});

  @override
  State<RiderHomeMock> createState() => _RiderHomeMockState();
}

class _RiderHomeMockState extends State<RiderHomeMock> {
  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1A1A1A) : Colors.white;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: SvgPicture.asset(
          isDark ? 'assets/logo-dark.svg' : 'assets/logo-light.svg',
          height: 28,
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: isOnline,
            activeColor: Theme.of(context).colorScheme.secondary,
            onChanged: (val) {
              setState(() {
                isOnline = val;
              });
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Status Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: isOnline ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
              child: Center(
                child: Text(
                  isOnline ? 'You are ONLINE and receiving requests' : 'You are OFFLINE',
                  style: TextStyle(
                    color: isOnline ? Colors.green[700] : Colors.red[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Today\'s Earnings',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '₦ 12,450',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 32),
                    
                    if (isOnline) ...[
                      const Text(
                        'New Delivery Request',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      
                      // Mock Request Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Pickup in 2.5 km', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('₦ 1,200', style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                              ],
                            ),
                            const Divider(height: 32),
                            Row(
                              children: [
                                const Icon(Icons.inventory_2_outlined, color: Colors.grey),
                                const SizedBox(width: 12),
                                const Expanded(child: Text('Electronics (Small Package)')),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    child: const Text('Decline'),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).colorScheme.secondary,
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    child: const Text('Accept', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Icon(Icons.power_settings_new, size: 80, color: Colors.grey.withOpacity(0.3)),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
