//
//  ViewController.h
//  OverdueTaskList
//
//  Created by Vincent Chau on 7/16/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"
@interface ViewController : UIViewController <AddTaskViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *allTasks;


@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)reorderButtonPressed:(id)sender;
- (IBAction)addTaskButtonPressed:(id)sender;





@end

