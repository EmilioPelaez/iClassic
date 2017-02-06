//
//  iPCNowPlayingDisplay.h
//  iPodClassic
//
//  Created by Emilio Peláez on 8/28/10.
//  Copyright 2010 Kernel Panic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

#import "MarqueeLabel.h"

#import "iPCDisplay.h"
#import "iPCClickWheel.h"
#import "iPCArtworkView.h"
#import "iPCInfoBar.h"

@interface iPCNowPlayingDisplay : iPCDisplay{
	UIImage *artworkPlaceholder;
	
	NSTimer *songPlaybackTime;
	NSTimer *barTimer;
	NSTimer *seekingTimer;
	
	float totalTime;
}

@property(nonatomic, strong) MPMediaItem *nowPlayingItem;

@property(nonatomic, weak) IBOutlet MarqueeLabel *songNameLabel;
@property(nonatomic, weak) IBOutlet MarqueeLabel *artistLabel;
@property(nonatomic, weak) IBOutlet MarqueeLabel *albumLabel;
@property(nonatomic, weak) IBOutlet UILabel *starsLabel;
@property(nonatomic, weak) IBOutlet UILabel *numberLabel;

@property(nonatomic, weak) IBOutlet UIImageView *artworkImageView;

@property(nonatomic, weak) IBOutlet UIImageView *shuffleImage;
@property(nonatomic, weak) IBOutlet UIImageView *repeatImage;

@property(nonatomic, weak) IBOutlet iPCInfoBar *infoBar;

-(void)updateSong;
-(void)updateShuffleRepeatIcons;

-(void)updateInfoBar;

-(void)didBeginSeeking;
-(void)didEndSeeking;

@end
