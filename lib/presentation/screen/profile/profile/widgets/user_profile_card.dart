import 'package:flutter/cupertino.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/presentation/screen/profile/profile/widgets/guest_profile_card.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({
    super.key,
    this.name = 'Мой Nurbox',
    this.phone = '+992 90 123 45 67',
  });

  final String name;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Avatar(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phone,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
