#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"
static NSString * const PREF_PATH = @"/var/mobile/Library/Preferences/jp.r-plus.Sleipnizer.plist";
static NSString * const kSwitchKey = @"OpenTabBackgroundEnabled";

@interface NukeSwitch : NSObject <FSSwitchDataSource>
@end

@implementation NukeSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:PREF_PATH];
    id existOpenTabBackground = [dict objectForKey:kSwitchKey];
    BOOL isOpenTabBackgroundEnabled = existOpenTabBackground ? [existOpenTabBackground boolValue] : YES;
    return isOpenTabBackgroundEnabled ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:PREF_PATH];
    NSMutableDictionary *mutableDict = dict ? [[dict mutableCopy] autorelease] : [NSMutableDictionary dictionary];
    switch (newState) {
        case FSSwitchStateIndeterminate:
            return;
        case FSSwitchStateOn:
            [mutableDict setValue:@YES forKey:kSwitchKey];
            system("touch /var/mobile/Library/Preferences/com.deneb.nuke.flagfile");
            break;
        case FSSwitchStateOff:
	    system("rm /var/mobile/Library/Preferences/com.deneb.nuke.flagfile");
            [mutableDict setValue:@NO forKey:kSwitchKey];
            break;
    }
    [mutableDict writeToFile:PREF_PATH atomically:YES];
 }

@end
