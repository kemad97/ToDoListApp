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
@property (strong, nonatomic) TaskManager *taskManager;

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

    
    self.filteredLowPriorityTasks = [NSMutableArray array];
    self.filteredMediumPriorityTasks = [NSMutableArray array];
    self.filteredHighPriorityTasks = [NSMutableArray array];
    
    [self setupSearchController];

   

    self.taskManager = [TaskManager sharedManager];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(tasksUpdated:)
                                                     name:@"TasksUpdatedNotification"
                                                   object:nil];
    
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tasksUpdated:(NSNotification *)notification {
    [self loadTasks];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear - Loading tasks");
    [self loadTasks];
}

- (void)setupSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchBar.placeholder = @"Search Tasks";
    self.searchController.searchBar.delegate = self;
    
    self.searchController.searchBar.tintColor = [UIColor systemBlueColor];
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = self.searchController;
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
    } else {
        self.tableView.tableHeaderView = self.searchController.searchBar;
    }
    
    self.definesPresentationContext = YES;
}

- (void)loadTasks {
    
    if (!self.taskManager) {
        NSLog(@"ERROR: TaskManager is nil in tasktable");
        self.taskManager = [TaskManager sharedManager];
    }

    [self.lowPriorityTasks removeAllObjects];
    [self.mediumPriorityTasks removeAllObjects];
    [self.highPriorityTasks removeAllObjects];
    
    //NSArray *allTasks = [self.taskManager getAllTasks];
    
    NSArray *allTasks = [self.taskManager tasksWithStatus:0]; // TASK_STATUS_TODO

    
    for (Task *task in allTasks) {
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
        }
    }
    
    [self.tableView reloadData];
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    [self filterTasksWithSearchText:searchText];
}

- (void)filterTasksWithSearchText:(NSString *)searchText {
    [self.filteredLowPriorityTasks removeAllObjects];
    [self.filteredMediumPriorityTasks removeAllObjects];
    [self.filteredHighPriorityTasks removeAllObjects];
    
    if (searchText.length == 0) {
        self.isSearching = NO;
        [self.tableView reloadData];
        return;
    }
    
    self.isSearching = YES;
    
    for (Task *task in self.highPriorityTasks) {
        if ([self task:task matchesSearchText:searchText]) {
            [self.filteredHighPriorityTasks addObject:task];
        }
    }
    
    for (Task *task in self.mediumPriorityTasks) {
        if ([self task:task matchesSearchText:searchText]) {
            [self.filteredMediumPriorityTasks addObject:task];
        }
    }
    
    for (Task *task in self.lowPriorityTasks) {
        if ([self task:task matchesSearchText:searchText]) {
            [self.filteredLowPriorityTasks addObject:task];
        }
    }
    
    [self.tableView reloadData];
}

- (BOOL)task:(Task *)task matchesSearchText:(NSString *)searchText {
    NSString *lowercaseSearchText = [searchText lowercaseString];
    
    if ([task.name.lowercaseString containsString:lowercaseSearchText]) {
        return YES;
    }
    
    if ([task.taskDescription.lowercaseString containsString:lowercaseSearchText]) {
        return YES;
    }
    
    return NO;
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
    if (self.isSearching) {
        switch (section) {
            case TASK_PRIORITY_HIGH:
                return self.filteredHighPriorityTasks.count;
            case TASK_PRIORITY_MEDIUM:
                return self.filteredMediumPriorityTasks.count;
            case TASK_PRIORITY_LOW:
                return self.filteredLowPriorityTasks.count;
            default:
                return 0;
        }
    } else {
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TaskCell"];
    UIImage *priorityIcon = nil;

    Task *task = nil;
    
    if (self.isSearching)
    {
        switch (indexPath.section) {
            case TASK_PRIORITY_HIGH:
                if (self.filteredHighPriorityTasks.count > indexPath.row) {
                    task = self.filteredHighPriorityTasks[indexPath.row];
                    priorityIcon = [UIImage systemImageNamed:@"exclamationmark.triangle.fill"];
                    cell.imageView.tintColor = [UIColor redColor];
                }
                break;
            case TASK_PRIORITY_MEDIUM:
                if (self.filteredMediumPriorityTasks.count > indexPath.row) {
                    task = self.filteredMediumPriorityTasks[indexPath.row];
                    priorityIcon = [UIImage systemImageNamed:@"exclamationmark.triangle.fill"];
                    cell.imageView.tintColor = [UIColor orangeColor];
                }
                break;
            case TASK_PRIORITY_LOW:
                if (self.filteredLowPriorityTasks.count > indexPath.row) {
                    task = self.filteredLowPriorityTasks[indexPath.row];
                    priorityIcon = [UIImage systemImageNamed:@"exclamationmark.triangle.fill"];
                    cell.imageView.tintColor = [UIColor systemGrayColor];
                }
                break;
        }
    }
    else {
        
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Task *taskToDelete = nil;
        
        switch (indexPath.section) {
            case TASK_PRIORITY_HIGH:
                if (indexPath.row < self.highPriorityTasks.count) {
                    taskToDelete = self.highPriorityTasks[indexPath.row];
                }
                break;
                
            case TASK_PRIORITY_MEDIUM:
                if (indexPath.row < self.mediumPriorityTasks.count) {
                    taskToDelete = self.mediumPriorityTasks[indexPath.row];
                }
                break;
                
            case TASK_PRIORITY_LOW:
                if (indexPath.row < self.lowPriorityTasks.count) {
                    taskToDelete = self.lowPriorityTasks[indexPath.row];
                }
                break;
        }
        
        if (taskToDelete) {
            [[TaskManager sharedManager] deleteTask:taskToDelete];
            
            [self loadTasks];
        }
    }
}




@end
