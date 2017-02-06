//
//  iPCStatusBar.h
//  iPodClassic
//
//  Created by Emilio on 17/10/09.
//  Copyright 2009 Kernel Panic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

#import "iPCBatteryView.h"

@interface iPCStatusBar : UIView {
	NSDateFormatter *formatter;
	
	NSTimer *titleTimer;
	
	BOOL titleShown;
}

@property(nonatomic, weak) IBOutlet UILabel *dateLabel;
@property(nonatomic, weak) IBOutlet UILabel *titleLabel;

@property(nonatomic, weak) IBOutlet UIView *playingIcon;

@property(nonatomic, copy) NSString *title;
@property(nonatomic,getter=isShowingPlayIcon) BOOL showPlayIcon;

@end