package com.githubpatrickz98.simple_audio_player;

import android.media.MediaPlayer;
import android.util.Log;

import androidx.annotation.NonNull;

import java.io.IOException;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * SimpleAudioPlayerPlugin
 */
public class SimpleAudioPlayerPlugin implements FlutterPlugin, MethodCallHandler {
    static final String LOG_TAG = "SimpleAudioPlayerPlugin";

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "simple_audio_player");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
            return;
        }

        if (call.method.equals("play")) {
            Object obj = call.argument("url");

            if (obj instanceof String) {
                playUrl((String) obj);
            }

            return;
        }

        result.notImplemented();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    private void playUrl(String url) {

        Log.d(LOG_TAG, "playUrl: url=" + url);

        if (url == null) {
            return;
        }

        MediaPlayer mp = new MediaPlayer();
        try {
            mp.setDataSource(url);
            mp.prepare();
            mp.start();
        } catch (IOException exc) {
            Log.d(LOG_TAG, "playSomething: failed");
            exc.printStackTrace();
        }
    }
}
