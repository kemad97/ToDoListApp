//
//  AddTaskViewController.m
//  ToDoListApp
//
//  Created by Kerolos on 23/04/2025.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf_taskName;
@property (weak, nonatomic) IBOutlet UITextView *tv_taskDesc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment_priority;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnAddTask:(id)sender {
    Task *newTask = [Task new];
    newTask.name=
    
}

@end
