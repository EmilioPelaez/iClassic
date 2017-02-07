//
//  iPCTableDisplay.m
//  iClassic
//
//  Created by Emilio Peláez on 4/30/13.
//  Copyright (c) 2013 Emilio Peláez. All rights reserved.
//

#import "iPCTableDisplay.h"

#import "iPCTableCell.h"
#import "easing.h"

static NSString *CellID = @"Cell ID";

@interface iPCTableDisplay (){
	float selection;
	
	NSInteger scrollCount;
}

-(void)updateTheme;

@end

@implementation iPCTableDisplay

+(UISelectionFeedbackGenerator *)feedbackGenerator{
	static UISelectionFeedbackGenerator *generator;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
			generator = [[UISelectionFeedbackGenerator alloc] init];
	});
	
	return generator;
}

-(void)viewDidLoad{
	[super viewDidLoad];
	
	self.tableView.rowHeight = kSmallRowHeight;
	
	[self.tableView registerClass:self.cellClass forCellReuseIdentifier:CellID];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:@"UpdateTheme" object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:@"UpdateColor" object:nil];
	
	[self updateTheme];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	iPCTableCell *cell = (iPCTableCell *)[tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
	
	cell.currentlySelected = indexPath.row == self.selectedRow - _rowOffset;
	
	[self configureCell:cell forIndex:indexPath.row + _rowOffset];
	
	return cell;
}

-(void)configureCell:(UITableViewCell *)cell forIndex:(NSInteger)index{
}

-(void)receivedOffset:(float)offset{
	offset *= 2;
	float sign = offset < 0 ? -1 : 1;
	offset = fabsf(offset);
	offset = MAX(.05, SineEaseIn(offset)) * sign;
	if(fabsf(offset) > .35){
		if(++scrollCount > 50){
			offset *= 5;
		}
	}else if(fabsf(offset) < .05){
		scrollCount = 0;
	}
	
	NSInteger prevSelectedRow = self.selectedRow;
	
	selection += offset;
	selection = MIN(selection, [self tableView:self.tableView numberOfRowsInSection:0] - .1);
	selection = MAX(selection, 0);
	_selectedRow = (int)selection;
	
	if(self.selectedRow != prevSelectedRow){
		if(self.selectedRow < _rowOffset) _rowOffset = self.selectedRow;
		else if(self.selectedRow > _rowOffset + self.visibleRows) _rowOffset = self.selectedRow - self.visibleRows;
		
		[self didSelectRow:self.selectedRow];
		
		[self.tableView reloadData];
	}
}

-(Class)cellClass{
	return iPCTableCell.class;
}

-(void)setSelectedRow:(NSInteger)selectedRow{
	_selectedRow = selectedRow;
	selection = selectedRow;
	
	if(self.selectedRow < _rowOffset) _rowOffset = self.selectedRow;
	if(self.selectedRow > _rowOffset + (self.visibleRows + 1)) _rowOffset = self.selectedRow - (self.visibleRows + 1);
	
	[self didSelectRow:selectedRow];
}

-(void)didSelectRow:(NSInteger)row{
	[[self.class feedbackGenerator] selectionChanged];
}

-(NSInteger)visibleRows{
	return (CGRectGetHeight(self.tableView.frame) / self.tableView.rowHeight) - 1;
}

-(void)updateTheme{
	[self.tableView reloadData];
	self.tableView.separatorColor = [[iPCColorsManager sharedInstance] themeColor];
}

@end
