part of '../addvehicle.dart';

class MyDropDownMenu extends StatelessWidget {
  final String label;
  final String selectedValue;
  final List<String> listItems;
  final Function(String?)? onChanged;
  const MyDropDownMenu(
      {super.key,
      required this.selectedValue,
      required this.listItems,
      required this.onChanged,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      icon: const Icon(Icons.arrow_drop_down_circle),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      ),
      items: listItems
          .map((e) => DropdownMenuItem(
                value: e.split('.').last,
                child: Text(e.split('.').last),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}