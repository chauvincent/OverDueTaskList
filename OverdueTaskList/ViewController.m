//
//  ViewController.m
//  OverdueTaskList
//
//  Created by Vincent Chau on 7/16/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark lazy instaniation
-(NSMutableArray *)allTasks{
    if (!_allTasks) {
        _allTasks = [[NSMutableArray alloc] init];
    }
    return _allTasks;
}




#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]])
    {
        AddTaskViewController *nextVC = segue.destinationViewController;
        
        nextVC.delegate = self;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderButtonPressed:(id)sender {
}

- (IBAction)addTaskButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:nil];
}

#pragma mark AddTaskViewControllerDelegate methods
-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)didAddTask:(TaskObject *) task
{

    [self.allTasks addObject:task];

    NSMutableArray *allTasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJKEY]  mutableCopy];
    
    if (!allTasksAsPropertyLists) {
        allTasksAsPropertyLists = [[NSMutableArray alloc] init];
    }
    
    // add helper return(dictionary) to property list
    [allTasksAsPropertyLists addObject:[self allTasksAsAPropertyList:task]];
    
    // save NSMutableArray to NSDefaults
    [[NSUserDefaults standardUserDefaults] setObject:allTasksAsPropertyLists forKey:TASK_OBJKEY];
    [[NSUserDefaults standardUserDefaults] synchronize]; // saved

    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData]; // reload to see changes
}


#pragma mark helper methods
-(NSDictionary *)allTasksAsAPropertyList:(TaskObject *)task{

    NSDictionary *dictionary = @{  TASK_TITLENAME : task.taskTitle,
                                 TASK_DESCRIPTION : task.taskDescription,
                                        TASK_DATE : task.taskDate,
                                TASK_COMPLETETION : @(task.isCompleted)};
    return dictionary;
}

@end
