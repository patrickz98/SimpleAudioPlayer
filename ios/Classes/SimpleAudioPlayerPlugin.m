#import "SimpleAudioPlayerPlugin.h"
#if __has_include(<simple_audio_player/simple_audio_player-Swift.h>)
#import <simple_audio_player/simple_audio_player-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "simple_audio_player-Swift.h"
#endif

@implementation SimpleAudioPlayerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSimpleAudioPlayerPlugin registerWithRegistrar:registrar];
}
@end
