//
//  Task.h
//  ToDoListApp
//
//  Created by Kerolos on 22/04/2025.
//

#import <Foundation/Foundation.h>

#define TASK_STATUS_TODO 0
#define TASK_STATUS_IN_PROGRESS 1
#define TASK_STATUS_DONE 2

#define TASK_PRIORITY_LOW 2
#define TASK_PRIORITY_MEDIUM 1
#define TASK_PRIORITY_HIGH 0

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject <NSCoding>

@property  NSString *name;
@property  NSString *taskDescription;
@property  NSInteger priority;
@property  NSDate *dueDate;
@property  NSInteger status;

@end

NS_ASSUME_NONNULL_END
