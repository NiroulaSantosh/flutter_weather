import 'dart:io';

String readFile(String name) =>
    File('/home/san/Documents/flutter/flutter_weather/test/fixtures/$name')
        .readAsStringSync();
