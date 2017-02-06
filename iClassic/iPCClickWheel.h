//
//  iPCClickWheel.h
//  iClassic
//
//  Created by Emilio Peláez on 1/13/11.
//  Copyright 2011 Kernel Panic. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol iPCClickWheelMusicDelegate;
@protocol iPCClickWheelDelegate;

typedef enum{
	iPCButtonActionTap,
	iPCButtonActionBeginHold,
	iPCButtonActionEndHold
}iPCButtonAction;

IB_DESIGNABLE
@interface iPCClickWheel : UIView {
	UIView *menu;
	UIView *prev;
	UIView *next;
	UIView *playpause;
}

@property(nonatomic, assign) id <iPCClickWheelDelegate> delegate;
@property(nonatomic, assign) id <iPCClickWheelMusicDelegate> musicDelegate;

@property(nonatomic) IBInspectable CGFloat buttonRatio;

+(CGSize)clickWheelSize;

@end

@protocol iPCClickWheelMusicDelegate <NSObject>

-(void)bottomAction:(iPCButtonAction)action;
-(void)leftAction:(iPCButtonAction)action;
-(void)rightAction:(iPCButtonAction)action;

@end

@protocol iPCClickWheelDelegate <NSObject>

-(void)topAction:(iPCButtonAction)action;
-(void)centerAction:(iPCButtonAction)action;
-(void)movementWithOffset:(CGFloat)offset;
-(void)finalMovementWithOffset:(CGFloat)offset;

@end