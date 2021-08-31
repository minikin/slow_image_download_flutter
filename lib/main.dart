import 'dart:io';

void main() => measure();

// Feel free to use any other images.
const _imageUri =
    'https://images.unsplash.com/photo-1629109078819-da344f157ebc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80';
final _client = HttpClient();
final _list = List.generate(400, (_) => 0);
final _messureResults = [];

Future<void> measure() async {
  for (final _ in _list) {
    final stopwatch = Stopwatch()..start();
    await _downloadImageFile();
    _messureResults.add(stopwatch.elapsed.inMilliseconds);
    print('${stopwatch.elapsed.inMilliseconds}');
    stopwatch.stop();
    stopwatch.reset();
  }

  _computeResults();
}

void _computeResults() {
  final sum = _messureResults.reduce((current, next) => current + next);
  _messureResults.sort();
  final max = _messureResults.last;
  final min = _messureResults.first;
  final avarage = sum / _messureResults.length;
  final deviation = (max - min) / 2;

  print('Average: $avarage ms, +/- $deviation ms, Max: $max ms');
}

Future<void> _downloadImageFile() async {
  final request = await _client.getUrl(Uri.parse(_imageUri));
  final _ = await request.close();
  //await response.pipe(File('foo.png').openWrite());
}
