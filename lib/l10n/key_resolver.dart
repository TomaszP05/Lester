// ...existing code...
import 'package:flutter/widgets.dart';
import 'app_localizations.dart';

// Utility to resolve localization keys stored in the database to actual
// localized strings using the generated AppLocalizations getters.
String resolveLocalizedKey(BuildContext context, String key) {
  final loc = AppLocalizations.of(context);
  if (loc == null) return key;

  switch (key) {
    // Daily challenge names
    case 'daily_challenge_1_name':
      return loc.daily_challenge_1_name;
    case 'daily_challenge_2_name':
      return loc.daily_challenge_2_name;
    case 'daily_challenge_3_name':
      return loc.daily_challenge_3_name;
    case 'daily_challenge_4_name':
      return loc.daily_challenge_4_name;
    case 'daily_challenge_5_name':
      return loc.daily_challenge_5_name;
    case 'daily_challenge_6_name':
      return loc.daily_challenge_6_name;
    case 'daily_challenge_7_name':
      return loc.daily_challenge_7_name;
    case 'daily_challenge_8_name':
      return loc.daily_challenge_8_name;
    case 'daily_challenge_9_name':
      return loc.daily_challenge_9_name;
    case 'daily_challenge_10_name':
      return loc.daily_challenge_10_name;
    case 'daily_challenge_11_name':
      return loc.daily_challenge_11_name;
    case 'daily_challenge_12_name':
      return loc.daily_challenge_12_name;
    case 'daily_challenge_13_name':
      return loc.daily_challenge_13_name;
    case 'daily_challenge_14_name':
      return loc.daily_challenge_14_name;
    case 'daily_challenge_15_name':
      return loc.daily_challenge_15_name;
    case 'daily_challenge_16_name':
      return loc.daily_challenge_16_name;
    case 'daily_challenge_17_name':
      return loc.daily_challenge_17_name;
    case 'daily_challenge_18_name':
      return loc.daily_challenge_18_name;
    case 'daily_challenge_19_name':
      return loc.daily_challenge_19_name;
    case 'daily_challenge_20_name':
      return loc.daily_challenge_20_name;
    case 'daily_challenge_21_name':
      return loc.daily_challenge_21_name;
    case 'daily_challenge_22_name':
      return loc.daily_challenge_22_name;
    case 'daily_challenge_23_name':
      return loc.daily_challenge_23_name;
    case 'daily_challenge_24_name':
      return loc.daily_challenge_24_name;
    case 'daily_challenge_25_name':
      return loc.daily_challenge_25_name;
    case 'daily_challenge_26_name':
      return loc.daily_challenge_26_name;
    case 'daily_challenge_27_name':
      return loc.daily_challenge_27_name;
    case 'daily_challenge_28_name':
      return loc.daily_challenge_28_name;
    case 'daily_challenge_29_name':
      return loc.daily_challenge_29_name;
    case 'daily_challenge_30_name':
      return loc.daily_challenge_30_name;
    case 'daily_challenge_31_name':
      return loc.daily_challenge_31_name;

    // Daily challenge descriptions
    case 'daily_challenge_1_description':
      return loc.daily_challenge_1_description;
    case 'daily_challenge_2_description':
      return loc.daily_challenge_2_description;
    case 'daily_challenge_3_description':
      return loc.daily_challenge_3_description;
    case 'daily_challenge_4_description':
      return loc.daily_challenge_4_description;
    case 'daily_challenge_5_description':
      return loc.daily_challenge_5_description;
    case 'daily_challenge_6_description':
      return loc.daily_challenge_6_description;
    case 'daily_challenge_7_description':
      return loc.daily_challenge_7_description;
    case 'daily_challenge_8_description':
      return loc.daily_challenge_8_description;
    case 'daily_challenge_9_description':
      return loc.daily_challenge_9_description;
    case 'daily_challenge_10_description':
      return loc.daily_challenge_10_description;
    case 'daily_challenge_11_description':
      return loc.daily_challenge_11_description;
    case 'daily_challenge_12_description':
      return loc.daily_challenge_12_description;
    case 'daily_challenge_13_description':
      return loc.daily_challenge_13_description;
    case 'daily_challenge_14_description':
      return loc.daily_challenge_14_description;
    case 'daily_challenge_15_description':
      return loc.daily_challenge_15_description;
    case 'daily_challenge_16_description':
      return loc.daily_challenge_16_description;
    case 'daily_challenge_17_description':
      return loc.daily_challenge_17_description;
    case 'daily_challenge_18_description':
      return loc.daily_challenge_18_description;
    case 'daily_challenge_19_description':
      return loc.daily_challenge_19_description;
    case 'daily_challenge_20_description':
      return loc.daily_challenge_20_description;
    case 'daily_challenge_21_description':
      return loc.daily_challenge_21_description;
    case 'daily_challenge_22_description':
      return loc.daily_challenge_22_description;
    case 'daily_challenge_23_description':
      return loc.daily_challenge_23_description;
    case 'daily_challenge_24_description':
      return loc.daily_challenge_24_description;
    case 'daily_challenge_25_description':
      return loc.daily_challenge_25_description;
    case 'daily_challenge_26_description':
      return loc.daily_challenge_26_description;
    case 'daily_challenge_27_description':
      return loc.daily_challenge_27_description;
    case 'daily_challenge_28_description':
      return loc.daily_challenge_28_description;
    case 'daily_challenge_29_description':
      return loc.daily_challenge_29_description;
    case 'daily_challenge_30_description':
      return loc.daily_challenge_30_description;
    case 'daily_challenge_31_description':
      return loc.daily_challenge_31_description;

    default:
      return key; // fallback to the raw key
  }
}

