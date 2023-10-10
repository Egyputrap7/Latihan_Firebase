import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocation extends StatefulWidget {

  // Konstruktor untuk widget CurrentLocation
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {

  // Objek GoogleMapController untuk mengendalikan peta Google Maps
  late GoogleMapController googleMapController;
  
  // Set marker untuk menampilkan penanda lokasi saat ini di peta
  Set <Marker> markers ={};
  

  // Posisi awal kamera saat peta pertama kali dimuat
  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(-7.6665, 110.3221),zoom: 16);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User current Location'),
        centerTitle: true,
      ),
      body: GoogleMap(initialCameraPosition: initialCameraPosition,
      markers: markers,
      zoomControlsEnabled: false,
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller){
        googleMapController = controller;
      },
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () async{

        // Mendapatkan posisi geografis pengguna saat tombol ditekan
        Position position = await _determinePosition();
        
        // Menganimasikan kamera untuk menunjukkan posisi saat ini
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target:LatLng(position.latitude,position.longitude),
            zoom: 16
          )));

          // Menghapus semua marker yang ada dan menambahkan marker baru untuk posisi saat ini
          markers.clear();

          markers.add(Marker(markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude)));

          // Memanggil setState untuk memperbarui tampilan peta
          setState(() {
            
          });

      },
      label: const Text('Curretn Location'),
      icon: const Icon(Icons.location_history),
      ),
    );
  }


  // Metode untuk menentukan posisi geografis pengguna
  Future<Position> _determinePosition() async {

    bool serviceEnable;
    LocationPermission permission;

    // Mengecek apakah layanan lokasi diaktifkan pada perangkat
    serviceEnable = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnable){
      return Future.error('Location service are disable');
    }

    // Mengecek izin lokasi pengguna
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied){

      // Meminta izin lokasi jika belum diberikan
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied){
        return Future.error("Location Permision denied");
      }
    }

    if (permission == LocationPermission.deniedForever){
      return Future.error('Location permisions are permanently denied');
    }

    // Mendapatkan posisi geografis pengguna saat ini
    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

}