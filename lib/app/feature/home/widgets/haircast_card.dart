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
  String _city = "Berlin"; // Default city
  double? _temp;
  double? _windSpeed;
  int? _humidity;
  double? _rain;
  bool _isSunny = false;
  String _error = "";

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
      // 1. Geocoding: Get coordinates for the city
      final geoUrl = Uri.parse(
          'https://geocoding-api.open-meteo.com/v1/search?name=$_city&count=1&language=en&format=json');
      final geoResponse = await http.get(geoUrl);

      if (geoResponse.statusCode == 200) {
        final geoData = json.decode(geoResponse.body);
        if (geoData['results'] != null && geoData['results'].isNotEmpty) {
          final lat = geoData['results'][0]['latitude'];
          final lon = geoData['results'][0]['longitude'];

          // 2. Weather: Get weather data using coordinates
          final weatherUrl = Uri.parse(
              'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,rain,showers,snowfall,wind_speed_10m,weather_code');
          final weatherResponse = await http.get(weatherUrl);

          if (weatherResponse.statusCode == 200) {
            final weatherData = json.decode(weatherResponse.body);
            final current = weatherData['current'];

            setState(() {
              _temp = current['temperature_2m'];
              _windSpeed = current['wind_speed_10m'];
              _humidity = current['relative_humidity_2m'];
              _rain = current['rain'] + current['showers'] + current['snowfall'];
              // Simple logic for "Sunny": clear sky (0) or mainly clear (1)
              _isSunny = current['weather_code'] <= 1;
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
        title: const Text("Change Location"),
        content: TextField(
          onChanged: (value) => newCity = value,
          decoration: const InputDecoration(hintText: "Enter city name"),
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
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome_rounded, color: Colors.teal),
                  const SizedBox(width: 8),
                  const Text(
                    "Today's Haircast",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: _showLocationDialog,
                        icon: const Icon(Icons.location_on, size: 16, color: Colors.teal),
                        label: Flexible(
                          child: Text(
                            _city,
                            style: const TextStyle(color: Colors.teal),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else if (_error.isNotEmpty)
                Center(
                  child: Column(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      Text("Error: $_error"),
                      TextButton(onPressed: _fetchWeatherData, child: const Text("Retry"))
                    ],
                  ),
                )
              else ...[
                // Weather Factors
                const Text(
                  "Weather Factors:",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                const SizedBox(height: 8),
                _FactorRow(
                    icon: Icons.water_drop_outlined,
                    label: "Humidity",
                    value: "${_humidity ?? '--'}%"),
                _FactorRow(
                    icon: Icons.air_outlined,
                    label: "Wind",
                    value: "${_windSpeed ?? '--'} km/h"),
                _FactorRow(
                    icon: Icons.umbrella_outlined,
                    label: "Rain",
                    value: _rain! > 0 ? "${_rain!.toStringAsFixed(1)} mm" : "None"),
                _FactorRow(
                    icon: Icons.wb_sunny_outlined,
                    label: "Sun",
                    value: _isSunny ? "Sunny" : "Cloudy/Other"),

                const SizedBox(height: 12),

                // Hair Factors
                const Text(
                  "Hair Factors:",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                const SizedBox(height: 8),
                const _FactorRow(
                    icon: Icons.calendar_today_outlined, label: "Days since wash", value: "2 days"),

                const Divider(),
                const SizedBox(height: 8),

                // Predicted Hair Score
                Center(
                  child: Column(
                    children: [
                      const Text(
                        "Predicted Hair Score:",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "8/10", // Logic for calculation not required yet
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Funny/Sweet Note
                Container(
                  padding: const EdgeInsets.all(12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.teal[100]!),
                  ),
                  child: Text(
                    _randomNote,
                    style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.teal),
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

class _FactorRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _FactorRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 15)),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
