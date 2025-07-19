import 'package:atmgo/core/response/api_response.dart';
import 'package:atmgo/data/models/bank/bank.dart';
import 'package:atmgo/data/repositories/bank_repositories_impl.dart';
import 'package:flutter/material.dart';

class ListViewModel extends ChangeNotifier {
  ListViewModel(this._bankRepository);
  final BankRepositoryImpl _bankRepository;

  ApiResponse<List<Bank>> banksResponse = ApiResponse.loading();

  void _setBanksResponse(ApiResponse<List<Bank>> response) {
    banksResponse = response;
    notifyListeners();
  }

  Future<void> getAllBanks() async {
    _setBanksResponse(ApiResponse.loading());

    try {
      final banks = await _bankRepository.getAllBanks();
      _setBanksResponse(ApiResponse.completed(banks));
    } catch (e) {
      _setBanksResponse(ApiResponse.error(e.toString()));
    }
  }
}
