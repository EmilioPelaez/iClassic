//
//  iPCThemesDisplay.m
//  iClassic
//
//  Created by Emilio Peláez on 09/07/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "iPCThemesDisplay.h"
#import "iPCAppDelegate.h"
#import "iPCColorsManager.h"

@interface iPCThemesDisplay (){
	UIImage *colorImage;
	
	iPCColorsManager *manager;
}

@end

@implementation iPCThemesDisplay

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if (self) {
		self.selectedRow = [[NSUserDefaults standardUserDefaults] integerForKey:@"Color"];
		
		manager = [iPCColorsManager sharedInstance];
		
		colorImage = [[UIImage imageNamed:@"Color"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	}
	return self;
}

-(void)viewDidLoad{
	[super viewDidLoad];
	
	self.tableView.rowHeight = kLargeRowHeight;
	
	self.selectedRow = manager.themeColorIndex;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return manager.colors.count;
}

-(void)configureCell:(UITableViewCell *)cell forIndex:(NSInteger)index{
	[cell.textLabel setText:manager.colorNames[index]];
	
	cell.imageView.image = colorImage;
	if(index != self.selectedRow)
		cell.imageView.tintColor = manager.colors[index];
}

-(void)didSelectRow:(NSInteger)selectedRow{
	manager.themeColorIndex = selectedRow;
}

-(void)centerButtonPressed{
	[self.displayStack popDisplay];
}

@end
