//
//  iPCColorsManager.m
//  iClassic
//
//  Created by Emilio Peláez on 6/9/15.
//  Copyright © 2015 Emilio Peláez. All rights reserved.
//

#import "iPCColorsManager.h"
#import "UIColor+Chameleon.h"
#import "iPCAppDelegate.h"

@interface iPCColorsManager ()

@property(nonatomic, readonly) NSArray *lightColors;
@property(nonatomic, readonly) NSArray *darkColors;

@end

@implementation iPCColorsManager

+(instancetype)sharedInstance{
	static id instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [self new];
	});
	return instance;
}

-(instancetype)init{
	self = [super init];
	if(self){
		
		_colorNames = @[@"Gray",
										@"Blue",
										@"Coffee",
										@"Forest Green",
										@"Lime",
										@"Magenta",
										@"Mint",
										@"Orange",
										@"Pink",
										@"Purple",
										@"Red",
										@"Sky Blue",
										@"Teal",
										@"Watermelon",
										@"Yellow"];
		
		_lightColors = @[[UIColor flatGrayColor],
										 [UIColor flatBlueColor],
										 [UIColor flatCoffeeColor],
										 [UIColor flatForestGreenColor],
										 [UIColor flatLimeColor],
										 [UIColor flatMagentaColor],
										 [UIColor flatMintColor],
										 [UIColor flatOrangeColor],
										 [UIColor flatPinkColor],
										 [UIColor flatPurpleColor],
										 [UIColor flatRedColor],
										 [UIColor flatSkyBlueColor],
										 [UIColor flatTealColor],
										 [UIColor flatWatermelonColor],
										 [UIColor flatYellowColor]];
		
		_darkColors = @[[UIColor flatGrayColorDark],
										[UIColor flatBlueColorDark],
										[UIColor flatCoffeeColorDark],
										[UIColor flatForestGreenColorDark],
										
										[UIColor flatLimeColorDark],
										[UIColor flatMagentaColorDark],
										[UIColor flatMintColorDark],
										[UIColor flatOrangeColorDark],
										[UIColor flatPinkColorDark],
										[UIColor flatPurpleColorDark],
										[UIColor flatRedColorDark],
										[UIColor flatSkyBlueColorDark],
										[UIColor flatTealColorDark],
										[UIColor flatWatermelonColorDark],
										[UIColor flatYellowColorDark]];
		
		self.themeColorIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"ThemeColorIndex"];
		self.theme = [[NSUserDefaults standardUserDefaults] integerForKey:@"Theme"];
	}
	return self;
}

-(void)setTheme:(iPCTheme)theme{
	_theme = theme;
	switch (theme) {
		case iPCThemeLightFace:
			_faceColor = [UIColor flatWhiteColor];
			_backgroundColor = [UIColor flatBlackColor];
			break;
		case iPCThemeDarkFace:
			_faceColor = [UIColor flatBlackColor];
			_backgroundColor = [UIColor flatWhiteColorDark];
			break;
	}
	
	self.themeColorIndex = self.themeColorIndex;
	
	[[NSUserDefaults standardUserDefaults] setInteger:theme forKey:@"Theme"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateTheme" object:nil];
}

-(void)setThemeColorIndex:(NSInteger)themeColorIndex{
	_themeColorIndex = themeColorIndex;
	
	[[NSUserDefaults standardUserDefaults] setInteger:themeColorIndex forKey:@"ThemeColorIndex"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateColor" object:nil];
	
	iPCAppDelegate *delegate = (iPCAppDelegate *)[[UIApplication sharedApplication] delegate];
	UIWindow *window = [delegate window];
	[window setTintColor:self.themeColor];
}

-(UIColor *)themeColor{
	return self.colors[self.themeColorIndex];
}

-(NSArray *)colors{
	NSArray *colorsArray;
	switch (self.theme) {
		case iPCThemeLightFace:
			colorsArray = self.darkColors;
			break;
		case iPCThemeDarkFace:
			colorsArray = self.lightColors;
			break;
	}
	return colorsArray;
}

@end
