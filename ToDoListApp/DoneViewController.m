//
//  DoneViewController.m
//  ToDoListApp
//
//  Created by Kerolos on 24/04/2025.
//

#import "DoneViewController.h"
#import "EditDetailsViewController.h"
#import "TaskManager.h"

@interface DoneViewController ()
@property (strong, nonatomic) TaskManager *taskManager;

@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _doneTasks = [NSMutableArray array];
    _taskManager = [TaskManager sharedManager];
    
    self.title=@"Donee";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tasksUpdated:) name:@"TasksUpdatedNotification" object:nil];
    
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

-(void)loadTasks {
    [_doneTasks removeAllObjects];
    
    NSArray* doneTasksArr = [self.taskManager tasksWithStatus:2];
    
    [self.doneTasks addObjectsFromArray:doneTasksArr];
    
    [self.tableView reloadData];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.doneTasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
    if (!cell) {
           cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TaskCell"];
       }
    
    Task* task= self.doneTasks[indexPath.row];
    
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
    
    Task* selectedTask = _doneTasks[indexPath.row];
    
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
        
        if (indexPath.row < self.doneTasks.count) {
            Task *taskToDelete = self.doneTasks[indexPath.row];
            
            [self.doneTasks removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [[TaskManager sharedManager] deleteTask:taskToDelete];
        }
    }
}

- (void)addTaskViewController:(id)controller MyTask:(Task *)task {
    [self loadTasks];
}
@end
