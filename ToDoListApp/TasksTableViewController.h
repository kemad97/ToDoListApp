//
//  TasksTableViewController.h
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.
//

#import <UIKit/UIKit.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface TasksTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray<Task *> *lowPriorityTasks;
@property (nonatomic, strong) NSMutableArray<Task *> *mediumPriorityTasks;
@property (nonatomic, strong) NSMutableArray<Task *> *highPriorityTasks;


@end

NS_ASSUME_NONNULL_END
