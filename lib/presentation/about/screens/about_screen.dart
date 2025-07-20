import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/service/billing_service.dart';
import '../../../domain/service/in_app_review_service.dart';
import '../../../domain/service/package_info_service.dart';
import '../../../main.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/extensions/build_context_extensions.dart';
import '../../introduction/screens/on_boarding_screen.dart';
import '../../widgets/buy_me_a_coffee_button.dart';
import '../../widgets/donation_sheet.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static final _logTag = (AboutScreen).toString();

  // TODO Use Navigator
  static show(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) =>
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => PackageInfoService()
            ),
            ChangeNotifierProvider.value(
              value: context.read<InAppReviewService>(),
            ),
            ChangeNotifierProvider.value(
              value: context.read<BillingService>(),
            ),
          ],
          child: AboutScreen(),
        ),
    )
    );
  }
  
  static showIntroduction(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(
        builder: (_) {
          return OnBoardingScreen(onIntroEnd: () => Navigator.of(context).maybePop());
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    final packageInfo = context.watch<PackageInfoService>();
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization.aboutAppTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          Column(
            children: [
              const SizedBox(height: AppValues.s20),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppValues.s12),
                child: Image.asset(
                  'assets/coniugatto_512x512.png', // Replace with your asset
                  height: AppValues.s80,
                ),
              ),
              const SizedBox(height: AppValues.s12),
              const Text(
                'ConiuGatto',
                style: TextStyle(fontSize: AppValues.fs20, fontWeight: FontWeight.bold),
              ),
              Text('v${packageInfo.version} (${packageInfo.buildNumber})'),
              //const Text('Calling version: 2024.04.081'),
              const SizedBox(height: AppValues.s12),
              const Text(
                'nicolasapps\nCopyright © 2025',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: AppValues.s20),
            ],
          ),
          const Divider(),

          const SizedBox(height: AppValues.s12),

          // Buy Me A Coffee Button
          Center(child: BuyMeACoffeeButton(onPressed: () => DonationSheet.show(context))),

          const SizedBox(height: AppValues.s8),

          _buildMenuItem(context.localization.showIntroduction, () => showIntroduction(context)),

          _ChooseLanguageDropDown(),

          _buildMenuItem(context.localization.showInStore, context.read<InAppReviewService>().openStoreListing),
        ],
      ),
    );
  }
}

Widget _buildMenuItem(String title, Function()? onTap) {
  return ListTile(
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: onTap,
  );
}

class _ChooseLanguageDropDown extends StatelessWidget {
  const _ChooseLanguageDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        customButton: _buildMenuItem(context.localization.changeLanguage, null),
        items: ["English", "Deutsch"].map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: (value) {
          MyApp.of(context)?.setLocale(Locale(value!.substring(0, 2).toLowerCase()));
        },
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 8),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black45,
          ),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          direction: DropdownDirection.left,
          width: AppValues.s180,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppValues.r16),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: AppValues.p16),
        ),
      ),
    );
  }
}

