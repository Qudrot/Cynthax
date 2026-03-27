# Interswitch Mobile SDK Proguard Rules
-keep class com.interswitchng.isw_mobile_sdk.** { *; }
-keep class com.interswitchng.isw_mobile_payment_sdk.** { *; }

# General Flutter Proguard Rules (often handled by Flutter but good to have)
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
