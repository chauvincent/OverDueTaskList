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
    
    // if there is information saved with task objects in NSUserDefaults
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJKEY];
    
    // iterate and store dictionaries inside user defaults
    for (NSDictionary *dictionary in tasksAsPropertyLists)
    {
        // add stored data to allTasks
        TaskObject *tasks = [self allTasksForDictionary:dictionary];
        [self.allTasks addObject:tasks];
    }
    
    
//    set delegate and data source property
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
        AddTaskViewController *nextVC = segue.destinationViewController;
        
        nextVC.delegate = self;
    }
    
    if ([segue.destinationViewController isKindOfClass:[DetailTaskViewController class]]) {
        
        DetailTaskViewController *nextVC = segue.destinationViewController;
        
        NSIndexPath *path = sender;
        
        TaskObject *selectedTask = self.allTasks[path.row];
        
        nextVC.tasks = selectedTask;
    }
}


- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderButtonPressed:(id)sender {
    
}

- (IBAction)addTaskButtonPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:nil];
}

#pragma mark AddTaskViewControllerDelegate methods
-(void)didCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)didAddTask:(TaskObject *) task {
    
    // next set up table view, finished added the task need to show on tableview
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
-(NSDictionary *)allTasksAsAPropertyList:(TaskObject *)task {

    NSDictionary *dictionary = @{  TASK_TITLENAME : task.taskTitle,
                                 TASK_DESCRIPTION : task.taskDescription,
                                        TASK_DATE : task.taskDate,
                                TASK_COMPLETETION : @(task.isCompleted)};
    return dictionary;
}

-(TaskObject *)allTasksForDictionary:(NSDictionary *) dictionary {
    
    TaskObject * task = [[TaskObject alloc] initWithData:dictionary];
    
    return task;
}
-(BOOL)isOverdue:(NSDate *)date and:(NSDate *)toDate {
    // amount of time in seconds since 1970
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    return (dateInterval>toDateInterval ? YES : NO);
}

-(void)updateTask:(TaskObject *)task forIndexPath:(NSIndexPath *)indexPath {
    
    //remove task from propertylist
    NSMutableArray *taskObjectAsPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJKEY] mutableCopy];
    
    if(!taskObjectAsPropertyList)
        taskObjectAsPropertyList = [[NSMutableArray alloc] init];
    
    [taskObjectAsPropertyList removeObjectAtIndex:indexPath.row];
    
    if (task.isCompleted == YES) task.isCompleted = NO;
    else task.isCompleted = YES;
    
    [taskObjectAsPropertyList insertObject:[self allTasksAsAPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectAsPropertyList forKey:TASK_OBJKEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}


#pragma mark UITableViewDataSource && UITableViewDelegate
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toDetailTaskViewControllerSegue" sender:indexPath];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allTasks count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // configure cell
    TaskObject *task = self.allTasks[indexPath.row];
    cell.textLabel.text = task.taskTitle;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init ];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:task.taskDate];
    cell.detailTextLabel.text = stringFromDate;
    
    BOOL isOver = [self isOverdue:[NSDate date] and:task.taskDate];
    
    if(task.isCompleted == YES) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if (isOver == YES) {
        cell.backgroundColor = [UIColor redColor];
    }
    else{
        cell.backgroundColor = [UIColor whiteColor];
    }

    return cell;
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //remove from task object
        [self.allTasks removeObjectAtIndex:indexPath.row];
        
        //persist the deletion
        NSMutableArray *newTasksList = [[NSMutableArray alloc] init];
        
        for(TaskObject *tasks in self.allTasks)
        {
            [newTasksList addObject:[self allTasksAsAPropertyList:tasks]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:newTasksList forKey:TASK_OBJKEY];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
        
        
    }
 

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    TaskObject *task = self.allTasks[indexPath.row];
    
    [self updateTask:task forIndexPath:indexPath];
    
}


@end
