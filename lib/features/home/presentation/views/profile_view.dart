import 'package:flutter/material.dart';
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
                  backgroundColor: AppColors.lightPrimaryColor.withOpacity(0.1),
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
              ],
            ),
          ),
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
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
