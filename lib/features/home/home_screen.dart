import 'dart:ui';

import 'package:atmgo/core/common/widget/widget_loading.dart';
import 'package:atmgo/core/response/status.dart';
import 'package:atmgo/features/home/view_model/home_viewmodel.dart';
import 'package:atmgo/features/home/widget/location_item.dart';
import 'package:atmgo/features/home/widget/over_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double _heightTotalOverview = 48.0;
  static const double _heightOverviewCard = 140.0;
  static const double _stickyHeaderHeight = kToolbarHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<HomeViewModel>(context, listen: false);
      viewModel.getLocationNearest();
      viewModel.getOverViews();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final viewModel = context.read<HomeViewModel>();
    if (viewModel.overResponse.status == Status.LOADING) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) viewModel.getOverViews();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade500, Colors.blue.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: RefreshIndicator(
              onRefresh: () => _refreshData(context),
              color: Colors.white,
              backgroundColor: Colors.blueGrey.shade800,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                    pinned: false,
                    delegate: _FadeHeaderDelegate(
                      minHeight: 0,
                      maxHeight: _heightTotalOverview,
                      builder: (context, shrinkOffset, overlapsContent) {
                        final double available = _heightTotalOverview - 0;
                        final double progress =
                            available <= 0
                                ? 1.0
                                : (1.0 - (shrinkOffset / available)).clamp(
                                  0.0,
                                  1.0,
                                );
                        final double curved = Curves.easeOut.transform(
                          progress,
                        );
                        final double opacity = curved;
                        final double translateY = 6 * (1 - curved);

                        if (progress < 0.02) {
                          return const SizedBox.shrink();
                        }

                        return ClipRect(
                          child: Transform.translate(
                            offset: Offset(0, translateY),
                            child: Opacity(
                              opacity: opacity,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Tổng quan',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SliverPersistentHeader(
                    pinned: false,
                    delegate: _FadeHeaderDelegate(
                      minHeight: 0,
                      maxHeight: _heightOverviewCard,
                      watch: viewModel.overResponse,
                      builder: (context, shrinkOffset, overlapsContent) {
                        final double available = _heightOverviewCard - 0;
                        final double progress =
                            available <= 0
                                ? 1.0
                                : (1.0 - (shrinkOffset / available)).clamp(
                                  0.0,
                                  1.0,
                                );
                        final double curved = Curves.easeOut.transform(
                          progress,
                        );

                        final double opacity = curved;
                        final double translateY = 4 * (1 - curved);

                        if (progress < 0.02) {
                          return const SizedBox.shrink();
                        }

                        return ClipRect(
                          child: Transform.translate(
                            offset: Offset(0, translateY),
                            child: Opacity(
                              opacity: opacity,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxHeight: _heightOverviewCard,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 2,
                                ),
                                child: Builder(
                                  builder: (ctx) {
                                    final status =
                                        viewModel.overResponse.status;
                                    if (status == Status.LOADING) {
                                      return const SizedBox(
                                        height: 120,
                                        child: Center(child: LoadingWidget()),
                                      );
                                    } else if (status == Status.ERROR) {
                                      return Container(
                                        constraints: const BoxConstraints(
                                          minHeight: 60,
                                          maxHeight: 120,
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Lỗi thống kê: ${viewModel.overResponse.message ?? ''}',
                                              style: const TextStyle(
                                                color: Colors.redAccent,
                                              ),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      final data = viewModel.overResponse.data;
                                      if (data == null) {
                                        return const SizedBox.shrink();
                                      }
                                      return Container(
                                        constraints: const BoxConstraints(
                                          maxHeight: 150,
                                        ),
                                        child: SingleChildScrollView(
                                          // Thêm scroll nếu cần
                                          child: OverviewWidget(
                                            totalBranches: data.branch,
                                            totalATMs: data.atm,
                                            totalCDMs: data.cdm,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _StickyHeaderDelegate(
                      minHeight: _stickyHeaderHeight,
                      maxHeight: _stickyHeaderHeight,
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Gần bạn',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 4,
                    ),
                    sliver: _buildLocationsSliver(viewModel),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationsSliver(HomeViewModel viewModel) {
    final status = viewModel.locationsResponse.status;

    if (status == Status.LOADING) {
      return const SliverToBoxAdapter(child: LoadingWidget());
    }

    if (status == Status.ERROR) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              viewModel.locationsResponse.message ?? 'Lỗi tải dữ liệu',
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ),
      );
    }

    final data = viewModel.locationsResponse.data;
    if (data == null || data.isEmpty) {
      return const SliverToBoxAdapter(
        child: SizedBox(
          height: 150,
          child: Center(
            child: Text(
              'Không có dữ liệu',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final location = data[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: LocationCard(
            title: location.title ?? 'N/A',
            address: location.address ?? 'N/A',
            status: 'Open 24 Hours',
            distance: '${location.distance?.toStringAsFixed(2) ?? 'N/A'} Km',
            logoUrl: location.logo,
            onCall: () => _handlePhoneCall(context, location.phone),
            onDirection: () {},
            onShare: () {},
          ),
        );
      }, childCount: data.length),
    );
  }

  Future<void> _refreshData(BuildContext context) async {
    HapticFeedback.lightImpact();

    final viewModel = Provider.of<HomeViewModel>(context, listen: false);

    try {
      await Future.wait([
        viewModel.getOverViews(),
        viewModel.getLocationNearest(),
      ]).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw 'Timeout: Vui lòng thử lại';
        },
      );

      HapticFeedback.selectionClick();
    } catch (error) {
      HapticFeedback.mediumImpact();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Lỗi tải dữ liệu: $error',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _handlePhoneCall(BuildContext context, String? phone) async {
    if (phone == null || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Số điện thoại không khả dụng')),
      );
      return;
    }
    final cleanPhone = phone.replaceAll(' ', '');
    final Uri launchUri = Uri(scheme: 'tel', path: cleanPhone);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Không thể gọi điện')));
    }
  }
}

class _FadeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget Function(BuildContext, double, bool) builder;
  final Object? watch;

  _FadeHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.builder,
    this.watch,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return builder(context, shrinkOffset, overlapsContent);
  }

  @override
  bool shouldRebuild(covariant _FadeHeaderDelegate oldDelegate) {
    return oldDelegate.maxHeight != maxHeight ||
        oldDelegate.minHeight != minHeight ||
        oldDelegate.watch != watch; // nếu token khác -> rebuild
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
