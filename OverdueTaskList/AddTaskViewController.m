//
//  AddTaskViewController.m
//  OverdueTaskList
//
//  Created by Vincent Chau on 7/17/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
    self.textField.delegate = self;
    
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

-(TaskObject*)returnNewTaskObject
{
    TaskObject *task = [[TaskObject alloc] init];
    task.taskTitle = self.textField.text;
    task.taskDescription = self.textView.text;
    task.taskDate = self.datePicker.date;
    task.isCompleted = NO;
    return task;
}
- (IBAction)cancelButtonPressed:(id)sender
{
    [self.delegate didCancel];
}

- (IBAction)addButtonPressed:(id)sender
{
    [self.delegate didAddTask:[self returnNewTaskObject]];
}
#pragma mark UITextField and TextView
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]){
        [self.textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
