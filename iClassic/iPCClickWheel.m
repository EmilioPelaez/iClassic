//
//  iPCClickWheel.m
//  ClickWheel
//
//  Created by Emilio Peláez on 2/2/11.
//  Copyright 2011 Kernel Panic. All rights reserved.
//

#import "iPCClickWheel.h"
#import <QuartzCore/QuartzCore.h>
#import "CGMath.h"
#import "iPCPlayPauseView.h"
#import "iPCFastForwardView.h"
#import "iPCMenuIconView.h"

typedef enum{
	iPCLocationTypeButton,
	iPCLocationTypeWheel,
	iPCLocationTypeOutside
}iPCLocationType;

typedef enum{
	iPCButtonTop,
	iPCButtonRight,
	iPCButtonBottom,
	iPCButtonLeft,
	iPCButtonCenter,
	iPCButtonNone
}iPCButton;

@interface iPCClickWheel () {
	CGFloat wheelRadius;
	CGFloat wheelRadiusSquared;
	CGFloat buttonRadius;
	CGFloat buttonRadiusSquared;
	
	CGPoint pointOffset;
	
	BOOL tracking;
	BOOL touchMoved;
	
	CGFloat previousAngle;
	
	NSTimer *holdTimer;
	CGPoint touchDownLocation;
	BOOL holding;
	iPCButton buttonHeld;
	
	UIImpactFeedbackGenerator *feedbackGenerator;
}

-(void)initializeView;

-(iPCLocationType)locationTypeForPoint:(CGPoint)point;
-(iPCLocationType)locationTypeForOffsetPoint:(CGPoint)point;

-(iPCButton)buttonForPoint:(CGPoint)point;
-(iPCButton)buttonForOffsetPoint:(CGPoint)point;

-(float)angleOfPoint:(CGPoint)point;
-(float)angleOfOffsetPoint:(CGPoint)point;

-(BOOL)isPointInCenterButton:(CGPoint)point;
-(BOOL)isPointInWheel:(CGPoint)point;

-(BOOL)isOffsetPointInCenterButton:(CGPoint)point;
-(BOOL)isOffsetPointInWheel:(CGPoint)point;

-(CGPoint)offsetPoint:(CGPoint)point;

-(void)holdTimerEnded;
-(void)cancelTimer;

@end

@implementation iPCClickWheel

+(CGSize)clickWheelSize{
	return CGSizeMake(200, 200);
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if(self){
		[self initializeView];
	}
	return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if(self){
		[self initializeView];
	}
	return self;
}

-(void)initializeView{
	[self setBackgroundColor:[UIColor clearColor]];
	
	menu = [[iPCMenuIconView alloc] initWithFrame:CGRectMake(0, 0, 14, 11)];
	prev = [[iPCFastForwardView alloc] initWithFrame:CGRectMake(0, 0, 17, 9)];
	[prev setTransform:CGAffineTransformMakeScale(-1, 1)];
	next = [[iPCFastForwardView alloc] initWithFrame:CGRectMake(0, 0, 17, 9)];
	playpause = [[iPCPlayPauseView alloc] initWithFrame:CGRectMake(0, 0, 17, 9)];
	
	menu.opaque = prev.opaque = next.opaque = playpause.opaque = NO;
	
	[menu setAlpha:.75];
	[prev setAlpha:.75];
	[next setAlpha:.75];
	[playpause setAlpha:.75];
	
	[self addSubview:menu];
	[self addSubview:prev];
	[self addSubview:next];
	[self addSubview:playpause];
	
	feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
	
	self.frame = self.frame;
}

-(void)drawRect:(CGRect)rect{
	CGContextRef c = UIGraphicsGetCurrentContext();
	
	CGContextSetStrokeColorWithColor(c, [self.tintColor CGColor]);
	CGContextSetLineWidth(c, 2);
	
	CGContextStrokeEllipseInRect(c, CGRectMake(1, 1, rect.size.width - 2, rect.size.height - 2));
	CGContextStrokeEllipseInRect(c, CGRectMake(wheelRadius - buttonRadius, wheelRadius - buttonRadius, buttonRadius * 2, buttonRadius * 2));
}

-(void)tintColorDidChange{
	[super tintColorDidChange];
	[self setNeedsDisplay];
}

