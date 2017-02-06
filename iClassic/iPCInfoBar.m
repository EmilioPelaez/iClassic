//
//  iPCInfoBar.m
//  iClassic
//
//  Created by Emilio Peláez on 14/07/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCInfoBar.h"

#import "iPCColorView.h"
#import "iPCColorLabel.h"

@interface iPCInfoBar (){
	UIView *background;
	
	UILabel *timeCurrentLabel;
	UILabel *timeTotalLabel;
	iPCColorView *timeFill;
	iPCColorView *timeTracker;
	
	iPCColorView *volumeFill;
	UIImageView *volumeLeft;
	UIImageView *volumeRight;
}

-(NSString *)timeStringFromTimeInterval:(NSTimeInterval)interval;

@end

@implementation iPCInfoBar

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if (self){
		timeCurrentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[timeCurrentLabel setText:@"0:00"];
		[timeCurrentLabel setFont:[UIFont boldSystemFontOfSize:10]];
		[timeCurrentLabel setTextAlignment:NSTextAlignmentRight];
		
		timeTotalLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[timeTotalLabel setText:@"0:00"];
		[timeTotalLabel setFont:[UIFont boldSystemFontOfSize:10]];
		
		background = [[UIView alloc] initWithFrame:CGRectZero];
		[background setBackgroundColor:[UIColor colorWithWhite:.9 alpha:1]];
		
		timeFill = [[iPCColorView alloc] initWithFrame:background.frame];
		
		[self addSubview:background];
		[self addSubview:timeFill];
		
		[self addSubview:timeCurrentLabel];
		[self addSubview:timeTotalLabel];
	}
	return self;
}

-(void)setCurrentPlaybackTime:(NSTimeInterval)currentPlaybackTime{
	_currentPlaybackTime = currentPlaybackTime;
	
	[timeCurrentLabel setText:[self timeStringFromTimeInterval:currentPlaybackTime]];
	
	[self layoutSubviews];
}

-(void)setTotalPlaybackTime:(NSTimeInterval)totalPlaybackTime{
	_totalPlaybackTime = totalPlaybackTime;
	
	[timeTotalLabel setText:[self timeStringFromTimeInterval:totalPlaybackTime]];
}

-(void)layoutSubviews{
	[super layoutSubviews];
	
	timeCurrentLabel.frame = CGRectMake(0, 0, 30, self.frame.size.height);
	timeTotalLabel.frame = CGRectMake(self.frame.size.width - 30, 0, 30, self.frame.size.height);
	
	background.frame = CGRectMake(timeCurrentLabel.frame.size.width + 3,
																(self.frame.size.height - 14)/2,
																timeTotalLabel.frame.origin.x - (timeCurrentLabel.frame.size.width + 3 + 3),
																14);
	
	CGFloat percentagePlayed = self.currentPlaybackTime / MAX(1, self.totalPlaybackTime);
	CGRect frame = background.frame;
	frame.size.width = background.frame.size.width * percentagePlayed;
	[timeFill setFrame:frame];
}

-(NSString *)timeStringFromTimeInterval:(NSTimeInterval)interval{
	interval = MAX(interval, 0);
	
	int rawSeconds = (int)interval;
	int minutes = floorf(interval/60.0);
	int seconds = rawSeconds % 60;
	
	return [NSString stringWithFormat:@"%i:%@%i", minutes, seconds < 10 ? @"0": @"", seconds];
}

@end
