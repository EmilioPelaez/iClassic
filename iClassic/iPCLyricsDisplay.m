//
//  iPCLyricsDisplay.m
//  iClassic
//
//  Created by Emilio Peláez on 5/4/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCLyricsDisplay.h"

@implementation iPCLyricsDisplay

-(void)viewDidLoad{
	[super viewDidLoad];
	
	self.lyricsText = self.lyricsText;
}

-(void)setLyricsText:(NSString *)text{
	self.lyricsLabel.text = text;
}

-(NSString *)lyricsText{
	return self.lyricsLabel.text;
}

-(void)centerButtonPressed{
	[self.displayStack popDisplay];
}

-(void)receivedOffset:(float)offset{
	CGFloat newOffsetY = self.scrollView.contentOffset.y + offset * 15;
	newOffsetY = MIN(newOffsetY, self.scrollView.contentSize.height - self.scrollView.frame.size.height);
	newOffsetY = MAX(newOffsetY, 0);
	[self.scrollView setContentOffset:CGPointMake(0, newOffsetY)];
	[self.scrollView flashScrollIndicators];
}

@end
