//
//  iPCBatteryView.h
//  iClassic
//
//  Created by Emilio Peláez on 5/1/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPCBatteryView : UIView {
}

+(CGSize)batterySize;

@property(nonatomic) float batteryLevel;
@property(nonatomic) UIDeviceBatteryState batteryState;

-(void)updateBattery;

@end
