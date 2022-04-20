import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/features/weather/presentation/bloc/blocs.dart';

class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage({Key? key}) : super(key: key);

  @override
  State<WeatherSearchPage> createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter the city name';
              }
              return null;
            },
            onFieldSubmitted: (value) {
              if (formKey.currentState!.validate()) {
                context
                    .read<WeatherBloc>()
                    .add(GetWeatherForLocation(location: value));
                Navigator.of(context).pop();
              }
            },
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
