//
//  iPCMusicPlayer.h
//  iClassic
//
//  Created by Emilio Peláez on 6/10/15.
//  Copyright © 2015 Emilio Peláez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "iPCClickWheel.h"

@interface iPCMusicPlayer : NSObject <iPCClickWheelMusicDelegate>

+(instancetype)sharedInstance;

@end
