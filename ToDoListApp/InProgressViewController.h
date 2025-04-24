//
//  InProgressViewController.h
//  ToDoListApp
//
//  Created by Kerolos on 24/04/2025.
//

#import "ViewController.h"
#import "AddTaskDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface InProgressViewController : UITableViewController <AddTaskDelegate>

@property (nonatomic, strong) NSMutableArray *inProgressTasks;


@end

NS_ASSUME_NONNULL_END
