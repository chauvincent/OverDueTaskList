//
//  EditTaskViewController.h
//  OverdueTaskList
//
//  Created by Vincent Chau on 7/17/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObject.h"

@protocol EditTaskViewControllerDelegate <NSObject>

-(void)didUpdateTask;

@end

@interface EditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>


@property (weak, nonatomic) id<EditTaskViewControllerDelegate> delegate;

- (IBAction)saveButtonPressed:(id)sender;

@property (strong, nonatomic) TaskObject *task;

@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