-(void)layoutSubviews{
	[super layoutSubviews];
	
	CGRect frame = self.frame;
	
	wheelRadius = frame.size.width / 2.0;
	wheelRadiusSquared = wheelRadius * wheelRadius;
	
	buttonRadius = wheelRadius * _buttonRatio;
	buttonRadiusSquared = buttonRadius * buttonRadius;
	
	pointOffset = CGPointMake(wheelRadius, wheelRadius);
	
	[menu setFrame:CGRectMake(floorf((frame.size.width - menu.frame.size.width)/2.0),
														5,
														menu.frame.size.width,
														menu.frame.size.height)];
	
	[prev setFrame:CGRectMake(5,
														floorf((frame.size.height - prev.frame.size.height)/2.0),
														prev.frame.size.width,
														prev.frame.size.height)];
	[next setFrame:CGRectMake(frame.size.width - next.frame.size.width - 5,
														floorf((frame.size.height - next.frame.size.height)/2.0),
														next.frame.size.width,
														next.frame.size.height)];
	
	[playpause setFrame:CGRectMake(floorf((frame.size.width - playpause.frame.size.width)/2.0),
																 frame.size.height - playpause.frame.size.height - 5,
																 playpause.frame.size.width,
																 playpause.frame.size.height)];
}

#pragma mark - Touch

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[feedbackGenerator prepare];
	
	CGPoint location = [[touches anyObject] locationInView:self];
	CGPoint offsetLocation = [self offsetPoint:location];
	touchDownLocation = offsetLocation;
	buttonHeld = iPCButtonNone;
	
	iPCLocationType locationType = [self locationTypeForOffsetPoint:offsetLocation];
	switch (locationType) {
		case iPCLocationTypeButton:
		case iPCLocationTypeOutside:
			tracking = NO;
			buttonHeld = iPCButtonCenter;
			break;
		case iPCLocationTypeWheel:
			tracking = YES;
			previousAngle = [self angleOfOffsetPoint:offsetLocation];
			buttonHeld = [self buttonForOffsetPoint:offsetLocation];
			break;
	}
	
	holding = NO;
	holdTimer = [NSTimer scheduledTimerWithTimeInterval:.45 target:self selector:@selector(holdTimerEnded) userInfo:nil repeats:NO];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	if(holding) return;
	
	CGPoint location = [[touches anyObject] locationInView:self];
	CGPoint offsetLocation = [self offsetPoint:location];
	
	CGFloat movementDistance = CGPointGetMagnitude(CGPointSubstract(offsetLocation, touchDownLocation));
	if(!touchMoved && movementDistance < 5) return;
	
	[self cancelTimer];
	touchMoved = YES;
	
	iPCLocationType locationType = [self locationTypeForOffsetPoint:offsetLocation];
	switch (locationType) {
		case iPCLocationTypeButton:
		case iPCLocationTypeOutside:
			[self.delegate finalMovementWithOffset:0];
			tracking = NO;
			break;
		case iPCLocationTypeWheel:
			if(tracking){
				CGFloat newAngle = [self angleOfOffsetPoint:offsetLocation];
				CGFloat difference = previousAngle - newAngle;
				if(fabs(difference) < M_PI) [self.delegate movementWithOffset:difference];
				previousAngle = newAngle;
			}else{
				tracking = YES;
				previousAngle = [self angleOfOffsetPoint:offsetLocation];
			}
			break;
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	if(touchMoved){
			[self cancelTimer];
			
			CGPoint location = [[touches anyObject] locationInView:self];
			CGPoint offsetLocation = [self offsetPoint:location];
			
			iPCLocationType locationType = [self locationTypeForOffsetPoint:offsetLocation];
			switch (locationType) {
				case iPCLocationTypeButton:
				case iPCLocationTypeOutside:
					tracking = NO;
					break;
				case iPCLocationTypeWheel:
					if(tracking){
						CGFloat newAngle = [self angleOfOffsetPoint:offsetLocation];
						CGFloat difference = previousAngle - newAngle;
						if(fabs(difference) < M_PI) [self.delegate finalMovementWithOffset:difference];
						else [self.delegate finalMovementWithOffset:0];
						previousAngle = newAngle;
					}else{
						tracking = YES;
						previousAngle = [self angleOfOffsetPoint:offsetLocation];
					}
					break;
			}
	}else{
		CGPoint location = [[touches anyObject] locationInView:self];
		
		iPCButtonAction action = holding ? iPCButtonActionEndHold : iPCButtonActionTap;
		[self cancelTimer];
		
		if(!holding)
			[feedbackGenerator impactOccurred];
		
		iPCLocationType locationType = [self locationTypeForPoint:location];
		switch (locationType) {
			case iPCLocationTypeButton:
				[self.delegate centerAction:action];
				break;
			case iPCLocationTypeWheel:{
				iPCButton button = [self buttonForPoint:location];
				switch (button) {
					case iPCButtonTop:
						[self.delegate topAction:action];
						break;
					case iPCButtonRight:
						[self.musicDelegate rightAction:action];
						break;
					case iPCButtonBottom:
						[self.musicDelegate bottomAction:action];
						break;
					case iPCButtonLeft:
						[self.musicDelegate leftAction:action];
						break;
					case iPCButtonCenter:
					case iPCButtonNone:
						break;
				}
				break;
			}
			case iPCLocationTypeOutside:
				break;
		}
	}
	
	holding = NO;
	[self touchesCancelled:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
	touchMoved = NO;
	tracking = NO;
}

#pragma mark - Class Methods

-(iPCLocationType)locationTypeForPoint:(CGPoint)point{
	CGPoint pointAfterOffset = [self offsetPoint:point];
	
	if([self isOffsetPointInCenterButton:pointAfterOffset]) return iPCLocationTypeButton;
	else if([self isOffsetPointInWheel:pointAfterOffset]) return iPCLocationTypeWheel;
	
	return iPCLocationTypeOutside;
}

-(iPCLocationType)locationTypeForOffsetPoint:(CGPoint)point{
	if([self isOffsetPointInCenterButton:point]) return iPCLocationTypeButton;
	else if([self isOffsetPointInWheel:point]) return iPCLocationTypeWheel;
	
	return iPCLocationTypeOutside;
}

-(iPCButton)buttonForPoint:(CGPoint)point{
	CGPoint pointAfterOffset = [self offsetPoint:point];
	return [self buttonForOffsetPoint:pointAfterOffset];
}

-(iPCButton)buttonForOffsetPoint:(CGPoint)point{
	if(point.x > point.y){
		if(-point.x > point.y) return iPCButtonTop;
		else return iPCButtonRight;
	}else{
		if(-point.x < point.y) return iPCButtonBottom;
		else return iPCButtonLeft;
	}
	
	return iPCButtonNone;
}

-(float)angleOfPoint:(CGPoint)point{
	CGPoint pointAfterOffset = [self offsetPoint:point];
	return [self angleOfOffsetPoint:pointAfterOffset];
}

-(float)angleOfOffsetPoint:(CGPoint)point{
	float angle = atan2f(point.x, point.y);
	/*if(angle < 0){
		angle = angle + 2 * M_PI;
	}*/
	
	return angle;
}

-(BOOL)isPointInCenterButton:(CGPoint)point{
	CGPoint pointAfterOffset = [self offsetPoint:point];
	return [self isOffsetPointInCenterButton:pointAfterOffset];
}

-(BOOL)isPointInWheel:(CGPoint)point{
	CGPoint pointAfterOffset = [self offsetPoint:point];
	return [self isOffsetPointInWheel:pointAfterOffset];
}

-(BOOL)isOffsetPointInCenterButton:(CGPoint)point{
	CGFloat magnitude = point.x * point.x + point.y * point.y;
	return magnitude <= buttonRadiusSquared;
}

-(BOOL)isOffsetPointInWheel:(CGPoint)point{
	CGFloat magnitude = point.x * point.x + point.y * point.y;
	return magnitude <= wheelRadiusSquared;
}

-(CGPoint)offsetPoint:(CGPoint)point{
	return CGPointSubstract(point, pointOffset);
}

-(void)holdTimerEnded{
	holdTimer = nil;
	
	if(buttonHeld == iPCButtonNone) return;
	holding = YES;
	
	[feedbackGenerator impactOccurred];
	
	switch (buttonHeld) {
		case iPCButtonTop:		[self.delegate topAction:iPCButtonActionBeginHold];
			break;
		case iPCButtonRight:	[self.musicDelegate rightAction:iPCButtonActionBeginHold];
			break;
		case iPCButtonBottom:	[self.musicDelegate bottomAction:iPCButtonActionBeginHold];
			break;
		case iPCButtonLeft:		[self.musicDelegate leftAction:iPCButtonActionBeginHold];
			break;
		case iPCButtonCenter:	[self.delegate centerAction:iPCButtonActionBeginHold];
			break;
		case iPCButtonNone:
			break;
	}
}

-(void)cancelTimer{
	[holdTimer invalidate];
	holdTimer = nil;
}

#pragma mark - Getters/Setters

-(void)setButtonRatio:(CGFloat)buttonRatio{
	_buttonRatio = buttonRatio;
	
	buttonRadius = wheelRadius * _buttonRatio;
	buttonRadiusSquared = buttonRadius * buttonRadius;
	
	[self layoutSubviews];
}

@end
