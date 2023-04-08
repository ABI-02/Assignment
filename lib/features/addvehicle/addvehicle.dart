import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

part 'widgets/vehiclenumbertextfield.dart';
part 'widgets/mydropdownmenu.dart';

enum VehicleType { Car, Bike }

enum FuelType { Petrol, Diesel }

class AddVehicleScreen extends StatefulWidget {
  static const String routeName = '/addvehicle';
  const AddVehicleScreen({super.key});

  @override
  _AddVehicleScreenState createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  // Define a global key for the form
  final _formKey = GlobalKey<FormState>();

  // Define some variables to store the user's selections
  final TextEditingController _vehicleNumber = TextEditingController();
  String _selectedBrandName = '';
  String _selectedVehicleType = '';
  String _selectedFuelType = '';

  // Define some variables to have a list of items to display in the dropdown
  final List<String> _brandName = ['Toyota', 'Honda', 'Suzuki'];

  // Define a function to handle form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await FirebaseFirestore.instance.collection('vehicles').add({
          'number': _vehicleNumber.text,
          'brandName': _selectedBrandName,
          'vehicleType': _selectedVehicleType,
          'fuelType': _selectedFuelType,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data saved successfully.'),
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
          ),
        );
      }
    }
  }

  _isFormComplete() {
    return _vehicleNumber.text.isNotEmpty &&
        _selectedBrandName.isNotEmpty &&
        _selectedVehicleType.isNotEmpty &&
        _selectedFuelType.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Define a TextFormField for the vehicle number
                VehicleNumberTextField(vehicleNumber: _vehicleNumber),
                const SizedBox(height: 16.0),
                // Define a DropdownButtonFormField to allow the user to select the brand name
                MyDropDownMenu(
                    label: 'Brand Name',
                    selectedValue: _selectedBrandName,
                    listItems: _brandName,
                    onChanged: (newValue) => setState(() {
                          _selectedBrandName = newValue!;
                        })),
                const SizedBox(height: 16.0),
                // Define a FormField to allow the user to select the vehicle type
                MyDropDownMenu(
                  label: 'Vehicle Type',
                  selectedValue: _selectedVehicleType,
                  listItems: VehicleType.values
                      .map((e) => e.toString().split('.').last)
                      .toList(),
                  onChanged: (newValue) => setState(() {
                    _selectedVehicleType = newValue!;
                  }),
                ),
                const SizedBox(height: 16.0),
                // Define a FormField to allow the user to select the fuel type
                MyDropDownMenu(
                  label: 'Fuel Type',
                  selectedValue: _selectedFuelType,
                  listItems: FuelType.values.map((e) => e.toString()).toList(),
                  onChanged: (newValue) => setState(() {
                    _selectedFuelType = newValue!;
                  }),
                ),
                const SizedBox(height: 128.0),
                // Define a button to submit the form
                ElevatedButton(
                  onPressed: _isFormComplete() ? _submitForm : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    backgroundColor:
                        _isFormComplete() ? Colors.green : Colors.grey,
                  ),
                  child: const Text('Add Vehicle'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
