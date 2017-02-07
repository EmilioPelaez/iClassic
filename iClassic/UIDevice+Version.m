//
//  UIDevice+Version.m
//  iClassic
//
//  Created by Emilio Peláez on 2/6/17.
//  Copyright © 2017 Emilio Peláez. All rights reserved.
//

#import "UIDevice+Version.h"

@implementation UIDevice (Version)

-(BOOL)isiOS10{
	return [[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 10;
}

@end
