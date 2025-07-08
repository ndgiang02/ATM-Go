import 'package:atmgo/data/models/bank/bank.dart';
import 'package:atmgo/data/remote/bank_api_service.dart';

class BankRepositoryImpl {
  final BankApiService _apiService = BankApiService();

  Future<List<Bank>> getAllBanks() async {
    return _apiService.getBank();
  }
}
