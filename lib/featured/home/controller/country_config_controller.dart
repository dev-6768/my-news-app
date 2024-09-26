import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:my_news_app/shared/api_client/dio_client_provider.dart';

class CountryCodesNotifier extends StateNotifier<Map<String, String>> {
  //default countries in case firebase remote config doesn't work.
  CountryCodesNotifier() : super(
    {
      "India": "IN",
      "United States": "US",
      "England": "GB",
    }
  );
  Future<void> fetchCountryCodes() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 100),
        minimumFetchInterval: const Duration(hours: 1),
      ));

      await remoteConfig.fetchAndActivate();

      String countryCodesJson = remoteConfig.getString('country_codes');

      Map<String, dynamic> decodedJson = json.decode(countryCodesJson);
      
      state = decodedJson.map((key, value) => MapEntry(key, value as String));
      talker.debug(state);
    } 
    
    catch (e) {
      //default countries in case firebase remote config doesn't work.
      state = {
        "India": "IN",
        "United States": "US",
        "England": "GB",
      };
      talker.debug('Error fetching country codes: $e');
    }
  }
}

final countryCodesProvider = StateNotifierProvider<CountryCodesNotifier, Map<String, String>>((ref) {
  return CountryCodesNotifier();
});