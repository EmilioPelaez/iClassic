//
//  iPCTableDisplay.h
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCDisplay.h"

@interface iPCTableDisplay : iPCDisplay <UITableViewDataSource> {
}

@property(nonatomic, weak) IBOutlet UITableView *tableView;

@property(nonatomic) NSInteger selectedRow;
@property(nonatomic, readonly) NSInteger rowOffset;

-(Class)cellClass;

-(NSInteger)visibleRows;

-(void)configureCell:(UITableViewCell *)cell forIndex:(NSInteger)index;
-(void)didSelectRow:(NSInteger)row;

@end
