import UIKit
import Flutter
import GoogleMaps // import

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // API key
    GMSServices.provideAPIKey("AIzaSyDHpVrD6teYpiVmaj1C76lHeyIIWJQsZPw")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
