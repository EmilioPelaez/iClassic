//
//  iPCDisplayStack.h
//  iPodClassic
//
//  Created by Emilio Peláez on 7/29/10.
//  Copyright 2010 Kernel Panic. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "iPCClickWheel.h"
#import "iPCStatusBar.h"

@class iPCDisplay, iPCNowPlayingDisplay;

@interface iPCDisplayStack : UIViewController <iPCClickWheelDelegate, UINavigationControllerDelegate>{
}

@property(nonatomic, weak) IBOutlet iPCStatusBar *statusBar;

@property(nonatomic, readonly) iPCDisplay *currentDisplay;

@property(nonatomic, strong) iPCDisplay *nowPlayingDisplay;
@property(nonatomic, strong) iPCDisplay *menuDisplay;

@property(nonatomic, strong) UINavigationController *navigationController;

-(void)pushDisplay:(iPCDisplay *)display;
-(void)popDisplay;

//	Returns YES when the nowPlaying display was pushed, and NO when it was already at the top of the stack
-(BOOL)showNowPlaying;

@end
