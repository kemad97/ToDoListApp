//
//  AddTaskViewController.h
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.
//

#import "ViewController.h"
#import "AddTaskDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddTaskViewController : ViewController

@property id<AddTaskDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
