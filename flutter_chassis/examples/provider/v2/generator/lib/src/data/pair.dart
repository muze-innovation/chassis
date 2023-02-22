class Pair<First, Second> {
  final First first;
  final Second second;

  Pair({required this.first, required this.second});

  @override
  String toString() => "($first: $second)";
}

pairOf<First, Second>(First first, Second second) =>
    Pair(first: first, second: second);
