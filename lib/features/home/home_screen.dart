import 'package:atmgo/core/common/widget/widget_loading.dart';
import 'package:atmgo/core/constant/constants.dart';
import 'package:atmgo/core/utils/responsive.dart';
import 'package:atmgo/features/home/view_model/home_viewmodel.dart';
import 'package:atmgo/features/home/widget/location_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<HomeViewModel>(
            context,
            listen: false,
          ).getLocationNearest(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Giang",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Finding ways',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(
                              iconAtm,
                              height: Responsive.height(12, context),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Find your bank',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ), //
                            decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(
                              iconAtm,
                              height: Responsive.height(12, context),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Find ATMs',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Near You',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child:
                    viewModel.isLoading
                        ? const Center(child: LoadingWidget())
                        : viewModel.errorMessage != null
                        ? Center(
                          child: Text(
                            viewModel.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                        : viewModel.locations.isEmpty
                        ? const Center(child: Text('No banks found nearby'))
                        : ListView.builder(
                          itemCount: viewModel.locations.length,
                          itemBuilder: (context, index) {
                            final location = viewModel.locations[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: LocationCard(
                                title: location.title ?? 'N/A',
                                address: location.address ?? 'N/A',
                                status: 'Open 24 Hours',
                                distance:
                                    '${location.distance?.toStringAsFixed(2) ?? 'N/A'} Km',
                                logoUrl: location.logo,
                                onCall: () async {
                                  final phone = location.phone?.replaceAll(
                                    ' ',
                                    '',
                                  );
                                  final Uri launchUri = Uri(
                                    scheme: 'tel',
                                    path: phone,
                                  );
                                  if (await canLaunchUrl(launchUri)) {
                                    await launchUrl(launchUri);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Cannot make a phone call',
                                        ),
                                      ),
                                    );
                                  }
                                },
                                onDirection: () {
                                  // TODO: Implement direction functionality
                                },
                                onShare: () {
                                  // TODO: Implement share functionality
                                },
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
  }
}
