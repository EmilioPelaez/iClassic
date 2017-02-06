//
//  iPCDisplayStack.m
//  iPodClassic
//
//  Created by Emilio Peláez on 7/29/10.
//  Copyright 2010 Kernel Panic. All rights reserved.
//

#import "iPCDisplayStack.h"

#import "iPCNowPlayingDisplay.h"
#import "iPCMenuDisplay.h"

#define kAnimationsDuration .25

@interface iPCDisplayStack ()

@end

@implementation iPCDisplayStack


#pragma mark - Display Control

-(void)viewDidLoad{
	[super viewDidLoad];
	[self performSegueWithIdentifier:@"Embed Now Playing" sender:nil];
	[self performSegueWithIdentifier:@"Embed Menu" sender:nil];
}

-(void)pushDisplay:(iPCDisplay *)display{
	[self.navigationController pushViewController:display animated:YES];
}

-(void)popDisplay{
	[self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)showNowPlaying{
	if(self.currentDisplay != self.nowPlayingDisplay && self.nowPlayingDisplay.navigationController != self.navigationController){
		if([[MPMusicPlayerController systemMusicPlayer] nowPlayingItem])
			[self pushDisplay:self.nowPlayingDisplay];
		return YES;
	}
	return NO;
}

#pragma mark - Properties

-(iPCDisplay *)currentDisplay{
	return (iPCDisplay *)self.navigationController.topViewController;
}

#pragma mark - ClickWheel Delegate

-(void)topAction:(iPCButtonAction)action{
	switch(action){
		case iPCButtonActionTap:
			if(self.navigationController.viewControllers.count > 1)
				[self popDisplay];
			else
				[self showNowPlaying];
			break;
		case iPCButtonActionBeginHold:
			if(![self showNowPlaying])
				[self popDisplay];
			break;
		case iPCButtonActionEndHold:
			break;
			
		default:
			break;
	}
}

-(void)centerAction:(iPCButtonAction)action{
	switch(action){
		case iPCButtonActionTap:
			[self.currentDisplay centerButtonPressed];
			break;
		case iPCButtonActionBeginHold:
			[self.currentDisplay centerButtonPressed];
			break;
		default:
			break;
	}
}

-(void)movementWithOffset:(CGFloat)offset{
	[self.currentDisplay receivedOffset:offset];
}

-(void)finalMovementWithOffset:(CGFloat)offset{
	[self.currentDisplay receivedFinalOffset:offset];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if([segue.identifier isEqualToString:@"Embed Now Playing"]){
		self.nowPlayingDisplay = segue.destinationViewController;
	}else if([segue.identifier isEqualToString:@"Embed Navigation Controller"]){
		self.navigationController = segue.destinationViewController;
		self.navigationController.delegate = self;
		if(self.menuDisplay) [self.navigationController pushViewController:self.menuDisplay animated:NO];
	}else if([segue.identifier isEqualToString:@"Embed Menu"]){
		self.menuDisplay = segue.destinationViewController;
		[self.navigationController pushViewController:self.menuDisplay animated:NO];
	}
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
	iPCDisplay *display = (iPCDisplay *)viewController;
	display.displayStack = self;
	
	if(display.title)
		[self.statusBar setTitle:display.title];
}

@end
