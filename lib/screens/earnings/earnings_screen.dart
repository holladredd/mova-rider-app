import 'package:flutter/material.dart';
import '../../data/mock_data.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFD4AF37);
    final charcoal = const Color(0xFF0F172A);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF050505) : const Color(0xFFF8F9FA);
    final cardBg = isDark ? const Color(0xFF1A1A1A) : Colors.white;

    final transactions = [
      {'id': 'MOVA-8291', 'route': 'VI → Lekki', 'amount': 2500, 'date': 'Today, 2:30 PM', 'status': 'PAID'},
      {'id': 'MOVA-7834', 'route': 'Yaba → Surulere', 'amount': 1800, 'date': 'Today, 10:15 AM', 'status': 'PAID'},
      {'id': 'MOVA-7102', 'route': 'Ikeja → Maryland', 'amount': 3200, 'date': 'Yesterday, 4:45 PM', 'status': 'PAID'},
      {'id': 'MOVA-6891', 'route': 'Oshodi → Isolo', 'amount': 1500, 'date': 'Yesterday, 1:00 PM', 'status': 'PENDING'},
      {'id': 'MOVA-6210', 'route': 'Ajah → Lekki', 'amount': 4100, 'date': '2 days ago', 'status': 'PAID'},
    ];

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: charcoal,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
                ),
                child: Column(
                  children: [
                    const Text('My Earnings', style: TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 1)),
                    const SizedBox(height: 8),
                    const Text('₦284,500', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                    const Text('Total Earnings', style: TextStyle(color: Colors.white54, fontSize: 13)),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _earningChip('₦8,300', 'Today', gold),
                        Container(width: 1, height: 40, color: Colors.white24),
                        _earningChip('₦42,100', 'This Week', gold),
                        Container(width: 1, height: 40, color: Colors.white24),
                        _earningChip('₦284,500', 'All Time', gold),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Quick Actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _showWithdrawModal(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(color: charcoal, borderRadius: BorderRadius.circular(16)),
                          child: const Column(
                            children: [
                              Icon(Icons.account_balance_wallet, color: Color(0xFFD4AF37), size: 28),
                              SizedBox(height: 8),
                              Text('Withdraw', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.lock_outline, color: gold, size: 28),
                            const SizedBox(height: 8),
                            const Text('Locked', style: TextStyle(fontWeight: FontWeight.bold)),
                            const Text('₦2,500', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Transaction History
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Recent Deliveries', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text('See all', style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (context, i) {
                  final tx = transactions[i];
                  final isPaid = tx['status'] == 'PAID';
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: cardBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: isDark ? Colors.white10 : Colors.transparent),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(
                            color: (isPaid ? Colors.green : Colors.orange).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.two_wheeler, color: isPaid ? Colors.green : Colors.orange, size: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tx['id'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              Text(tx['route'] as String, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              Text(tx['date'] as String, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('₦${tx['amount']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: (isPaid ? Colors.green : Colors.orange).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(isPaid ? 'Paid' : 'Pending', style: TextStyle(color: isPaid ? Colors.green : Colors.orange, fontSize: 11, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _earningChip(String amount, String label, Color gold) {
    return Column(
      children: [
        Text(amount, style: TextStyle(color: gold, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }

  void _showWithdrawModal(BuildContext context) {
    final amtCtrl = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Withdraw Earnings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
              const SizedBox(height: 8),
              const Text('Funds will be sent to your linked bank account.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              TextField(
                controller: amtCtrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Color(0xFF0F172A), fontSize: 18, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  prefixText: '₦ ',
                  hintText: '0.00',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                child: const Row(
                  children: [
                    Icon(Icons.account_balance, color: Color(0xFF0F172A)),
                    SizedBox(width: 12),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Zenith Bank', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('0123456789', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Withdrawal initiated!'), backgroundColor: Colors.green),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Withdraw Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
