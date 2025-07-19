import 'package:atmgo/core/common/widget/widget_loading.dart';
import 'package:atmgo/core/response/status.dart';
import 'package:atmgo/di/locator.dart';
import 'package:atmgo/features/listbank/viewmodel/listbank_viewmodel.dart';
import 'package:atmgo/features/listbank/widget/bank_item.dart';
import 'package:atmgo/features/listbank/widget/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ListViewModel>(context, listen: false).getAllBanks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => locator<ListViewModel>()..getAllBanks(),
      child: Consumer<ListViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "List",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 20),
                    SearchTextField(),
                    SizedBox(height: 16),

                    Expanded(
                      child:
                          viewModel.banksResponse.status == Status.LOADING
                              ? const Center(child: LoadingWidget())
                              : viewModel.banksResponse.status == Status.ERROR
                              ? Center(
                                child: Text(
                                  viewModel.banksResponse.message!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              )
                              : ListView.builder(
                                itemCount: viewModel.banksResponse.data!.length,
                                itemBuilder: (context, index) {
                                  final bank =
                                      viewModel.banksResponse.data![index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: BankItem(
                                      logo: bank.logo_url,
                                      name: bank.name,
                                    ),
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
