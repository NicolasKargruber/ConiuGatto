import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/service/package_info_service.dart';
import '../../../utilities/app_values.dart';
import '../../../utilities/error_snack_bar.dart';
import '../../widgets/buy_me_a_coffee_button.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static final _logTag = (AboutScreen).toString();

  // TODO Use Navigator
  static show(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) =>
        ChangeNotifierProvider(
          create: (_) => PackageInfoService(),
          child: AboutScreen(),
        ))
    );
  }

  onBuyMeACoffeePressed(BuildContext context) async {
    final Uri url = Uri.parse('https://buymeacoffee.com/nicolaskargruber');
    if (!await launchUrl(url)) {
      debugPrint("$_logTag | Exception: Could not launch $url");
      if(context.mounted) ErrorSnackbar.show(context, "Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    final packageInfo = context.watch<PackageInfoService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
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

          const SizedBox(height: AppValues.s20),

          BuyMeACoffeeButton(onPressed: () => onBuyMeACoffeePressed(context)),

          /*_buildMenuItem(context, 'Buy me coffe '),
          _buildMenuItem(context, 'Community Standards'),
          _buildMenuItem(context, 'Terms of Use'),
          _buildMenuItem(context, 'Third party Notices'),
          _buildMenuItem(context, 'Privacy and Cookies'),*/
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Add your navigation logic here
      },
    );
  }
}
