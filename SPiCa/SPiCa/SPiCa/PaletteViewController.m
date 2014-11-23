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
    
    [self BackColorSegChanged:nil];
    [self StarColorSegChanged:nil];
    [self StarSegChanged:nil];
    [self StarSizeSegChanged:nil];
    
    //self.BackColor.frame =  CGRectMake(0, 0, 250, 50);
    //[self.BackColor setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, fNewHeight)];
    
}

- (UIModalPresentationStyle)modalPresentationStyle
{
    return UIModalPresentationOverCurrentContext;
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


//Segmented Controlをタッチしたときの動作

-(IBAction)BackColorSegChanged:(id)sender{
    switch (self.BackColor.selectedSegmentIndex) {
        case 0:
            self.BackColor.tintColor = [UIColor purpleColor];
            break;
            
        case 1:
            self.BackColor.tintColor = [UIColor blueColor];
            break;
            
        case 2:
            
            self.BackColor.tintColor = [UIColor redColor];
            break;
            
        case 3:
        
            self.BackColor.tintColor = [UIColor greenColor];
            break;
            
        case 4:
           
            self.BackColor.tintColor = [UIColor grayColor];
            break;
            
        default:
            break;
    }
}
-(IBAction)StarColorSegChanged:(id)sender{
    switch (self.StarColor.selectedSegmentIndex) {
        case 0:
            self.StarColor.tintColor = [UIColor yellowColor];
            break;
            
        case 1:
            self.StarColor.tintColor = [UIColor blueColor];
            break;
            
        case 2:
            
            self.StarColor.tintColor = [UIColor redColor];
            break;
            
        case 3:
            
            self.StarColor.tintColor = [UIColor greenColor];
            break;
            
        case 4:
            
            self.StarColor.tintColor = [UIColor whiteColor];
            break;
            
        default:
            break;
    }
}
-(IBAction)StarSegChanged:(id)sender{
    switch (self.Star.selectedSegmentIndex) {
        case 0:
            self.Star.tintColor = [UIColor whiteColor];
            break;
            
        case 1:
            self.Star.tintColor = [UIColor lightGrayColor];
            break;
            
        case 2:
            
            self.Star.tintColor = [UIColor darkGrayColor];
            break;
            
        default:
            break;
    }
}
-(IBAction)StarSizeSegChanged:(id)sender{
    switch (self.StarSize.selectedSegmentIndex) {
        case 0:
            self.StarSize.tintColor = [UIColor whiteColor];
            break;
            
        case 1:
            self.StarSize.tintColor = [UIColor lightGrayColor];
            break;
            
        case 2:
            
            self.StarSize.tintColor = [UIColor darkGrayColor];
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


-(IBAction)button_back{
    [self dismissViewControllerAnimated:YES completion:nil];
    // デリゲート先がちゃんと「sampleMethod1」というメソッドを持っているか?
    if ([self.delegate respondsToSelector:@selector(returnSelectedValue:color:figure:size:)]) {
        // sampleMethod1を呼び出す
        [self.delegate returnSelectedValue:self.BackColor.selectedSegmentIndex color:self.StarColor.selectedSegmentIndex figure:self.Star.selectedSegmentIndex size:self.StarSize.selectedSegmentIndex];
    }

    
    
}


@end