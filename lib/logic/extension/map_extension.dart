extension MapExtensions<K, V> on Map<K, V> {
  // Get value for key or null if not present
  V? getOrNull(K key) => containsKey(key) ? this[key] : null;

  // Get value for key or default value if not present
  V getOrDefault(K key, V defaultValue) => containsKey(key) ? this[key]! : defaultValue;

  // Map keys only
  Iterable<R> mapKeys<R>(R Function(K key) f) => keys.map(f);

  // Map values only
  Iterable<R> mapValues<R>(R Function(V value) f) => values.map(f);

  // Filter entries by predicate
  Map<K, V> filter(bool Function(K key, V value) predicate) {
    return Map.fromEntries(entries.where((entry) => predicate(entry.key, entry.value)));
  }

  // Convert to query string (for URL parameters)
  String toQueryString() => entries.map((e) => '${Uri.encodeComponent(e.key.toString())}=${Uri.encodeComponent(e.value.toString())}').join('&');

  // Merge with another map
  Map<K, V> merge(Map<K, V> other) => {...this, ...other};

  // Get a copy of the map
  Map<K, V> get copy => Map.from(this);

  // Check if map is not empty
  bool get isNotEmptyOrNull => isNotEmpty;

  // Transform map to another type
  R transform<R>(R Function(Map<K, V>) transformer) => transformer(this);
}
