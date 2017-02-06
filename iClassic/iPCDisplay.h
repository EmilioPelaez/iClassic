//
//  iPCDisplay.h
//  iPodClassic
//
//  Created by Emilio Peláez on 7/29/10.
//  Copyright 2010 Kernel Panic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

#import "iPCDisplayStack.h"
#import "iPCStatusBar.h"

typedef enum{
	iPCAnimationDirectionRight,
	iPCAnimationDirectionLeft
}iPCAnimationDirection;

@interface iPCDisplay : UIViewController {
	UIView *loadingView;
	
	MPMusicPlayerController *musicPlayer;
}

@property(retain) NSString *identifier;

@property(nonatomic, weak) iPCDisplayStack *displayStack;

@property(retain) iPCDisplay *parentDisplay;
@property(retain) NSMutableArray *cachedDisplays;

@property NSUInteger cacheSize;

@property(readonly) CGRect standardDisplayFrame;

@property(nonatomic, getter = isShowingLoadingView) BOOL showLoadingView;

-(BOOL)isNecessary;

//Input
-(void)centerButtonPressed;
-(void)receivedOffset:(float)offset;
-(void)receivedFinalOffset:(float)offset;

//Cache Methods
-(iPCDisplay *)displayInCacheForIdentifier:(NSString *)ID;
-(void)cacheDisplay:(iPCDisplay *)display;

//Memory
-(void)memoryWarning;

@end
