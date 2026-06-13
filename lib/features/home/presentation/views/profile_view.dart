import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/cubits/settings_cubit/settings_cubit.dart';
import 'package:fruits_hub/core/helper_functions/get_user.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/constants.dart';
import 'package:fruits_hub/features/auth/presentation/views/signin_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getUser();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 24),
                CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.lightPrimaryColor.withAlpha(25),
                  child: Image.asset(
                    Assets.imagesProfileImage,
                    width: 60,
                    height: 60,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: TextStyles.bold19,
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: TextStyles.regular16.copyWith(
                    color: const Color(0xFF949D9E),
                  ),
                ),
                const SizedBox(height: 32),
                _buildProfileItem(
                  icon: Icons.person_outline,
                  title: 'الاسم',
                  value: user.name,
                ),
                _buildProfileItem(
                  icon: Icons.email_outlined,
                  title: 'البريد الإلكتروني',
                  value: user.email,
                ),
                const SizedBox(height: 24),

                // Settings section
                _buildSectionTitle('الإعدادات'),
                const SizedBox(height: 12),

                // Language toggle
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    final isArabic =
                        context.read<SettingsCubit>().isArabic;
                    return _buildSettingItem(
                      icon: Icons.language,
                      title: 'اللغة',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isArabic ? 'العربية' : 'English',
                            style: TextStyles.semiBold13.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Switch(
                            value: !isArabic,
                            activeColor: AppColors.primaryColor,
                            onChanged: (value) {
                              context.read<SettingsCubit>().changeLocale(
                                    value ? 'en' : 'ar',
                                  );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),

                // Theme toggle
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    final isDark =
                        context.read<SettingsCubit>().isDarkMode;
                    return _buildSettingItem(
                      icon: isDark ? Icons.dark_mode : Icons.light_mode,
                      title: 'المظهر',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isDark ? 'داكن' : 'فاتح',
                            style: TextStyles.semiBold13.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Switch(
                            value: isDark,
                            activeColor: AppColors.primaryColor,
                            onChanged: (value) {
                              context.read<SettingsCubit>().toggleTheme();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      await Prefs.setString(kUserData, '');
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          SigninView.routeName,
                          (route) => false,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      foregroundColor: Colors.red,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'تسجيل الخروج',
                      style: TextStyles.bold16.copyWith(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: TextStyles.bold16.copyWith(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 24),
          const SizedBox(width: 16),
          Text(title, style: TextStyles.semiBold16),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.regular13.copyWith(
                  color: const Color(0xFF949D9E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyles.semiBold16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
