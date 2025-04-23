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

#define TASK_PRIORITY_LOW 0
#define TASK_PRIORITY_MEDIUM 1
#define TASK_PRIORITY_HIGH 2



NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject
@property  NSString *name;
@property (nonatomic, strong) NSString *description;
@property  NSInteger priority;
@property  NSDate *dueDate;
@property  NSInteger status; 


@end

NS_ASSUME_NONNULL_END
