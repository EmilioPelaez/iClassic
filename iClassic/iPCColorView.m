//
//  iPCColorView.m
//  iClassic
//
//  Created by Emilio Peláez on 09/07/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "iPCColorView.h"

@implementation iPCColorView

-(id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		[self tintColorDidChange];
	}
	return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if(self){
		[self tintColorDidChange];
	}
	return self;
}

-(void)tintColorDidChange{
	[self setBackgroundColor:self.tintColor];
}

@end
