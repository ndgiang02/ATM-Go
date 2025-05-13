import 'package:atmgo/data/models/bank_model.dart';
import 'package:flutter/material.dart';

class BankCard extends StatelessWidget {
  const BankCard({super.key, required this.bank});
  final Bank bank;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Image.asset(bank.logoUrl, width: 40, height: 40),
        title: Text(bank.name),
        subtitle:
            bank.distance != null
                ? Text('${bank.distance!.toStringAsFixed(1)} km gần bạn')
                : null,
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
