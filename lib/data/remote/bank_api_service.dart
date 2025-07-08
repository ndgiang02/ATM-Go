import 'package:atmgo/core/network/api_client.dart';
import 'package:atmgo/data/models/bank/bank.dart';

class BankApiService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Bank>> getBank() async {
    final response = await _apiClient.get('bank/get-all-bank');
    final List data = response.data;

    return data.map((json) => Bank.fromJson(json)).toList();
  }
}
