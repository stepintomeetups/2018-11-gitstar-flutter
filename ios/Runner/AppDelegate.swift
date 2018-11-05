import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  var oauthResult: FlutterResult?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
    let authChannel = FlutterMethodChannel.init(name: "viktor.simko.gitstar/auth",
                                                   binaryMessenger: controller);

    authChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "doGitHubAuth" {
        self.oauthResult = result
        UIApplication.shared.openURL(URL(string: "https://github.com/login/oauth/authorize?client_id=b8ed659f28e36384792d&scope=public_repo")!)
      }
    });

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
    let code = components?.queryItems?.first(where: { $0.name == "code" })?.value
    oauthResult?(code!)
    return true
  }
}
