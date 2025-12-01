import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsightsWidget extends StatefulWidget {
  const InsightsWidget({super.key});

  @override
  State<InsightsWidget> createState() => _InsightsWidgetState();
}

class _InsightsWidgetState extends State<InsightsWidget> {
  // Toronto, ON coordinates
  static const double _latitude = 43.6532;
  static const double _longitude = -79.3832;
  static const String _locationLabel = 'Toronto, ON';

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
      throw Exception('Could not load quote. Please try again.');
    }

    if (weatherResponse.statusCode != 200) {
      throw Exception('Could not load weather. Please try again.');
    }

    final quoteData = jsonDecode(quoteResponse.body) as Map<String, dynamic>;
    final weatherData = jsonDecode(weatherResponse.body) as Map<String, dynamic>;
    final currentWeather =
        weatherData['current_weather'] as Map<String, dynamic>? ?? {};
    final temperature =
        (currentWeather['temperature'] as num?)?.toDouble() ?? 0;
    final weatherCode = (currentWeather['weathercode'] as num?)?.toInt();

    return _InsightsData(
      quote: quoteData['content'] as String? ?? 'Stay positive and keep going.',
      author: quoteData['author'] as String? ?? 'Unknown',
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return _InsightsCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.redAccent),
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _insightsFuture = _fetchInsights();
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try again'),
                ),
              ],
            ),
          );
        }

        final data = snapshot.data!;

        return _InsightsCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _WeatherRow(data: data),
              const Divider(height: 32),
              Text(
                '"${data.quote}"',
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '- ${data.author}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
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
      48: 'Depositing rime fog',
      51: 'Light drizzle',
      53: 'Moderate drizzle',
      55: 'Dense drizzle',
      61: 'Light rain',
      63: 'Moderate rain',
      65: 'Heavy rain',
      71: 'Light snow',
      73: 'Moderate snow',
      75: 'Heavy snow',
      80: 'Rain showers',
      81: 'Moderate showers',
      82: 'Violent showers',
    };

    return descriptions[code] ?? 'Weather update';
  }
}

// Weather utility functions
IconData _weatherIcon(int? code) {
  if (code == null) return Icons.wb_sunny;

  // Clear or mainly clear - sunny
  if (code == 0 || code == 1) {
    return Icons.wb_sunny;
  }
  // Partly cloudy
  if (code == 2) {
    return Icons.cloud_queue;
  }
  // Overcast - cloudy
  if (code == 3) {
    return Icons.wb_cloudy;
  }
  // Fog
  if (code == 45 || code == 48) {
    return Icons.foggy;
  }
  // Drizzle or rain
  if (code >= 51 && code <= 65) {
    return Icons.umbrella;
  }
  // Snow
  if (code >= 71 && code <= 77) {
    return Icons.ac_unit;
  }
  // Rain showers
  if (code >= 80 && code <= 82) {
    return Icons.grain;
  }
  // Thunderstorm (codes 95-99)
  if (code >= 95 && code <= 99) {
    return Icons.thunderstorm;
  }

  // Default fallback
  return Icons.wb_sunny;
}

Color _weatherIconColor(int? code) {
  if (code == null) return Colors.orangeAccent;

  // Clear or mainly clear - sunny (orange/yellow)
  if (code == 0 || code == 1) {
    return Colors.orangeAccent;
  }
  // Partly cloudy (light blue)
  if (code == 2) {
    return Colors.lightBlueAccent;
  }
  // Overcast - cloudy (gray)
  if (code == 3) {
    return Colors.grey;
  }
  // Fog (light gray)
  if (code == 45 || code == 48) {
    return Colors.grey;
  }
  // Drizzle or rain (blue)
  if (code >= 51 && code <= 65) {
    return Colors.blueAccent;
  }
  // Snow (light blue/cyan)
  if (code >= 71 && code <= 77) {
    return Colors.lightBlue;
  }
  // Rain showers (blue)
  if (code >= 80 && code <= 82) {
    return Colors.blueAccent;
  }
  // Thunderstorm (dark blue/purple)
  if (code >= 95 && code <= 99) {
    return Colors.deepPurpleAccent;
  }

  // Default fallback
  return Colors.orangeAccent;
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFB2F1E4),
            Color(0xFFE4F9F5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _WeatherRow extends StatelessWidget {
  const _WeatherRow({required this.data});

  final _InsightsData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _weatherIcon(data.weatherCode),
            size: 32,
            color: _weatherIconColor(data.weatherCode),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.locationLabel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${data.temperature.toStringAsFixed(0)}°C • ${data.weatherDescription}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
