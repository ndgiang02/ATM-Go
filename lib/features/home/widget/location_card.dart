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
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child:
                    logoUrl != null
                        ? Image.network(
                          'http://localhost:8000$logoUrl',
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        )
                        : const Icon(
                          Icons.account_balance,
                          size: 24,
                          color: Colors.blue,
                        ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          status,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          distance,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

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
    final color = isPrimary ? Colors.white : Colors.blue;
    final bgColor = isPrimary ? Colors.blue : Colors.white;
    const borderColor = Colors.blue;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
