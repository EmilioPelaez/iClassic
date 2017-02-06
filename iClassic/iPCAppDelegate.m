//
//  iPCAppDelegate.m
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCAppDelegate.h"
#import "iPCMainViewController.h"

@implementation iPCAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
	[application setStatusBarHidden:YES];
	
	[iPCColorsManager sharedInstance];
	
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
	UIViewController *mainController = [storyboard instantiateViewControllerWithIdentifier:@"Player Controller"];;
	
	if([MPMediaLibrary authorizationStatus] == MPMediaLibraryAuthorizationStatusAuthorized) {
		self.window.rootViewController = mainController;
	} else {
		[MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
			dispatch_sync(dispatch_get_main_queue(), ^{
				self.window.rootViewController = mainController;
			});
		}];
	}
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(UIColor *)colorForIndex:(NSUInteger)index{
	switch (index){
		case 0:
			return [UIColor colorWithRed:0.086 green:0.494 blue:0.984 alpha:1.000];
			break;
		case 1:
			return [UIColor colorWithRed:0.875 green:0.227 blue:0.239 alpha:1.000];
			break;
		case 2:
			return [UIColor colorWithRed:0.353 green:0.353 blue:0.353 alpha:1.000];
			break;
		case 3:
			return [UIColor colorWithRed:0.965 green:0.510 blue:0.137 alpha:1.000];
			break;
		case 4:
			return [UIColor colorWithRed:0.165 green:0.695 blue:0.082 alpha:1.000];
			break;
		case 5:
			return [UIColor colorWithRed:0.905 green:0.746 blue:0.138 alpha:1.000] ;
			break;
		case 6:
			return [UIColor colorWithRed:0.780 green:0.226 blue:0.799 alpha:1.000];
			break;
			
		default:
			break;
	}
	
	return nil;
}

@end
