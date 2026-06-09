import 'package:flutter/material.dart';
import '../models/event_organizer.dart';
import '../models/package_model.dart';
import '../models/service_model.dart';
import '../services/api_services.dart';
import 'main_screen.dart';

class PaymentScreen extends StatefulWidget {
  final EventOrganizerModel eo;
  final PackageModel package;
  final List<ServiceModel> addOns;

  const PaymentScreen({
    Key? key,
    required this.eo,
    required this.package,
    this.addOns = const [],
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final ApiServices _apiServices = ApiServices();
  String _selectedMethod = 'bank_transfer';
  bool _isLoading = false;

  String _formatPrice(double price) {
    String priceStr = price.toInt().toString();
    priceStr = priceStr.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
    return 'Rp $priceStr';
  }

  Future<void> _processPayment() async {
    setState(() => _isLoading = true);

    List<int> selectedServiceIds = widget.addOns.map((s) => s.id).toList();

    final transactionId = await _apiServices.createTransaction(
      eoId: widget.eo.id,
      packageId: widget.package.id,
      selectedServices: selectedServiceIds,
    );

    if (transactionId != null) {
      final paymentId = await _apiServices.createPayment(transactionId, _selectedMethod);

      if (paymentId != null) {
        final isSuccess = await _apiServices.confirmPaymentSuccess(paymentId);
        
        setState(() => _isLoading = false);

        if (isSuccess) {
          _showSuccessDialog();
        } else {
          _showError('Gagal mengkonfirmasi pembayaran.');
        }
      } else {
        setState(() => _isLoading = false);
        _showError('Gagal membuat data pembayaran.');
      }
    } else {
      setState(() => _isLoading = false);
      _showError('Gagal membuat transaksi.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.white, size: 50),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your payment was successful',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Thank you for your payment',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0D2546)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text('Back to Home', style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double packagePrice = widget.package.price;
    double addOnsPrice = widget.addOns.fold(0, (sum, item) => sum + item.price);
    double totalPrice = packagePrice + addOnsPrice;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // header
            Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF0D2546),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text('PAYMENT', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Order Summary', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)]),
                    child: Row(
                      children: [
                        Container(
                          width: 60, height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: widget.eo.image != null ? NetworkImage(widget.eo.image!) : const AssetImage('assets/images/ballroom.jpg') as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.package.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.person, size: 14, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(widget.eo.name, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text('Payment Methods:', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildPaymentMethodOption('Transfer Bank', Icons.credit_card, 'bank_transfer'),
                  const SizedBox(height: 10),
                  _buildPaymentMethodOption('E-Wallet', Icons.account_balance_wallet, 'e_wallet'),

                  const SizedBox(height: 24),

                  const Text('Payment Summary', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)]),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.package.name, style: const TextStyle(fontSize: 12)),
                            Text(_formatPrice(packagePrice), style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                        
                        if (widget.addOns.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Add on:', style: TextStyle(fontSize: 12)),
                              Text(_formatPrice(addOnsPrice), style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                        
                        const Divider(height: 24, thickness: 1),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Payment', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(_formatPrice(totalPrice), style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D2546),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                      onPressed: _isLoading ? null : _processPayment,
                      child: _isLoading 
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white))
                          : const Text('PAY NOW', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodOption(String title, IconData icon, String value) {
    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _selectedMethod == value ? Colors.blue : Colors.transparent, width: 1.5),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            Icon(
              _selectedMethod == value ? Icons.radio_button_checked : Icons.radio_button_off,
              color: _selectedMethod == value ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 12),
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 12),
            Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}