//
//  PaletteViewController.h
//  SPiCa
//
//  Created by 島崎　恵美 on 2014/10/27.
//  Copyright (c) 2014年 島崎　恵美. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaletteViewController : UIViewController
{
 //  UISegmentedControl *SC;
}

//@property UIImage *backview;


@property(nonatomic, retain) IBOutlet UISegmentedControl *BackColor;
@property(nonatomic, retain) IBOutlet UISegmentedControl *StarColor;
@property(nonatomic, retain) IBOutlet UISegmentedControl *Star;
@property(nonatomic, retain) IBOutlet UISegmentedControl *StarSize;//@property(weak, nonatomic) IBOutlet UISegmentedControl *sc;
@property NSString *a;
@property int int_Back_color;
@property int int_Star_color;
@property int int_Star_obj;
@property int int_Star_size;

-(IBAction)button_back;



-(IBAction)BackColorSegChanged:(id)sender;
-(IBAction)StarColorSegChanged:(id)sender;
-(IBAction)StarSegChanged:(id)sender;
-(IBAction)StarSizeSegChanged:(id)sender;

@end