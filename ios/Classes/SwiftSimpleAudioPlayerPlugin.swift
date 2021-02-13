import Flutter
import UIKit

import AVFoundation


public class SwiftSimpleAudioPlayerPlugin: NSObject, FlutterPlugin {
    var player: AVPlayer!

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "simple_audio_player", binaryMessenger: registrar.messenger())
        let instance = SwiftSimpleAudioPlayerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        if call.method == "getPlatformVersion" {
            result("iOS " + UIDevice.current.systemVersion)
            return
        }

        if call.method == "play" {
            guard let resultNew = call.arguments as? [String:Any] else {
                print("args seem to miss")
                return
            }

            let url = resultNew["url"] as! String

            playUrl(url)

            return
        }
    }

    public func playUrl(_ url: String) {
        print("playUrl: url=\(url)")

        if url == "" {
            return
        }

        guard let nsurl = URL.init(string: url) else {
            print("error converting '\(url)' to url")
            return
        }

        do {
            let playerItem = AVPlayerItem.init(url: nsurl)
            player = AVPlayer.init(playerItem: playerItem)
            player.volume = 1.0
            player.play()
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}