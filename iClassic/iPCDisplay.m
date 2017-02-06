//
//  iPCDisplay.m
//  iPodClassic
//
//  Created by Emilio Peláez on 7/29/10.
//  Copyright 2010 Kernel Panic. All rights reserved.
//

#import "iPCDisplay.h"

@implementation iPCDisplay

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if(self){
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
		_cachedDisplays = [[NSMutableArray alloc] init];
		
		[self setCacheSize:5];
		
		musicPlayer = [MPMusicPlayerController systemMusicPlayer];
	}
	return self;
}

-(BOOL)isNecessary{
	if(![self.cachedDisplays count] == 0){
		return self.navigationController != nil;
	}
	__block BOOL necessary = NO;
	[self.cachedDisplays enumerateObjectsUsingBlock:^(iPCDisplay *obj, NSUInteger idx, BOOL *stop) {
		if([obj isNecessary]){
			necessary = YES;
			*stop = YES;
		}
	}];

	return necessary;
}

#pragma mark Input
-(void)centerButtonPressed{
	
}

-(void)receivedOffset:(float)offset{
	
}

-(void)receivedFinalOffset:(float)offset{
	if(offset != 0)
		[self receivedOffset:offset];
}

#pragma mark Cache
-(iPCDisplay *)displayInCacheForIdentifier:(NSString *)ID{
	for(iPCDisplay *display in _cachedDisplays)
		if([[display identifier] isEqualToString:ID])
			return display;
	return nil;
}

-(void)cacheDisplay:(iPCDisplay *)display{
	if(![_cachedDisplays containsObject:display]) [_cachedDisplays addObject:display];
	if([_cachedDisplays count] > _cacheSize) [_cachedDisplays removeObjectAtIndex:0];
}

#pragma mark Memory
-(void)memoryWarning{
	for(NSInteger i = [_cachedDisplays count] - 1; i >= 0; i++)
		if(![[_cachedDisplays objectAtIndex:i] isNecessary]) [_cachedDisplays removeObjectAtIndex:i];
}

-(void)dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
