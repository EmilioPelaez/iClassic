//
//  iPCQueryDisplay.m
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCQueryDisplay.h"

@implementation iPCQueryDisplay

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.items count] + (self.showAllRow ? 1 : 0);
}

-(void)setShowAllRow:(BOOL)showAllRow{
	_showAllRow = showAllRow;
	
	[self.tableView reloadData];
}

-(void)setItems:(NSArray *)items{
	_items = items;
	
	[self.tableView reloadData];
}

-(void)configureCell:(UITableViewCell *)cell forIndex:(NSInteger)index{
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	if(index == 0 && self.showAllRow){
		cell.textLabel.text = NSLocalizedString(@"All", @"All");
	}else{
		index = self.showAllRow ? index - 1 : index;
		id item = self.items[index];
		if(self.useRepresentativeItem) item = [item representativeItem];
		cell.textLabel.text = [item valueForProperty:self.itemProperty];
	}
}

-(NSString *)segueIdentifier{
	return nil;
}

-(NSString *)itemProperty{
	return nil;
}

-(BOOL)useRepresentativeItem{
	return NO;
}

@end
