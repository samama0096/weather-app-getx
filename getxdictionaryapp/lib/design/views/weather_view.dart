import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../viewmodels/weather_vm.dart';

class WeatherView extends StatelessWidget {
  WeatherView({super.key});
  final WeatherViewModel viewModel = Get.put(WeatherViewModel());

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Text(
            '☀️',
            style: TextStyle(color: Colors.black, fontSize: 26),
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          '  WhatFeels ',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        actions: [
          Center(
            child: Text(
              '☁️',
              style: TextStyle(color: Colors.black, fontSize: 26),
            ),
          ),
          SizedBox(
            width: 10,
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              final desc = viewModel.weather.value!.description;
              return Hero(
                tag: 'test',
                child: SizedBox(
                  height: s.height * 0.25,
                  width: s.width * 0.5,
                  child: Lottie.asset(
                      desc == ''
                          ? 'lib/assets/lotties/sun_cloud.json'
                          : desc.trim() == 'clear sky'
                              ? 'lib/assets/lotties/loading.json'
                              : desc.contains('rain')
                                  ? 'lib/assets/lotties/thunder.json'
                                  : 'lib/assets/lotties/sun_cloud.json',
                      fit: BoxFit.cover),
                ),
              );
            }),
            Obx(() {
              final weather = viewModel.weather.value;
              final isLoading = viewModel.isLoading.value;
              final hasError = viewModel.hasError.value;

              if (isLoading) {
                return SizedBox(
                  height: s.height * 0.1,
                  width: s.width * 0.2,
                  child: Lottie.asset('lib/assets/lotties/loading.json',
                      fit: BoxFit.cover),
                );
              } else if (hasError) {
                return const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48.0,
                      ),
                    ),
                    Text('May be the City name you entered is not valid...')
                  ],
                );
              } else if (weather!.city.trim() == '') {
                return const Center(
                    child: Text('Enter a city to get weather data.'));
              }

              final temperature = weather.temperature;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                        tileColor: Colors.blueGrey.shade50.withOpacity(0.6),
                        title: Text('City: ${weather.city}'),
                        trailing:
                            Icon(Icons.location_city, color: Colors.blueGrey),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.yellow)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                        tileColor: Colors.blueGrey.shade50.withOpacity(0.6),
                        title: Text('Description: ${weather.description}'),
                        trailing: Icon(Icons.description, color: Colors.green),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.yellow)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                        tileColor: Colors.blueGrey.shade50.withOpacity(0.6),
                        title: Text(
                            'Temperature: ${temperature.toStringAsFixed(2)}°C'),
                        trailing: Icon(Icons.thermostat, color: Colors.orange),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.yellow)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                        tileColor: Colors.blueGrey.shade50.withOpacity(0.6),
                        title: Text('Humidity: ${weather.humidity}%'),
                        trailing: Icon(
                          Icons.water_drop_outlined,
                          color: Colors.blue,
                        ),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.yellow)),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (value) {
                    viewModel.fetchWeather(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter a city name to search...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
