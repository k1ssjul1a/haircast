import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class HaircastCard extends StatefulWidget {
  const HaircastCard({super.key});

  @override
  State<HaircastCard> createState() => _HaircastCardState();
}

class _HaircastCardState extends State<HaircastCard> {
  bool _isLoading = true;
  String _city = "Berlin";
  double? _temp;
  double? _windSpeed;
  int? _humidity;
  double? _rain;
  bool _isSunny = false;
  String _error = "";

  final Color _pastelPurple = const Color(0xFFBA99EA);

  final List<String> _notes = [
    "\"Your hair looks so good today, even the wind is jealous!\"",
    "\"Hair today, fabulous tomorrow!\"",
    "\"Let your hair do the talking today.\"",
    "\"A good hair day is the best kind of day.\"",
    "\"Shine bright like your hair!\""
  ];

  late String _randomNote;

  @override
  void initState() {
    super.initState();
    _randomNote = _notes[Random().nextInt(_notes.length)];
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _isLoading = true;
      _error = "";
    });

    try {
      final geoUrl = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$_city&count=1&language=en&format=json',
      );

      final geoResponse = await http.get(geoUrl);

      if (geoResponse.statusCode == 200) {
        final geoData = json.decode(geoResponse.body);

        if (geoData['results'] != null && geoData['results'].isNotEmpty) {
          final lat = geoData['results'][0]['latitude'];
          final lon = geoData['results'][0]['longitude'];

          final weatherUrl = Uri.parse(
            'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,rain,showers,snowfall,wind_speed_10m,weather_code',
          );

          final weatherResponse = await http.get(weatherUrl);

          if (weatherResponse.statusCode == 200) {
            final weatherData = json.decode(weatherResponse.body);
            final current = weatherData['current'];

            if (!mounted) return;

            setState(() {
              _temp = current['temperature_2m'];
              _windSpeed = current['wind_speed_10m'];
              _humidity = current['relative_humidity_2m'];

              _rain = (current['rain'] ?? 0) +
                  (current['showers'] ?? 0) +
                  (current['snowfall'] ?? 0);

              _isSunny = (current['weather_code'] ?? 0) <= 1;
              _isLoading = false;
            });
          } else {
            throw Exception("Failed to load weather data");
          }
        } else {
          throw Exception("City not found");
        }
      } else {
        throw Exception("Geocoding failed");
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _showLocationDialog() {
    String newCity = _city;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text("Change Location"),
        content: TextField(
          onChanged: (value) => newCity = value,
          decoration: InputDecoration(
            hintText: "Enter city name",
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _city = newCity;
              });
              Navigator.pop(context);
              _fetchWeatherData();
            },
            child: const Text(
              "OK",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Card(
        color: _pastelPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome_rounded, size: 28),
                  const SizedBox(width: 12),
                  const Text(
                    "Today's Haircast",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _showLocationDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(_city),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_error.isNotEmpty)
                Text("Error: $_error")
              else ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Text("Humidity: ${_humidity ?? '--'}%"),
                        Text("Wind: ${_windSpeed ?? '--'} km/h"),
                        Text(
                          "Rain: ${_rain?.toStringAsFixed(1) ?? '0'} mm",
                        ),
                        Text(_isSunny ? "Sunny" : "Cloudy"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      "Predicted Hair Score: 8/10",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      _randomNote,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
            ],
          ),
        ),
      ),
    );
  }
}