/// Cast an Object or Iterable to a List or return an empty List.
List<T2> formatList<T1, T2>(T1? val) {
  if (val == null || val is! List) return [];
  return [for (final i in val) i as T2];
}
