//
//  iPCBatteryView.m
//  iClassic
//
//  Created by Emilio Peláez on 5/1/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCBatteryView.h"

@implementation iPCBatteryView

+(CGSize)batterySize{
	return CGSizeMake(21, 11);
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if(self){
		[self setBackgroundColor:[UIColor clearColor]];
		
		_batteryLevel = 1;
		_batteryState = UIDeviceBatteryStateUnknown;
		
		[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBattery)
																								 name:UIDeviceBatteryLevelDidChangeNotification
																							 object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBattery)
																								 name:UIDeviceBatteryStateDidChangeNotification
																							 object:nil];
	}
	return self;
}

-(void)updateBattery{
	UIDeviceBatteryState batteryState = [[UIDevice currentDevice] batteryState];
	float batteryLevel = [[UIDevice currentDevice] batteryLevel];
	
	[self setBatteryState:batteryState];
	[self setBatteryLevel:batteryLevel];
}

-(void)drawRect:(CGRect)rect{
	UIBezierPath *batteryBorderPath = UIBezierPath.bezierPath;
	[batteryBorderPath moveToPoint: CGPointMake(23, 3)];
	[batteryBorderPath addLineToPoint: CGPointMake(22, 3)];
	[batteryBorderPath addLineToPoint: CGPointMake(22, 2)];
	[batteryBorderPath addCurveToPoint: CGPointMake(20, 0) controlPoint1: CGPointMake(22, 0.8) controlPoint2: CGPointMake(21.2, 0)];
	[batteryBorderPath addLineToPoint: CGPointMake(2, 0)];
	[batteryBorderPath addCurveToPoint: CGPointMake(0, 2) controlPoint1: CGPointMake(0.8, 0) controlPoint2: CGPointMake(0, 0.8)];
	[batteryBorderPath addLineToPoint: CGPointMake(0, 10)];
	[batteryBorderPath addCurveToPoint: CGPointMake(2, 12) controlPoint1: CGPointMake(0, 11.2) controlPoint2: CGPointMake(0.8, 12)];
	[batteryBorderPath addLineToPoint: CGPointMake(20, 12)];
	[batteryBorderPath addCurveToPoint: CGPointMake(22, 10) controlPoint1: CGPointMake(21.2, 12) controlPoint2: CGPointMake(22, 11.2)];
	[batteryBorderPath addLineToPoint: CGPointMake(22, 9)];
	[batteryBorderPath addLineToPoint: CGPointMake(23, 9)];
	[batteryBorderPath addCurveToPoint: CGPointMake(24, 8) controlPoint1: CGPointMake(23.6, 9) controlPoint2: CGPointMake(24, 8.6)];
	[batteryBorderPath addLineToPoint: CGPointMake(24, 4)];
	[batteryBorderPath addCurveToPoint: CGPointMake(23, 3) controlPoint1: CGPointMake(24, 3.4) controlPoint2: CGPointMake(23.6, 3)];
	[batteryBorderPath closePath];
	[batteryBorderPath moveToPoint: CGPointMake(21, 10)];
	[batteryBorderPath addCurveToPoint: CGPointMake(20, 11) controlPoint1: CGPointMake(21, 10.6) controlPoint2: CGPointMake(20.6, 11)];
	[batteryBorderPath addLineToPoint: CGPointMake(2, 11)];
	[batteryBorderPath addCurveToPoint: CGPointMake(1, 10) controlPoint1: CGPointMake(1.4, 11) controlPoint2: CGPointMake(1, 10.6)];
	[batteryBorderPath addLineToPoint: CGPointMake(1, 2)];
	[batteryBorderPath addCurveToPoint: CGPointMake(2, 1) controlPoint1: CGPointMake(1, 1.4) controlPoint2: CGPointMake(1.4, 1)];
	[batteryBorderPath addLineToPoint: CGPointMake(20, 1)];
	[batteryBorderPath addCurveToPoint: CGPointMake(21, 2) controlPoint1: CGPointMake(20.6, 1) controlPoint2: CGPointMake(21, 1.4)];
	[batteryBorderPath addLineToPoint: CGPointMake(21, 10)];
	[batteryBorderPath closePath];
	[batteryBorderPath moveToPoint: CGPointMake(23, 8)];
	[batteryBorderPath addLineToPoint: CGPointMake(22, 8)];
	[batteryBorderPath addLineToPoint: CGPointMake(22, 4)];
	[batteryBorderPath addLineToPoint: CGPointMake(23, 4)];
	[batteryBorderPath addLineToPoint: CGPointMake(23, 8)];
	[batteryBorderPath closePath];
	batteryBorderPath.miterLimit = 4;
	
	[[UIColor flatBlackColor] setFill];
	[batteryBorderPath fill];
	
	
	UIBezierPath *batteryFillPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(1.5, 1.5, round(19 * self.batteryLevel), 9)
																														 cornerRadius: 1.5];
	if(self.batteryLevel < .2)
		[[UIColor flatRedColor] setFill];
	else
		[[UIColor flatGreenColor] setFill];
	[batteryFillPath fill];
	
	switch (self.batteryState){
		case UIDeviceBatteryStateCharging:{
			UIBezierPath* boltPath = UIBezierPath.bezierPath;
			[boltPath moveToPoint: CGPointMake(13.5, 5.41)];
			[boltPath addLineToPoint: CGPointMake(11.62, 5.41)];
			[boltPath addLineToPoint: CGPointMake(12.43, 2.5)];
			[boltPath addLineToPoint: CGPointMake(9.93, 2.5)];
			[boltPath addLineToPoint: CGPointMake(8.5, 6.86)];
			[boltPath addLineToPoint: CGPointMake(11, 6.86)];
			[boltPath addLineToPoint: CGPointMake(10.38, 10.5)];
			[boltPath addLineToPoint: CGPointMake(13.5, 5.41)];
			[boltPath closePath];
			boltPath.miterLimit = 4;
			
			[[UIColor flatBlackColor] setFill];
			[boltPath fill];
			break;
		}
		case UIDeviceBatteryStateFull:
		case UIDeviceBatteryStateUnplugged:
			break;
		case UIDeviceBatteryStateUnknown:
			break;
	}
	
}

-(void)setBatteryLevel:(float)batteryLevel{
	_batteryLevel = MAX(0, batteryLevel);
	
	[self setNeedsDisplay];
}

-(void)setBatteryState:(UIDeviceBatteryState)batteryState{
	_batteryState = batteryState;
	
	[self setNeedsDisplay];
}

-(void)dealloc{
	[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
