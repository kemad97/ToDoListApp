//
//  TaskManager.m
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.


#import "TaskManager.h"

@implementation TaskManager

- (NSArray<Task *> *)getAllTasks {
    NSData *tasksData = [[NSUserDefaults standardUserDefaults] objectForKey:@"tasks"];
    if (tasksData) {
        NSArray *tasks = [NSKeyedUnarchiver unarchiveObjectWithData:tasksData];
        NSLog(@"Got %d tasks from NSUserDefaults", (int)tasks.count);
        return tasks;

    }
    return @[];
}

- (void)saveTask:(Task *)task {
    NSMutableArray *tasks = [[self getAllTasks] mutableCopy];
    [tasks addObject:task];
    
    NSData *tasksData = [NSKeyedArchiver archivedDataWithRootObject:tasks];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:tasksData forKey:@"tasks"];
    [defaults synchronize];
    
    NSLog(@"Saved task: %@. Total tasks: %lu", task.name, (unsigned long)tasks.count);
}

- (void)deleteTask:(Task *)task {
    NSMutableArray *tasks = [[self getAllTasks] mutableCopy];
    
    for (NSInteger i = 0; i < tasks.count; i++) {
        Task *currentTask = tasks[i];
        
        if ([currentTask.name isEqualToString:task.name] &&
            [currentTask.dueDate isEqualToDate:task.dueDate]) {
            
            [tasks removeObjectAtIndex:i];
            
            NSData *tasksData = [NSKeyedArchiver archivedDataWithRootObject:tasks];
            [[NSUserDefaults standardUserDefaults] setObject:tasksData forKey:@"tasks"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSLog(@"Task deleted: %@", task.name);
            return; 
        }
    }
    
    NSLog(@"Task not found for deletion: %@", task.name);
}

@end
