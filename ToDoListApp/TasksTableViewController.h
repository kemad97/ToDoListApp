//
//  TasksTableViewController.h
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "AddTaskDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface TasksTableViewController : UITableViewController <AddTaskDelegate>

@property  NSMutableArray<Task *> *lowPriorityTasks;
@property NSMutableArray<Task *> *mediumPriorityTasks;
@property  NSMutableArray<Task *> *highPriorityTasks;


@end

NS_ASSUME_NONNULL_END
