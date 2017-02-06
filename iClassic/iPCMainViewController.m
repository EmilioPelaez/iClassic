//
//  iPCMainViewController.m
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCMainViewController.h"
#import "iPCColorsManager.h"
#import "iPCMusicPlayer.h"

@interface iPCMainViewController ()

-(void)updateTheme;

@end

@implementation iPCMainViewController

-(void)viewDidLoad{
	[super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:@"UpdateTheme" object:nil];
	
	[self updateTheme];
	
	self.clickWheelView.musicDelegate = [iPCMusicPlayer sharedInstance];
	
	if(self.view.frame.size.height / self.view.frame.size.width > 1.5){
		displayTopMarginConstraint.constant = 20;
		displayBottomMarginConstraint.constant = 40;
	}else{
		displayTopMarginConstraint.constant = 30;
		displayBottomMarginConstraint.constant = 20;
	}
}

-(void)updateTheme{
	[self.view setBackgroundColor:[[iPCColorsManager sharedInstance] backgroundColor]];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	[self.view layoutIfNeeded];
}

-(void)viewDidLayoutSubviews{
	[super viewDidLayoutSubviews];
	
	CGFloat potentialHeight = 20;
	CGFloat finalHeight;
	for(int i = 0; (potentialHeight += kSmallRowHeight) < CGRectGetHeight(referenceDisplayView.frame); i++){
		if(i % 2 != 0)
			finalHeight = potentialHeight;
	}
	
	displayHeightConstraint.constant = finalHeight;
}

-(BOOL)prefersStatusBarHidden{
	return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if([segue.identifier isEqualToString:@"Embed Display"]){
		self.displayStack = segue.destinationViewController;
		self.clickWheelView.delegate = self.displayStack;
	}
}

@end
