//
//  PaletteViewController.m
//  SPiCa
//
//  Created by 島崎　恵美 on 2014/10/27.
//  Copyright (c) 2014年 島崎　恵美. All rights reserved.
//

#import "PaletteViewController.h"
//#import "editStarViewController.h"

@interface PaletteViewController ()

@end

@implementation PaletteViewController

@synthesize delegate;
//@synthesize SC;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.BackColor.selectedSegmentIndex = self.int_Back_color;
    self.StarColor.selectedSegmentIndex = self.int_Star_color;
    self.Star.selectedSegmentIndex = self.int_Star_obj;
    self.StarSize.selectedSegmentIndex = self.int_Star_size;
    // Do any additional setup after loading the view.
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    /*
     self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
     if (self) {
     // Custom initialization
     }
     */
    return self;
    
}

/*
 -(void)dealloc {
 [sc release];
 [super dealloc];
 }
 */

//Segmented Controlをタッチしたときの動作
/*
-(IBAction)SegChanged:(id)sender
{
    switch (SC.selectedSegmentIndex) {
        case 0:
            NSLog(self.a);
            self.view.backgroundColor = [UIColor blackColor];
            break;
            
        case 1:
            NSLog(@"2つ目が選択されています");
            self.view.backgroundColor = [UIColor blueColor];
            break;
            
        case 2:
            NSLog(@"3つ目が選択されています");
            self.view.backgroundColor = [UIColor redColor];
            break;
            
        case 3:
            NSLog(@"4つ目が選択されています");
            self.view.backgroundColor = [UIColor greenColor];
            break;
            
        case 4:
            NSLog(@"5つ目が選択されています");
            self.view.backgroundColor = [UIColor grayColor];
            break;
            
        default:
            break;
    }
    
}
 */
-(IBAction)BackColorSegChanged:(id)sender{
    
}
-(IBAction)StarColorSegChanged:(id)sender{
    
}
-(IBAction)StarSegChanged:(id)sender{
    
}
-(IBAction)StarSizeSegChanged:(id)sender{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)button_back{
    [self dismissViewControllerAnimated:YES completion:nil];
    // デリゲート先がちゃんと「sampleMethod1」というメソッドを持っているか?
    if ([self.delegate respondsToSelector:@selector(returnSelectedValue:color:figure:size:)]) {
        // sampleMethod1を呼び出す
        [self.delegate returnSelectedValue:self.BackColor.selectedSegmentIndex color:self.StarColor.selectedSegmentIndex figure:self.Star.selectedSegmentIndex size:self.StarSize.selectedSegmentIndex];
    }

    
    
}


/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end