//
//  iPCView.m
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCView.h"
#import "iPCNowPlayingDisplay.h"
#import "iPCColorsManager.h"

@interface iPCView ()

-(void)initializeView;

-(void)updateBackgroundColor;

@end

@implementation iPCView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if(self){
		[self initializeView];
	}
	return self;
}

-(id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if(self){
		[self initializeView];
	}
	return self;
}

-(void)initializeView{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBackgroundColor) name:@"UpdateTheme" object:nil];
	[self updateBackgroundColor];
}

-(void)updateBackgroundColor{
	[self setBackgroundColor:[[iPCColorsManager sharedInstance] faceColor]];
}

-(void)layoutSubviews{
	[super layoutSubviews];
	
	CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
	[self.layer setCornerRadius:screenWidth / 20];
}

@end
