//
//  iPCInfoBar.h
//  iClassic
//
//  Created by Emilio Peláez on 14/07/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	iPCInfoBarStateNormal,
	iPCInfoBarStateVolume,
	iPCInfoBarTracking
} iPCInfoBarState;

@interface iPCInfoBar : UIView

@property(nonatomic) iPCInfoBarState state;

@property(nonatomic) NSTimeInterval currentPlaybackTime;
@property(nonatomic) NSTimeInterval totalPlaybackTime;

@property(nonatomic) float volume;

@end
