//
//  InProgressViewController.m
//  ToDoListApp
//
//  Created by Kerolos on 24/04/2025.
//

#import "InProgressViewController.h"
#import "TaskManager.h"
#import "EditDetailsViewController.h"
@interface InProgressViewController ()
@property (strong, nonatomic) TaskManager *taskManager;
@property (nonatomic, assign) BOOL isSorted;
@property (strong, nonatomic) NSArray *originalTaskOrder;

@end

@implementation InProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.inProgressTasks = [NSMutableArray array];
    self.taskManager = [TaskManager sharedManager];
    self.title = @"In Progress";
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tasksUpdated:)
                                                 name:@"TasksUpdatedNotification"
                                               object:nil];
    
    self.isSorted = NO;
    UIBarButtonItem *sortButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Sort"
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(sortTasksAlphabetically)];
        self.navigationItem.rightBarButtonItem = sortButton;
    
}





- (void)sortTasksAlphabetically {
    if (self.isSorted) {
        
        self.isSorted = NO;
        [self.inProgressTasks removeAllObjects];
        [self.inProgressTasks addObjectsFromArray:self.originalTaskOrder];
        self.navigationItem.rightBarButtonItem.title = @"Sort";
        
    } else {
        
        self.originalTaskOrder = [self.inProgressTasks copy];
        self.isSorted = YES;
        
        [self.inProgressTasks sortUsingComparator:^NSComparisonResult(Task *task1, Task *task2) {
            return [task1.name compare:task2.name];
        }];
        
        self.navigationItem.rightBarButtonItem.title = @"Unsort";
    }
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadTasks];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tasksUpdated:(NSNotification *)notification {
    [self loadTasks];
}

- (void)loadTasks {
    [_inProgressTasks removeAllObjects];
    
    NSArray* inProgressTasksArr = [self.taskManager tasksWithStatus:1];
    [self.inProgressTasks addObjectsFromArray:inProgressTasksArr];
    
    if (self.isSorted) {
        [self.inProgressTasks sortUsingComparator:^NSComparisonResult(Task *task1, Task *task2) {
            return [task1.name compare:task2.name];
        }];
    } else {
        self.originalTaskOrder = [self.inProgressTasks copy];
    }
    
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.inProgressTasks.count;  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
    if (!cell) {
           cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TaskCell"];
       }
    
    Task* task= self.inProgressTasks[indexPath.row];
    
    cell.textLabel.text=task.name;
    cell.detailTextLabel.text=task.taskDescription;
    
    UIImage *priorityIcon = [UIImage systemImageNamed:@"exclamationmark.triangle.fill"];

    
    switch (task.priority){
            
        case TASK_PRIORITY_HIGH:
                    cell.imageView.tintColor = [UIColor redColor];
                    break;
                case TASK_PRIORITY_MEDIUM:
                    cell.imageView.tintColor = [UIColor orangeColor];
                    break;
                case TASK_PRIORITY_LOW:
                    cell.imageView.tintColor = [UIColor systemGrayColor];
                    break;
        
    }
    cell.imageView.image = priorityIcon;
    return cell;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Task* selectedTask = _inProgressTasks[indexPath.row];
    
    EditDetailsViewController *editVC = [self.storyboard instantiateViewControllerWithIdentifier:@"editID"];
    editVC.task = selectedTask;
    editVC.delegate = self;
    
    
    [self.navigationController pushViewController:editVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (indexPath.row < self.inProgressTasks.count) {
            Task *taskToDelete = self.inProgressTasks[indexPath.row];
            
            [self.inProgressTasks removeObjectAtIndex:indexPath.row];
            
            
            if (self.isSorted && self.originalTaskOrder) {
                           NSMutableArray *updatedOriginal = [self.originalTaskOrder mutableCopy];
                           [updatedOriginal removeObject:taskToDelete]; 
                           self.originalTaskOrder = [updatedOriginal copy];
                       }
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [[TaskManager sharedManager] deleteTask:taskToDelete];
        } else {
            NSLog(@"Error: Trying to delete row %ld but only %lu rows exist",
                  (long)indexPath.row, (unsigned long)self.inProgressTasks.count);
            
            [tableView reloadData];
        }
    }
}

- (void)addTaskViewController:(id)controller MyTask:(Task *)task {
    [self loadTasks];
}

@end
