import 'package:atmgo/data/models/bank_model.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  final List<Bank> _banks = [
    Bank(id: 'vcb', name: 'Vietcombank', logoUrl: 'assets/logos/vcb.png'),
    Bank(id: 'bidv', name: 'BIDV', logoUrl: 'assets/logos/bidv.png'),
    Bank(id: 'vtb', name: 'VietinBank', logoUrl: 'assets/logos/vtb.png'),
  ];

  List<Bank> get allBanks => _banks;

  List<Bank> get nearbyBanks =>
      _banks.where((bank) => bank.distance != null).toList();

  void loadNearbyBanks() {
    _banks[0] = Bank(
      id: _banks[0].id,
      name: _banks[0].name,
      logoUrl: _banks[0].logoUrl,
      distance: 0.5,
    );
    notifyListeners();
  }
}
