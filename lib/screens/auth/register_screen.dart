import 'package:flutter/material.dart';

class RiderRegisterScreen extends StatefulWidget {
  const RiderRegisterScreen({super.key});
  @override
  State<RiderRegisterScreen> createState() => _RiderRegisterScreenState();
}

class _RiderRegisterScreenState extends State<RiderRegisterScreen> {
  bool _loading = false;
  bool _agreed = false;

  void _register() async {
    if (!_agreed) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) Navigator.pushReplacementNamed(context, '/home');
  }

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
          onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
        ),
        title: const Text('Create Rider Account',
          style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text('Your Information', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Join MOVA and start earning', style: TextStyle(color: Colors.grey)),
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
              const SizedBox(height: 24),
              Row(
                children: [
                  Checkbox(
                    value: _agreed,
                    activeColor: charcoal,
                    onChanged: (v) => setState(() => _agreed = v ?? false),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  const Expanded(
                    child: Text.rich(TextSpan(children: [
                      TextSpan(text: 'I agree to the ', style: TextStyle(color: Colors.grey)),
                      TextSpan(text: 'Terms of Service', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                      TextSpan(text: ' and ', style: TextStyle(color: Colors.grey)),
                      TextSpan(text: 'Privacy Policy', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                    ])),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_loading || !_agreed) ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: charcoal, foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: _loading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                    child: Text('Sign in', style: TextStyle(color: charcoal, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
}
