import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recase/recase.dart';
import 'package:weather_app_provider/pages/search_page.dart';
import 'package:weather_app_provider/providers/temp_settings/temp_settings_provider.dart';
import 'package:weather_app_provider/providers/weather/weather_provider.dart';

import '../constants/constants.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;
  late final WeatherProvider _weatherProvider;
  @override
  void initState() {
    _weatherProvider = context.read<WeatherProvider>();
    _weatherProvider.addListener(_registerListener);
    super.initState();
  }

  @override
  void dispose() {
    _weatherProvider.removeListener(_registerListener);
    super.dispose();
  }

  void _registerListener() {
    final WeatherState state = context.read<WeatherProvider>().state;
    if (state.status == WeatherStatus.error) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(state.customError.errorMsg),
            );
          });
    }
  }

  String showTemperature(double temperature) {
    final tempUnit = context.watch<TempSettingsProvider>().state.tempUnit;

    if (tempUnit == TempUnit.fahrenheit) {
      return ((temperature * 9 / 5) + 32).toStringAsFixed(2) + '℉';
    }

    return temperature.toStringAsFixed(2) + '℃';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              _city = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const SearchPage();
                }),
              );

              if (_city != null) {
                if (mounted) {
                  // ignore: use_build_context_synchronously
                  context.read<WeatherProvider>().fetchWeather(_city!);
                }
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const SettingsPage();
                }),
              );
            },
          ),
        ],
      ),
      body: _showWeather(),
    );
  }

  Widget showIcon(String icon) {
    return Image.network(
      // placeholder: 'assets/images/loading.gif',
      'http://$kIconHost/img/wn/$icon@4x.png',
      width: 96,
      height: 96,
    );
  }

  Widget formatText(String description) {
    final formattedString = description.titleCase;
    return Text(
      formattedString,
      style: const TextStyle(fontSize: 24.0),
      textAlign: TextAlign.center,
    );
  }

  Widget _showWeather() {
    final state = context.watch<WeatherProvider>().state;
    if (state.status == WeatherStatus.initial) {
      return const Center(
        child: Text(
          'Select a city',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      );
    }

    if (state.status == WeatherStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state.status == WeatherStatus.error && state.weatherModel.name == "") {
      return const Center(
        child: Text(
          'Select a city',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      );
    }
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 6,
        ),
        Text(
          state.weatherModel.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TimeOfDay.fromDateTime(state.weatherModel.lastUpdated)
                  .format(context),
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(width: 10.0),
            Text(
              '(${state.weatherModel.country})',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
        const SizedBox(height: 60.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showTemperature(state.weatherModel.temp),
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              children: [
                Text(
                 showTemperature(state.weatherModel.tempMax),
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  showTemperature(state.weatherModel.tempMin),
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 40.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            showIcon(state.weatherModel.icon),
            Expanded(
              flex: 3,
              child: formatText(state.weatherModel.description),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
