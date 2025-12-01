import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../l10n/app_localizations.dart';

class InsightsWidget extends StatefulWidget {
  const InsightsWidget({super.key});

  @override
  State<InsightsWidget> createState() => _InsightsWidgetState();
}

class _InsightsWidgetState extends State<InsightsWidget> {
  static const double _latitude = 43.6532;
  static const double _longitude = -79.3832;
  static const String _locationLabel = 'Toronto, ON'; // Consider localizing if needed

  late Future<_InsightsData> _insightsFuture;

  @override
  void initState() {
    super.initState();
    _insightsFuture = _fetchInsights();
  }

  Future<_InsightsData> _fetchInsights() async {
    final quoteFuture = http.get(
      Uri.parse('https://api.quotable.io/random?tags=inspirational|life'),
    );

    final weatherFuture = http.get(
      Uri.parse(
        'https://api.open-meteo.com/v1/forecast'
            '?latitude=$_latitude'
            '&longitude=$_longitude'
            '&current_weather=true',
      ),
    );

    final results = await Future.wait([quoteFuture, weatherFuture]);

    final quoteResponse = results[0];
    final weatherResponse = results[1];

    if (quoteResponse.statusCode != 200) {
      throw Exception(AppLocalizations.of(context)?.quoteLoadError ?? 'Could not load quote. Please try again.');
    }

    if (weatherResponse.statusCode != 200) {
      throw Exception(AppLocalizations.of(context)?.weatherLoadError ?? 'Could not load weather. Please try again.');
    }

    final quoteData = jsonDecode(quoteResponse.body);
    final weatherData = jsonDecode(weatherResponse.body);

    final currentWeather = weatherData['current_weather'] ?? {};
    final temperature = (currentWeather['temperature'] as num?)?.toDouble() ?? 0;
    final weatherCode = (currentWeather['weathercode'] as num?)?.toInt();

    return _InsightsData(
      quote: quoteData['content'] as String? ?? (AppLocalizations.of(context)?.quoteFallback ?? 'Stay positive and keep going.'),
      author: quoteData['author'] as String? ?? (AppLocalizations.of(context)?.unknownAuthor ?? 'Unknown'),
      temperature: temperature,
      weatherDescription: _weatherDescription(weatherCode),
      weatherCode: weatherCode,
      locationLabel: _locationLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_InsightsData>(
      future: _insightsFuture,
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error state
        if (snapshot.hasError) {
          final bool dark = Theme.of(context).brightness == Brightness.dark;

          return _InsightsCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.error.toString(),
                  style: TextStyle(color: dark ? Colors.redAccent : Colors.red),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _insightsFuture = _fetchInsights();
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: Text(
                    AppLocalizations.of(context)?.tryAgain ?? 'Try again',
                    style: TextStyle(color: dark ? Colors.tealAccent : Colors.teal),
                  ),
                ),
              ],
            ),
          );
        }

        // Data loaded
        final data = snapshot.data!;
        final bool dark = Theme.of(context).brightness == Brightness.dark;

        return _InsightsCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WeatherRow(data: data),

              Divider(
                height: 32,
                color: dark ? Colors.white24 : Colors.black26,
              ),

              Text(
                '"${data.quote}"',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: dark ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                '- ${data.author}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: dark ? Colors.tealAccent : Colors.teal,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static String _weatherDescription(int? code) {
    const descriptions = {
      0: 'Clear sky',
      1: 'Mainly clear',
      2: 'Partly cloudy',
      3: 'Overcast',
      45: 'Foggy',
      48: 'Rime fog',
      51: 'Light drizzle',
      53: 'Drizzle',
      55: 'Heavy drizzle',
      61: 'Light rain',
      63: 'Rain',
      65: 'Heavy rain',
      71: 'Light snow',
      73: 'Snow',
      75: 'Heavy snow',
      80: 'Showers',
      81: 'Rain showers',
      82: 'Heavy showers',
    };
    return descriptions[code] ?? 'Weather update';
  }
}

// ----------- Helpers -----------

IconData _weatherIcon(int? code) {
  if (code == null) return Icons.wb_sunny;
  if (code == 0 || code == 1) return Icons.wb_sunny;
  if (code == 2) return Icons.cloud_queue;
  if (code == 3) return Icons.wb_cloudy;
  if (code >= 51 && code <= 65) return Icons.umbrella;
  if (code >= 71 && code <= 82) return Icons.ac_unit;
  return Icons.wb_sunny;
}

class _InsightsData {
  const _InsightsData({
    required this.quote,
    required this.author,
    required this.temperature,
    required this.weatherDescription,
    required this.weatherCode,
    required this.locationLabel,
  });

  final String quote;
  final String author;
  final double temperature;
  final String weatherDescription;
  final int? weatherCode;
  final String locationLabel;
}

class _InsightsCard extends StatelessWidget {
  const _InsightsCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: dark
              ? [Color(0xFF2C2C2C), Color(0xFF3A3A3A)]
              : [Color(0xFFB2F1E4), Color(0xFFE4F9F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: dark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: dark ? Colors.white : Colors.black87),
        child: child,
      ),
    );
  }
}

class _WeatherRow extends StatelessWidget {
  const _WeatherRow({required this.data});

  final _InsightsData data;

  @override
  Widget build(BuildContext context) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: dark ? Colors.white.withOpacity(0.12) : Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _weatherIcon(data.weatherCode),
            size: 32,
            color: dark ? Colors.tealAccent : Colors.blueGrey,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            '${data.locationLabel} • ${data.temperature.toStringAsFixed(0)}°C • ${data.weatherDescription}',
            style: TextStyle(
              fontSize: 15,
              color: dark ? Colors.white70 : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
