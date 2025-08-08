import 'dart:ui';

import 'package:atmgo/core/common/widget/glass_widget.dart';
import 'package:atmgo/core/constant/constants.dart';
import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.title,
    required this.address,
    required this.status,
    required this.distance,
    this.logoUrl,
    this.onCall,
    this.onDirection,
    this.onShare,
  });

  final String title;
  final String address;
  final String status;
  final String distance;
  final String? logoUrl;
  final VoidCallback? onCall;
  final VoidCallback? onDirection;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo với glass effect
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child:
                          logoUrl != null
                              ? Image.network(
                                '${AppConstants.BASE_URL}$logoUrl',
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                                errorBuilder:
                                    (context, error, stackTrace) => const Icon(
                                      Icons.account_balance,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                              )
                              : const Icon(
                                Icons.account_balance,
                                size: 30,
                                color: Colors.white,
                              ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      Text(
                        address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 4),

                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              status,
                              style: TextStyle(
                                color: Colors.greenAccent.shade200,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              distance,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: Colors.white.withOpacity(0.8),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _LocationActionButton(
                            icon: Icons.phone,
                            label: 'Call',
                            onTap: onCall,
                          ),
                          _LocationActionButton(
                            icon: Icons.directions,
                            label: 'Directions',
                            isPrimary: true,
                            onTap: onDirection,
                          ),
                          _LocationActionButton(
                            icon: Icons.share,
                            label: 'Share',
                            onTap: onShare,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationActionButton extends StatelessWidget {
  const _LocationActionButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.isPrimary = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color:
                    isPrimary
                        ? Colors.white.withOpacity(0.25)
                        : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      isPrimary
                          ? Colors.white.withOpacity(0.4)
                          : Colors.white.withOpacity(0.2),
                ),
                boxShadow:
                    isPrimary
                        ? [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ]
                        : null,
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
