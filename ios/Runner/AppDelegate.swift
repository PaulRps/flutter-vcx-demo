import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        startChannelListeners()
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func startChannelListeners() {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let manager = ChannelManager(Channel.getAll())
        manager.registerAll(controller)
    }
}
