import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:isw_mobile_sdk/isw_mobile_sdk.dart';
import 'package:isw_mobile_sdk/models/isw_mobile_sdk_payment_info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_colors.dart';
import '../../../home/presentation/pages/route_channel_screen.dart';
import '../bloc/trip_bloc.dart';
import '../bloc/trip_event.dart';
import '../bloc/trip_state.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';


// ... [Existing Imports]

class ActiveRideScreen extends StatefulWidget {
  const ActiveRideScreen({super.key});

  @override
  State<ActiveRideScreen> createState() => _ActiveRideScreenState();
}

class _ActiveRideScreenState extends State<ActiveRideScreen> {
  // ... [Existing Methods]

  @override
  Widget build(BuildContext context) {
    return BlocListener<TripBloc, TripState>(
      listener: (context, state) {
        if (state is TripLoading) {
          // Loading Dialog
        } else if (state is PaymentSuccess) {
          Navigator.pop(context);
        } else if (state is TripError) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: AppColors.professionalWhite.withOpacity(0.9),
          title: const Text('En Route'),
        ),
        body: const Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(6.45, 3.4), zoom: 14),
            ),
          ],
        ),
      ), // Added missing closing bracket for Scaffold
    ); // Added missing closing parenthesis for BlocListener
  }
}