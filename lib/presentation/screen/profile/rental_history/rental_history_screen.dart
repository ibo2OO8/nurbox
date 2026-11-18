import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/screen_header.dart';
import 'package:nurbox/presentation/screen/profile/rental_history/widgets/rental_card.dart';
import 'package:nurbox/presentation/screen/profile/rental_history/widgets/rental_item.dart';

class RentalHistoryScreen extends StatelessWidget {
  const RentalHistoryScreen({
    super.key,
    this.subtitle = 'Все завершённые аренды',
    this.month = 'Сентябрь 2026',
    this.rentals = defaultRentals,
    this.emptyText = 'Пока нет завершённых аренд',
    this.onRentalTap,
  });

  static const defaultRentals = [
    RentalItem(
      address: 'Рудаки, 42',
      dateTime: '28 сентября · 14:20',
      duration: '37 минут',
      price: '5 сом',
    ),
  ];

  final String subtitle;
  final String month;
  final List<RentalItem> rentals;
  final String emptyText;
  final ValueChanged<RentalItem>? onRentalTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenHeader(title: 'История аренды', subtitle: subtitle),
              const SizedBox(height: 24),
              if (rentals.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    emptyText,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.secondaryText,
                    ),
                  ),
                )
              else ...[
                Text(
                  month,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: rentals.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = rentals[index];
                      return RentalCard(
                        item: item,
                        onTap: () => onRentalTap?.call(item),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
