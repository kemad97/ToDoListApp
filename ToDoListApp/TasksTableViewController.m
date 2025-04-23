//
//  TasksTableViewController.m
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.
//

#import "TasksTableViewController.h"
#import "AddTaskViewController.h"
#import "AddTaskDelegate.h"
#import "EditDetailsViewController.h"
#import "TaskManager.h"

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
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    switch (section) {
        case TASK_PRIORITY_HIGH:
            return self.highPriorityTasks.count;
        case TASK_PRIORITY_MEDIUM:
            return self.mediumPriorityTasks.count;
        case TASK_PRIORITY_LOW:
            return self.lowPriorityTasks.count;
        default:
            return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TaskCell"];
    UIImage *priorityIcon = nil;

    
    Task *task = nil;
    switch (indexPath.section) {
        case TASK_PRIORITY_HIGH:
            task = self.highPriorityTasks[indexPath.row];
            priorityIcon = [UIImage systemImageNamed:@"exclamationmark.triangle.fill"];
            cell.imageView.tintColor = [UIColor redColor];

            break;
        case TASK_PRIORITY_MEDIUM:
                task = self.mediumPriorityTasks[indexPath.row];
            priorityIcon = [UIImage systemImageNamed:@"exclamationmark.triangle.fill"];
            cell.imageView.tintColor = [UIColor orangeColor];

            break;
        case TASK_PRIORITY_LOW:
                task = self.lowPriorityTasks[indexPath.row];
            priorityIcon = [UIImage systemImageNamed:@"exclamationmark.triangle.fill"];
            cell.imageView.tintColor = [UIColor systemGrayColor];

            break;
    }
    
    if (task != nil) {
        cell.textLabel.text = task.name;
        cell.detailTextLabel.text = task.taskDescription;
        cell.imageView.image = priorityIcon;

        
    }
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case TASK_PRIORITY_HIGH:
            return @"High Priority";
        case TASK_PRIORITY_MEDIUM:
            return @"Medium Priority";
        case TASK_PRIORITY_LOW:
            return @"Low Priority";
        default:
            return @"";
    }
}


#pragma mark - AddTaskDelegate methods

- (void)addTaskViewController:(AddTaskViewController *)controller MyTask:(Task *)task {
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Task *selectedTask = nil;
    
    switch (indexPath.section) {
        case TASK_PRIORITY_HIGH:
                selectedTask = self.highPriorityTasks[indexPath.row];
            
            break;
        case TASK_PRIORITY_MEDIUM:
                selectedTask = self.mediumPriorityTasks[indexPath.row];
            
            break;
        case TASK_PRIORITY_LOW: 
                selectedTask = self.lowPriorityTasks[indexPath.row];
            
            break;
    }
    
    if (selectedTask) {
        EditDetailsViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"editID"];
        editVC.task = selectedTask;
        editVC.delegate = self;
        [self.navigationController pushViewController:editVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Task *taskToDelete = nil;
        
        switch (indexPath.section) {
            case TASK_PRIORITY_HIGH:
                taskToDelete = self.highPriorityTasks[indexPath.row];
                [self.highPriorityTasks removeObjectAtIndex:indexPath.row];
                break;
                
            case TASK_PRIORITY_MEDIUM:
                taskToDelete = self.mediumPriorityTasks[indexPath.row];
                [self.mediumPriorityTasks removeObjectAtIndex:indexPath.row];
                break;
                
            case TASK_PRIORITY_LOW:
                taskToDelete = self.lowPriorityTasks[indexPath.row];
                [self.lowPriorityTasks removeObjectAtIndex:indexPath.row];
                break;
        }
        
        if (taskToDelete) {
            TaskManager *taskManager = [[TaskManager alloc] init];
            [taskManager deleteTask:taskToDelete];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}



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
