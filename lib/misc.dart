List<dynamic> flatten(List<dynamic> list) {
  return list.expand((element) {
    if (element is List) {
      return flatten(element);
    } else {
      return [element];
    }
  }).toList();
}