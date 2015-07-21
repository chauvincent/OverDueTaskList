//
//  DetailTaskViewController.h
//  OverdueTaskList
//
//  Created by Vincent Chau on 7/17/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObject.h"
#import "EditTaskViewController.h"

@protocol DetailViewControllerDelegate <NSObject>

-(void)updateCallBack;

@end



@interface DetailTaskViewController : UIViewController <EditTaskViewControllerDelegate>

@property (strong, nonatomic) TaskObject *tasks;

@property (weak,nonatomic) id <DetailViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

- (IBAction)editButtonPressed:(id)sender;

@end
