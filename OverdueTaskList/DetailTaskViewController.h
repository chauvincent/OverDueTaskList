//
//  DetailTaskViewController.h
//  OverdueTaskList
//
//  Created by Vincent Chau on 7/17/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTaskViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

- (IBAction)editButtonPressed:(id)sender;

@end
