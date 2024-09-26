import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_news_app/const/app_colors.dart';
import 'package:my_news_app/core/router/router_pod.dart';
import 'package:my_news_app/featured/home/controller/country_config_controller.dart';
import 'package:my_news_app/featured/home/controller/country_provider.dart';
import 'package:my_news_app/featured/home/view/widget/news_scroll_view_widget.dart';
import 'package:my_news_app/shared/widget/no_internet_widget.dart'; // Import where your providers are defined

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Toast(
      navigatorKey: navigatorKey,
      child: const HomeView(),
    ).monitorConnection();
  }
}

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(countryCodesProvider.notifier).fetchCountryCodes();
  }

  @override
  Widget build(BuildContext context) {
    String selectedCountryLabel = ref.watch(countryProvider);
    final countryCodes = ref.watch(countryCodesProvider);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.appBarBackgroundColor,        
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarBackgroundColor,
          iconTheme: const IconThemeData( color: AppColors.kWhite),
          title: Text(
            'MyNews',
            style: GoogleFonts.poppins(
              color: AppColors.kWhite,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.login,
                color: AppColors.kWhite,
              ),
              onPressed: () {
                // Handle login action
              },
            ),
            
            const SizedBox(width: 10),

            PopupMenuButton<String>(
              onSelected: (String country) {
                // Update the selected country in the provider
                ref.read(countryProvider.notifier).state = countryCodes[country]!;
                
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  selectedCountryLabel,
                  style: GoogleFonts.poppins(
                    color: AppColors.kWhite,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              itemBuilder: (BuildContext context) {
                return countryCodes.keys.map((String country) {
                  return PopupMenuItem<String>(
                    value: country,
                    child: Text(
                      country,
                      style: GoogleFonts.poppins(
                        color: AppColors.kBlack,
                      ),
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Top Headlines',
                style: GoogleFonts.poppins(
                  color: AppColors.kBlack,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,

                ),
              ),

              const SizedBox(height: 10),

              const Expanded(
                child: NewsScrollViewWidget(),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
