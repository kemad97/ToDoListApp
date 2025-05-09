//
//  TaskManager.h
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.
//

#import <Foundation/Foundation.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface TaskManager : NSObject

@property (nonatomic, strong) NSMutableArray<Task *> *tasks;

+ (instancetype)sharedManager;

- (void)addTask:(Task *)task;  
- (NSArray<Task *> *)getAllTasks;
- (void)saveTask:(Task *)task;
- (void)deleteTask:(Task *)task;
- (void)updateTask:(Task *)task;  


- (NSArray<Task *> *)tasksWithStatus:(NSInteger)status;
- (NSArray<Task *> *)tasksWithPriority:(NSInteger)priority;

@end

NS_ASSUME_NONNULL_END





//- (NSArray<Task *> *)tasksWithStatus:(NSInteger)status;
