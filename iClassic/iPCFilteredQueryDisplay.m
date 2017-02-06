//
//  iPCFilteredQueryDisplay.m
//  iClassic
//
//  Created by Emilio Peláez on 6/3/15.
//  Copyright (c) 2015 Emilio Peláez. All rights reserved.
//

#import "iPCFilteredQueryDisplay.h"

@interface iPCFilteredQueryDisplay ()

@end

@implementation iPCFilteredQueryDisplay

-(void)centerButtonPressed{
	NSString *title;
	BOOL filter = NO;
	
	if(self.selectedRow == 0 && self.showAllRow){
		title = self.segueIdentifier;
	}else{
		id item = self.items[self.selectedRow - (self.showAllRow ? 1 : 0)];
		if(self.useRepresentativeItem) item = [item representativeItem];
		title = [item valueForProperty:self.itemProperty];
		filter = YES;
	}
	
	MPMediaPropertyPredicate *predicate;
	if(filter)
		predicate = [MPMediaPropertyPredicate predicateWithValue:title forProperty:self.itemProperty];
	
	if(filter)
		[self performSegueWithIdentifier:self.segueIdentifier sender:@{@"Title" : title,
																																	 @"Predicate" : predicate}];
	else
		[self performSegueWithIdentifier:self.segueIdentifier sender:@{@"Title" : title}];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	NSDictionary *userInfo = (NSDictionary *)sender;
	iPCQueryDisplay *display = segue.destinationViewController;
	
	[display.query setFilterPredicates:self.query.filterPredicates];
	display.title = userInfo[@"Title"];
	if(userInfo[@"Predicate"])
		[display.query addFilterPredicate:userInfo[@"Predicate"]];
}

@end
