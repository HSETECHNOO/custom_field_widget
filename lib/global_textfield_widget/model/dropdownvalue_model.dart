class GrobalDropdownItemModel<T> {
  final String value;
  final String name;
  final T data;

  GrobalDropdownItemModel(
      {required this.name, required this.value, required this.data});
}
typedef OnChangeCallback<T> = void Function(GrobalDropdownItemModel<T>? item);
