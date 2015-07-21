//
//  DetailTaskViewController.m
//  OverdueTaskList
//
//  Created by Vincent Chau on 7/17/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import "DetailTaskViewController.h"

@interface DetailTaskViewController ()

@end

@implementation DetailTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.tasks.taskTitle;
    
    self.detailLabel.text = self.tasks.taskDescription;
    
    NSDate *date = self.tasks.taskDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *formattedDate = [formatter stringFromDate:date];
    
    self.dateLabel.text = formattedDate;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"toEditTaskViewControllerSegue" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.destinationViewController isKindOfClass:[EditTaskViewController class]]) {
    
        EditTaskViewController *nextVC;
        nextVC = segue.destinationViewController;
        nextVC.task = self.tasks;
        nextVC.delegate = self;
    }
    
    
}
-(void)didUpdateTask{
    
    self.titleLabel.text = self.tasks.taskTitle;
    self.detailLabel.text = self.tasks.taskDescription;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *string = [formatter stringFromDate:self.tasks.taskDate];
    self.dateLabel.text = string;
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate updateCallBack];
}


@end
