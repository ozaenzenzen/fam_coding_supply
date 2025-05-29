extension IterableExtensions<T> on Iterable<T> {
  Iterable<E> mapIndexed<E>(E Function(int index, T element) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }

  // Get first element or null if empty
  T? get firstOrNull => isEmpty ? null : first;

  // Get last element or null if empty
  T? get lastOrNull => isEmpty ? null : last;

  // Get element at index or null if out of bounds
  T? elementAtOrNull(int index) => index >= 0 && index < length ? elementAt(index) : null;

  // Group elements by a key
  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final key = keyFunction(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }

  // Check if all elements satisfy condition
  bool all(bool Function(T) test) => every(test);

  // Check if any element satisfies condition
  // bool any(bool Function(T) test) => some(test);

  // Sum of values returned by selector
  num sumBy(num Function(T) selector) => fold(0, (sum, element) => sum + selector(element));

  // Average of values returned by selector
  double averageBy(num Function(T) selector) => isEmpty ? 0 : sumBy(selector) / length;

  // Distinct elements by a key
  Iterable<T> distinctBy<K>(K Function(T) keyFunction) {
    final keys = <K>{};
    return where((element) => keys.add(keyFunction(element)));
  }

  // Join with separator and optional prefix/suffix
  String joinWith({String separator = '', String prefix = '', String suffix = ''}) => '$prefix${join(separator)}$suffix';
}
