import 'package:flutter/material.dart';
import 'package:nurbox/core/ui/colors/app_colors.dart';
import 'package:nurbox/core/widgets/screen_header.dart';
import 'package:nurbox/presentation/screen/profile/profile/widgets/guest_profile_card.dart';
import 'package:nurbox/presentation/screen/profile/profile/widgets/profile_menu_item.dart';
import 'package:nurbox/presentation/screen/profile/profile/widgets/user_profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    this.isLoggedIn = false,
    this.userName = 'Мой Nurbox',
    this.phone = '+992 90 123 45 67',
    this.onLogin,
    this.onHistory,
    this.onPaymentMethod,
    this.onHelp,
    this.onAbout,
    this.onPartner,
    this.onLogout,
  });

  final bool isLoggedIn;
  final String userName;
  final String phone;

  final VoidCallback? onLogin;
  final VoidCallback? onHistory;
  final VoidCallback? onPaymentMethod;
  final VoidCallback? onHelp;
  final VoidCallback? onAbout;
  final VoidCallback? onPartner;
  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenHeader(
                      title: 'Профиль',
                      subtitle: isLoggedIn
                          ? null
                          : 'Аренды, чеки и настройки в одном месте',
                    ),
                    const SizedBox(height: 24),
                    if (isLoggedIn)
                      UserProfileCard(name: userName, phone: phone)
                    else
                      GuestProfileCard(),
                    const SizedBox(height: 24),
                    Text(
                      isLoggedIn ? 'Мой аккаунт' : 'Другое',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ProfileMenuItem(text: 'История аренды', onTap: (){
                      Navigator.of(context).pushNamed('/rental_history');
                    }),
                    if (isLoggedIn)
                      ProfileMenuItem(
                        text: 'Способ оплаты',
                        onTap: onPaymentMethod,
                      ),
                    ProfileMenuItem(text: 'Помощь', onTap: onHelp),
                    ProfileMenuItem(text: 'О приложении', onTap: onAbout),
                    ProfileMenuItem(text: 'Стать партнёром', onTap: onPartner),
                    const Spacer(),
                    if (isLoggedIn) ...[
                      const SizedBox(height: 16),
                      ProfileLogoutButton(onPressed: onLogout),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
