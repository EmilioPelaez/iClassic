//
//  iPCColorsManager.h
//  iClassic
//
//  Created by Emilio Peláez on 6/9/15.
//  Copyright © 2015 Emilio Peláez. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, iPCTheme) {
	iPCThemeLightFace,
	iPCThemeDarkFace
};

@interface iPCColorsManager : NSObject

+(instancetype)sharedInstance;

@property(nonatomic) iPCTheme theme;

@property(nonatomic) NSInteger themeColorIndex;
@property(nonatomic, readonly) UIColor *themeColor;

@property(nonatomic, readonly) UIColor *faceColor;
@property(nonatomic, readonly) UIColor *backgroundColor;

@property(nonatomic, readonly) NSArray *colorNames;
@property(nonatomic, readonly) NSArray *colors;

@end
