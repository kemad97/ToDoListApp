//
//  TaskTableViewCell.h
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.
//

#import <UIKit/UIKit.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@interface TaskTableViewCell : UITableViewCell
- (void)configureWithTask:(Task *)task iconImage:(UIImage *)iconImage iconColor:(UIColor *)iconColor;

@end

NS_ASSUME_NONNULL_END
