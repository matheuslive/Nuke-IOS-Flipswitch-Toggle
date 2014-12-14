#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"
static NSString * const FLAG_PATH = @"/var/mobile/Library/Preferences/com.deneb.nuke.plist";


@interface NukeSwitch : NSObject <FSSwitchDataSource>
@end

@implementation NukeSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier{

        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:FLAG_PATH]){
                return FSSwitchStateOn;
        }
        else{
        return FSSwitchStateOff;
        }

}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
        if (newState == FSSwitchStateOn)
        {
                system("touch /var/mobile/Library/Preferences/com.deneb.nuke.plist");
                return;
        }
        else
        {
                system("rm /var/mobile/Library/Preferences/com.deneb.nuke.plist");
                return;
        }
}

@end
