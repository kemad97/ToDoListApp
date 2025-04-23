//
//  TaskManager.m
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.
//

#import "TaskManager.h"

@implementation TaskManager

- (NSArray<Task *> *)getAllTasks {
    return [self.tasks copy];
}

- (void)saveTask:(Task *)task {
    [self.tasks addObject:task];
    [self persistTasks];

}


- (void)deleteTask:(Task *)task {
    [self.tasks removeObject:task];
    [self persistTasks];
}


- (void)loadTasks {
    NSData *tasksData = [[NSUserDefaults standardUserDefaults] objectForKey:@"tasks"];
    if (tasksData) {
        self.tasks = [[NSKeyedUnarchiver unarchiveObjectWithData:tasksData] mutableCopy];
    } else {
        self.tasks = [NSMutableArray array];
    }
}


- (void)persistTasks {
    NSData *tasksData = [NSKeyedArchiver archivedDataWithRootObject:self.tasks];
    [[NSUserDefaults standardUserDefaults] setObject:tasksData forKey:@"tasks"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
