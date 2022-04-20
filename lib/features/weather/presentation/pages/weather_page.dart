import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/features/weather/domain/entities/weather.dart'
    as weather;
import 'package:flutter_weather/features/weather/presentation/pages/weather_search_page.dart';

import '../bloc/blocs.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather app'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const WeatherSearchPage()));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Stack(
        children: [
          _WeatherBackground(),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return const Center(
                  child: Text('Enter the name of city you want to know'),
                );
              } else if (state is WeatherLoading) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (state is WeatherError) {
                return Center(child: Text(state.message));
              } else if (state is WeatherLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<WeatherBloc>().add(GetWeatherForLocation(
                          location: state.location.title ?? ""));
                    },
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            _WeatherIcon(
                                condition: state.weather.weatherStateName),
                            Text(
                              state.location.title ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                    fontWeight: FontWeight.w200,
                                  ),
                            ),
                            Text(
                              '${state.weather.theTemp} C',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              '''Last Updated at ${TimeOfDay.fromDateTime(state.weather.created.toLocal()).format(context)}''',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({Key? key, required this.condition}) : super(key: key);

  static const _iconSize = 100.0;

  final weather.WeatherState condition;

  @override
  Widget build(BuildContext context) {
    return Text(
      condition.toEmoji,
      style: const TextStyle(fontSize: _iconSize),
    );
  }
}

extension on weather.WeatherState {
  String get toEmoji {
    switch (this) {
      case weather.WeatherState.clear:
        return '☀️';
      case weather.WeatherState.showers:
        return '🌧️';
      case weather.WeatherState.heavyRain:
        return '🌧️';
      case weather.WeatherState.lightRain:
        return '🌧️';
      case weather.WeatherState.heavyCloud:
        return '☁️';
      case weather.WeatherState.lightCloud:
        return '☁️';
      case weather.WeatherState.snow:
        return '🌨️';
      case weather.WeatherState.unknown:
      default:
        return '❓';
    }
  }
}

class _WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.25, 0.75, 0.90, 1.0],
          colors: [
            color,
            color.brighten(10),
            color.brighten(33),
            color.brighten(50),
          ],
        ),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}
