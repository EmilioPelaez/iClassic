//
//  iPCMenuDisplay.h
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCTableDisplay.h"

#import "iPCDisplayStack.h"

@interface iPCMenuDisplay : iPCTableDisplay {
	NSArray *imageNames;
}

@property(nonatomic, readonly) NSArray *titles;

@end
