import 'package:abinchan/features/addvehicle/addvehicle.dart';
import 'package:abinchan/models/vehicle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VehicleScreen extends StatefulWidget {
  static const String routeName = '/vehicles';
  const VehicleScreen({Key? key}) : super(key: key);

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late CollectionReference _collectionReference;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _collectionReference = FirebaseFirestore.instance.collection('vehicles');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicles'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Cars'),
            Tab(text: 'Bikes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          VehiclesListWidget(
              collectionReference: _collectionReference, vehicleType: 'Car'),
          VehiclesListWidget(
              collectionReference: _collectionReference, vehicleType: 'Bike'),
        ],
      ),
      // Adding an ElevatedButton to the bottom of the screen
      persistentFooterButtons: [
        ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          onPressed: () {
            Navigator.pushNamed(context, AddVehicleScreen.routeName);
          },
          child: const Text('Add Vehicle'),
        ),
      ],
    );
  }
}

class VehiclesListWidget extends StatelessWidget {
  const VehiclesListWidget({
    super.key,
    required CollectionReference<Object?> collectionReference,
    required this.vehicleType,
  }) : _collectionReference = collectionReference;

  final CollectionReference<Object?> _collectionReference;
  final String vehicleType;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _collectionReference
          .where('vehicleType', isEqualTo: vehicleType)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Loading'));
        }

        final List<Vehicle> vehiclesList = snapshot.data!.docs
            .map((DocumentSnapshot document) =>
                Vehicle.fromJson(document.data() as Map<String, dynamic>)
                    .copyWith(id: document.id))
            .toList();

        return ListView.builder(
          itemCount: vehiclesList.length,
          itemBuilder: (BuildContext context, int index) {
            final Vehicle vehicle = vehiclesList[index];

            return Container(
              margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: index == 0 ? 20.0 : 0.0,
                  bottom: index != vehiclesList.length - 1 ? 20.0 : 0.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.brandName ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          vehicle.number ?? '',
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Text(vehicle.fuelType ?? '',
                            style: const TextStyle(
                              fontSize: 15.0,
                            )),
                      ],
                    ),
                  ]),
            );
          },
        );
      },
    );
  }
}
