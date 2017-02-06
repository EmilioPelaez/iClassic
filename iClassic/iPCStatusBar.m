//
//  iPCStatusBar.m
//  iPodClassic
//
//  Created by Emilio on 17/10/09.
//  Copyright 2009 Kernel Panic. All rights reserved.
//

#define kTimerDuration .35

#import "iPCStatusBar.h"

@interface iPCStatusBar ()

-(void)updateTime;
-(void)titleTimerDone;

@end

@implementation iPCStatusBar

#pragma mark Initialization

-(void)awakeFromNib{
	[super awakeFromNib];
	
	[self setBackgroundColor:[UIColor flatWhiteColorDark]];
	
	[[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
	
	MPMusicPlaybackState playbackState = [[MPMusicPlayerController systemMusicPlayer] playbackState];
	[self setShowPlayIcon:playbackState != MPMusicPlaybackStatePlaying];
	
	formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterNoStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	
	[self updateTime];
	[NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
	
	self.dateLabel.font = self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
	
	[[MPMusicPlayerController systemMusicPlayer] beginGeneratingPlaybackNotifications];
	[[NSNotificationCenter defaultCenter] addObserverForName:MPMusicPlayerControllerPlaybackStateDidChangeNotification
																										object:nil
																										 queue:nil
																								usingBlock:^(NSNotification *note) {
																									MPMusicPlaybackState playbackState = [[MPMusicPlayerController systemMusicPlayer] playbackState];
																									switch(playbackState){
																										case MPMusicPlaybackStateInterrupted:
																										case MPMusicPlaybackStatePaused:
																										case MPMusicPlaybackStateStopped:
																										case MPMusicPlaybackStateSeekingBackward:
																										case MPMusicPlaybackStateSeekingForward:
																											[self setShowPlayIcon:NO];
																											break;
																										case MPMusicPlaybackStatePlaying:
																											[self setShowPlayIcon:YES];
																											break;
																											
																										default:
																											break;
																									}
																								}];
}

#pragma mark Setters

-(void)setTitle:(NSString *)title{
#ifndef Screenshot
	[titleTimer invalidate];
	titleTimer = nil;
	titleTimer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(titleTimerDone) userInfo:nil repeats:NO];
#endif
	
	[self.titleLabel setText:title];
#ifdef Screenshot
	[title setText:@""];
#endif
	
	if([self.titleLabel alpha] == 1.0){
		return;
	}
	
	[UIView animateWithDuration:kTimerDuration animations:^{
		[self.titleLabel setAlpha:1.0];
		[self.dateLabel setAlpha:0.0];
	}];
}

-(void)setShowPlayIcon:(BOOL)showPlayIcon{
	[UIView animateWithDuration:.25 animations:^{
		[self.playingIcon setAlpha:(showPlayIcon)?(1.0):(0.0)];
	}];
}

#pragma mark Updatters

-(void)updateTime{
	[self.dateLabel setText:[formatter stringFromDate:[NSDate date]]];
}

#pragma mark Hide Tiemr

-(void)titleTimerDone{
	[UIView animateWithDuration:kTimerDuration animations:^{
		[self.titleLabel setAlpha:0.0];
		[self.dateLabel setAlpha:1.0];
	}];
	
	titleTimer = nil;
}

@end
