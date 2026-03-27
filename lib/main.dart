import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:isw_mobile_sdk/isw_mobile_sdk.dart';
import 'package:isw_mobile_sdk/models/isw_mobile_sdk_sdk_config.dart';
import 'core/app_theme.dart';
import 'features/auth/data/repositories/mock_auth_repository.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  
  String merchantCode = dotenv.env['ISW_MERCHANT_CODE'] ?? 'MX276440';
  String payItemId = dotenv.env['ISW_PAY_ITEM_ID'] ?? 'Default_Payable_MX276440';
  
  if (!kIsWeb) {
    // Initialize with IswSdkConfig mapping standard interswitch parameters
    var config = IswSdkConfig(merchantCode, "", payItemId, "566");
    await IswMobileSdk.initialize(config, Environment.TEST);
  }

  final authRepository = MockAuthRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthBloc(authRepository: authRepository)..add(AuthCheckRequested()),
      child: const NextStopApp(),
    ),
  );
}

class NextStopApp extends StatelessWidget {
  const NextStopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NextStop',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
