//
//  TaskObject.m
//  OverdueTaskList
//
//  Created by Vincent Chau on 7/17/15.
//  Copyright (c) 2015 Vincent Chau. All rights reserved.
//

#import "TaskObject.h"

@implementation TaskObject

#pragma mark custom initializer

-(id) init{
    self = [self initWithData:nil];
    return self;
}


-(id)initWithData:(NSDictionary *)data
{

    self = [super init]; //this will use NSObject initializer first
    
    if(self){
        self.taskTitle = data[TASK_TITLENAME];
        self.taskDescription = data[TASK_DESCRIPTION];
        self.taskDate = data[TASK_DATE];
        self.isCompleted = [data[TASK_COMPLETETION] boolValue];
    }
    
    return self;
}



@end
