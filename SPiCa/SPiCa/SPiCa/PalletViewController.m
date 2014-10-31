//
//  PaletteViewController.m
//  SPiCa
//
//  Created by 島崎　恵美 on 2014/10/27.
//  Copyright (c) 2014年 島崎　恵美. All rights reserved.
//

#import "PalletViewController.h"
//#import "editStarViewController.h"

@interface PalletViewController ()

@end

@implementation PalletViewController

@synthesize SC;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if([self.a isEqualToString:( @"test")]){
        SC.selectedSegmentIndex = 3;
    }
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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