//
//  EditTaskViewController.m
//  OverdueTaskList
//
//  Created by Vincent Chau on 7/17/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.text = self.task.taskTitle;
    self.textView.text = self.task.taskDescription;
    self.datePicker.date = self.task.taskDate;
    
    
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

- (IBAction)saveButtonPressed:(id)sender {
    [self updateTask];
    [self.delegate didUpdateTask];

}
-(void)updateTask{
    self.task.taskTitle = self.textField.text;
    self.task.taskDescription = self.textView.text;
    self.task.taskDate = self.datePicker.date;

}
@end
