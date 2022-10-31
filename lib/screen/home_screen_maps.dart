import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:minggu_11_new/services/firebase_auth_services.dart';
// import 'package:android_intent_plus/android_intent.dart';
// import 'package:platform/platform.dart';

class Mymaps extends StatefulWidget {
  const Mymaps({Key? key}) : super(key: key);

  @override
  State<Mymaps> createState() => _MymapsState();
}

class _MymapsState extends State<Mymaps> {
  int _counter = 0;
  String location = 'belum mendapatkan lat dan long, silahkan tekan button ';
  String address = 'Mencari lokasi...';
  late String getValue;

  // buat future
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service not enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    // permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission denied forever, we cannot acces');
    }
// continue accesing the position of device
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // getAddres
  Future<void> getAddressFromLongLat(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    setState(() {
      address =
          '${place.street}, ${place.subLocality},${place.postalCode},${place.country}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cek posisi sekarang"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'koordinat point',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              location,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Address',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text('${address}'),
            ElevatedButton(
                onPressed: () async {
                  Position position = await _getGeoLocationPosition();
                  setState(() {
                    location = '${position.latitude},${position.longitude}';
                  });
                  getAddressFromLongLat(position);
                },
                child: Text('Get Koordinat')),
            SizedBox(
              height: 10.0,
            ),
            // TextFormField(
            //   controller: _pencarian,
            //   autofocus: false,
            //   obscureText: false,
            //   decoration: InputDecoration(
            //     hintText: 'lokasi tujuan anda',
            //     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            //     border:
            //         OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            //   ),
            // ),

            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 16.0),
            //   child: Material(
            //     borderRadius: BorderRadius.circular(30.0),
            //     // shadowColor: Colors.lightBlueAccent.shade100,
            //     elevation: 5.0,
            //     child: MaterialButton(
            //       minWidth: 200.0,
            //       height: 42.0,
            //       onPressed: () {
            //         final intent = AndroidIntent(
            //             action: 'action_view',
            //             data: 'https://www.google.com/maps',
            //             package: 'com.google.android.apps.maps');
            //         intent.launch();
            //       },
            //       color: Colors.green,
            //       child: Text('cari alamat di maps',
            //           style: TextStyle(color: Colors.white)),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final intent = AndroidIntent(
              action: 'action_view',
              data: 'https://www.google.com/maps',
              package: 'com.google.android.apps.maps');
          intent.launch();
        },
        child: Icon(Icons.location_on),
      ),
    );
  }
}
