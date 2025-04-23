//
//  TasksTableViewController.m
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.
//

#import "TasksTableViewController.h"
#import "AddTaskViewController.h"
#import "AddTaskDelegate.h"


@interface TasksTableViewController ()

@end

@implementation TasksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lowPriorityTasks = [NSMutableArray array];
    self.mediumPriorityTasks = [NSMutableArray array];
    self.highPriorityTasks = [NSMutableArray array];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(onAddClick)];
    self.navigationItem.rightBarButtonItem = addButton;

    
    
}


- (void)onAddClick {
    AddTaskViewController *addTaskVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTaskID"];
    addTaskVC.delegate = self;
    
    [self.navigationController pushViewController:addTaskVC animated:YES];

    
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addTaskVC];
//    [self :navController animated:YES completion:nil];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    switch (section) {
        case 0:
            return self.highPriorityTasks.count;
        case 1:
            return self.mediumPriorityTasks.count;
        case 2:
            return self.lowPriorityTasks.count;
        default:
            return 0;
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"High Priority";
        case 1:
            return @"Medium Priority";
        case 2:
            return @"Low Priority";
        default:
            return @"";
    }
}


#pragma mark - AddTaskDelegate methods

- (void)addTaskViewController:(AddTaskViewController *)controller didCreateTask:(Task *)task {
    switch (task.priority) {
        case TASK_PRIORITY_LOW:
            [self.lowPriorityTasks addObject:task];
            break;
        case TASK_PRIORITY_MEDIUM:
            [self.mediumPriorityTasks addObject:task];
            break;
        case TASK_PRIORITY_HIGH:
            [self.highPriorityTasks addObject:task];
            break;
        default:
            [self.mediumPriorityTasks addObject:task];
            break;
    }
    
    [self.tableView reloadData];
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
