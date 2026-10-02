import 'package:flutter/material.dart';

class RiderRegisterScreen extends StatefulWidget {
  const RiderRegisterScreen({super.key});
  @override
  State<RiderRegisterScreen> createState() => _RiderRegisterScreenState();
}

class _RiderRegisterScreenState extends State<RiderRegisterScreen> {
  int _step = 0;
  String _vehicleType = 'Bike';
  bool _loading = false;

  final List<String> _vehicles = ['Bike', 'Car', 'Truck', 'Tricycle'];

  @override
  Widget build(BuildContext context) {
    final charcoal = const Color(0xFF0F172A);
    final gold = const Color(0xFFD4AF37);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () => _step > 0 ? setState(() => _step--) : Navigator.pushReplacementNamed(context, '/login'),
        ),
        title: Text(_step == 0 ? 'Personal Info' : _step == 1 ? 'Vehicle Info' : 'Upload Documents',
          style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // Step bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(children: List.generate(3, (i) => Expanded(child: Row(children: [
              Expanded(child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 4,
                decoration: BoxDecoration(
                  color: i <= _step ? charcoal : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(2),
                ),
              )),
              if (i < 2) const SizedBox(width: 4),
            ])))),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: _step == 0 ? _personalInfo() : _step == 1 ? _vehicleInfo(gold, charcoal) : _documents(charcoal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(width: double.infinity, child: ElevatedButton(
              onPressed: _loading ? null : () async {
                if (_step < 2) { setState(() => _step++); }
                else {
                  setState(() => _loading = true);
                  await Future.delayed(const Duration(seconds: 2));
                  if (mounted) Navigator.pushReplacementNamed(context, '/home');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: charcoal, foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: _loading
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Text(_step < 2 ? 'Continue' : 'Submit Application', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            )),
          ),
        ],
      ),
    );
  }

  Widget _personalInfo() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Your Information', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 32),
      _field('First Name', Icons.person_outline),
      const SizedBox(height: 16),
      _field('Last Name', Icons.person_outline),
      const SizedBox(height: 16),
      _field('Email address', Icons.email_outlined),
      const SizedBox(height: 16),
      _field('Phone number', Icons.phone_outlined),
      const SizedBox(height: 16),
      _field('Password', Icons.lock_outline, obscure: true),
    ]);
  }

  Widget _vehicleInfo(Color gold, Color charcoal) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Your Vehicle', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('Tell us about the vehicle you use for deliveries', style: TextStyle(color: Colors.grey)),
      const SizedBox(height: 32),
      const Text('Vehicle Type', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      const SizedBox(height: 12),
      Wrap(
        spacing: 12, runSpacing: 12,
        children: _vehicles.map((v) {
          final isSelected = _vehicleType == v;
          return GestureDetector(
            onTap: () => setState(() => _vehicleType = v),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? charcoal : const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isSelected ? charcoal : const Color(0xFFE2E8F0)),
              ),
              child: Text(v, style: TextStyle(
                color: isSelected ? Colors.white : null,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              )),
            ),
          );
        }).toList(),
      ),
      const SizedBox(height: 24),
      _field('Vehicle Plate Number', Icons.badge_outlined),
      const SizedBox(height: 16),
      _field('Vehicle Model (e.g. Honda CB)', Icons.two_wheeler),
    ]);
  }

  Widget _documents(Color charcoal) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Upload Documents', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('Required for verification. Documents are kept secure.', style: TextStyle(color: Colors.grey)),
      const SizedBox(height: 32),
      _uploadCard('Government-issued ID', 'NIN, Driver\'s License or International Passport'),
      const SizedBox(height: 16),
      _uploadCard('Vehicle License', 'Current vehicle registration document'),
      const SizedBox(height: 16),
      _uploadCard('Profile Photo', 'Clear front-facing photo of yourself'),
    ]);
  }

  Widget _field(String label, IconData icon, {bool obscure = false}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
      const SizedBox(height: 8),
      TextField(
        obscureText: obscure,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey, size: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF0F172A), width: 2)),
          filled: true, fillColor: const Color(0xFFF8F9FA),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    ]);
  }

  Widget _uploadCard(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE2E8F0), style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFF8F9FA),
      ),
      child: Row(children: [
        const Icon(Icons.upload_file, color: Color(0xFF0F172A), size: 32),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ])),
        TextButton(onPressed: () {}, child: const Text('Upload', style: TextStyle(color: Color(0xFF0F172A)))),
      ]),
    );
  }
}
