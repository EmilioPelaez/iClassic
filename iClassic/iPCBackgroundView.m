//
//  iPCBackgroundView.m
//  iClassic
//
//  Created by Emilio Peláez on 09/07/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCBackgroundView.h"

@implementation iPCBackgroundView

-(id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		[self tintColorDidChange];
		[self setAlpha:.1];
	}
	return self;
}

-(void)tintColorDidChange{
	[self setBackgroundColor:self.tintColor];
}

@end
