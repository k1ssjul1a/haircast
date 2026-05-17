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

  // Pastel colors based on description
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
          'https://geocoding-api.open-meteo.com/v1/search?name=$_city&count=1&language=en&format=json');
      final geoResponse = await http.get(geoUrl);

      if (geoResponse.statusCode == 200) {
        final geoData = json.decode(geoResponse.body);
        if (geoData['results'] != null && geoData['results'].isNotEmpty) {
          final lat = geoData['results'][0]['latitude'];
          final lon = geoData['results'][0]['longitude'];

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text("Change Location", style: TextStyle(color: Colors.black)),
        content: TextField(
          onChanged: (value) => newCity = value,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: "Enter city name",
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _city = newCity;
              });
              Navigator.pop(context);
              _fetchWeatherData();
            },
            child: const Text("OK", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
        color: _pastelPurple, // Using one of the 4 pastel colors for the card background
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome_rounded, color: Colors.black, size: 28),
                  const SizedBox(width: 12),
                  const Text(
                    "Today's Haircast",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: _showLocationDialog,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on, size: 14, color: Colors.black),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                _city,
                                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_isLoading)
                const Center(child: CircularProgressIndicator(color: Colors.black))
              else if (_error.isNotEmpty)
                Center(child: Text("Error fetching data", style: TextStyle(color: Colors.black.withOpacity(0.5))))
              else ...[
                // Weather Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      _FactorRow(icon: Icons.water_drop_outlined, label: "Humidity", value: "${_humidity ?? '--'}%"),
                      _FactorRow(icon: Icons.air_outlined, label: "Wind", value: "${_windSpeed ?? '--'} km/h"),
                      _FactorRow(icon: Icons.umbrella_outlined, label: "Rain", value: _rain! > 0 ? "${_rain!.toStringAsFixed(1)} mm" : "None"),
                      _FactorRow(icon: Icons.wb_sunny_outlined, label: "Sun", value: _isSunny ? "Sunny" : "Cloudy"),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Score Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Predicted Hair Score",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "8/10",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Note Box
                Container(
                  padding: const EdgeInsets.all(14),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    _randomNote,
                    style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 14),
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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.05), shape: BoxShape.circle),
            child: Icon(icon, size: 18, color: Colors.black),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.black)),
        ],
      ),
    );
  }
}
