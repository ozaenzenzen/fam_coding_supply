import 'dart:math';

extension ListExtensions<T> on List<T> {
  // Get a random element
  T get random => this[Random().nextInt(length)];

  // Split list into chunks of given size
  List<List<T>> chunk(int size) {
    return List.generate((length / size).ceil(), (i) => sublist(i * size, min((i + 1) * size, length)));
  }

  // Remove null values
  List<T> get removeNulls => where((element) => element != null).toList();

  // Add item if not already present
  void addIfNotContains(T item) {
    if (!contains(item)) add(item);
  }

  // Toggle item in list (add if not present, remove if present)
  void toggle(T item) {
    contains(item) ? remove(item) : add(item);
  }

  // Get a copy of the list
  List<T> get copy => List.from(this);

  // Check if list is not empty
  bool get isNotEmptyOrNull => isNotEmpty;

  // Get first element or null if empty
  T? get firstOrNull => isEmpty ? null : first;

  // Get last element or null if empty
  T? get lastOrNull => isEmpty ? null : last;

  // Map each element with index
  List<R> mapIndexed<R>(R Function(int index, T element) f) {
    return asMap().entries.map((entry) => f(entry.key, entry.value)).toList();
  }
}
