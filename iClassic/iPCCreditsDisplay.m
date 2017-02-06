//
//  iPCCreditsDisplay.m
//  iClassic
//
//  Created by Emilio Peláez on 6/12/15.
//  Copyright © 2015 Emilio Peláez. All rights reserved.
//

#import <MessageUI/MessageUI.h>

#import "iPCCreditsDisplay.h"
#import "iPCDetailTableCell.h"

@interface iPCCreditsDisplay (){
	NSArray *cellTitles;
	NSArray *cellSubtitles;
	NSArray *cellImages;
}

@end

@implementation iPCCreditsDisplay

-(void)viewDidLoad {
	[super viewDidLoad];
	
	self.tableView.rowHeight = kLargeRowHeight;
	
	cellTitles = @[@"Emilio Peláez",
								 @"@EmilioPelaez",
								 @"i.am@emiliopelaez.me",
								 @"EmilioPelaez",
								 @"http://oili.me"];
	
	cellSubtitles = @[@"Code and Design",
										@"Follow me on Twitter",
										@"Send me an email",
										@"Connect on LinkedIn",
										@"Check my website"];
	
	cellImages = @[[UIImage imageNamed:@"Code"],
								 [UIImage imageNamed:@"Twitter"],
								 [UIImage imageNamed:@"Mail"],
								 [UIImage imageNamed:@"Business"],
								 [UIImage imageNamed:@"Website"]];
	
}

-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return cellTitles.count;
}

-(Class)cellClass{
	return iPCDetailTableCell.class;
}

-(void)configureCell:(UITableViewCell *)cell forIndex:(NSInteger)index{
	cell.textLabel.text = cellTitles[index];
	cell.detailTextLabel.text = cellSubtitles[index];
	cell.imageView.image = cellImages[index];
	
	cell.accessoryType = index > 0 ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
}

-(void)centerButtonPressed{
	switch (self.selectedRow) {
		case 1:{
			UIApplication *app = [UIApplication sharedApplication];
			
			NSArray *urlPaths = @[@"tweetbot://EmilioPelaez/user_profile/EmilioPelaez",
														@"twitterrific:///profile?screen_name=EmilioPelaez",
														@"twitter://user?screen_name=EmilioPelaez",
														@"http://twitter.com/EmilioPelaez"];
			for(NSString *urlPath in urlPaths){
				NSURL *url = [NSURL URLWithString:urlPath];
				if([app canOpenURL:url]){
					[app openURL:url];
					break;
				}
			}
			break;
		}
		case 2:{
			if([MFMailComposeViewController canSendMail]){
				MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
				mailComposer.mailComposeDelegate = self;
				
				[mailComposer setSubject:@"iClassic"];
				[mailComposer setToRecipients:@[@"i.am@emiliopelaez.me"]];
				
				[self presentViewController:mailComposer animated:YES completion:nil];
			}
			break;
		}
		case 3:{
			UIApplication *app = [UIApplication sharedApplication];
			
			NSArray *urlPaths = @[@"linkedin://profile/104824611",
														@"https://linkedin.com/in/emiliopelaez"];
			for(NSString *urlPath in urlPaths){
				NSURL *url = [NSURL URLWithString:urlPath];
				if([app canOpenURL:url]){
					[app openURL:url];
					break;
				}
			}
			break;
		}
		case 4:
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://oili.me"]];
			break;
  default:
			break;
	}
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
