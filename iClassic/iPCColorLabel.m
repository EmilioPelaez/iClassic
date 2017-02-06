//
//  iPCColorLabel.m
//  iClassic
//
//  Created by Emilio Peláez on 14/07/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCColorLabel.h"

@implementation iPCColorLabel

-(id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		[self tintColorDidChange];
	}
	return self;
}

-(void)tintColorDidChange{
	[super tintColorDidChange];
	
	[self setTextColor:self.tintColor];
}

@end
