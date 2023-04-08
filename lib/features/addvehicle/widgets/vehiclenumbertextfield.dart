part of '../addvehicle.dart';

class VehicleNumberTextField extends StatelessWidget {
  const VehicleNumberTextField({
    super.key,
    required TextEditingController vehicleNumber,
  }) : _vehicleNumber = vehicleNumber;

  final TextEditingController _vehicleNumber;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _vehicleNumber,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Vehicle Number',
        hintText: 'Enter vehicle number',
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.green,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSaved: (newValue) => _vehicleNumber.text = newValue!,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter vehicle number';
        }
        return null;
      },
    );
  }
}
