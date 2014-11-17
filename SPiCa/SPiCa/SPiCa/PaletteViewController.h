//
//  PaletteViewController.h
//  SPiCa
//
//  Created by 島崎　恵美 on 2014/10/27.
//  Copyright (c) 2014年 島崎　恵美. All rights reserved.
//

#import <UIKit/UIKit.h>

//delegateを定義
@protocol PaletteDelegate<NSObject>

//delegateメソッドを宣言
-(void)returnSelectedValue:(int)back color:(int)color figure:(int)figure size:(int)size;

@end
@interface PaletteViewController : UIViewController
{
 //  UISegmentedControl *SC;
}

@property(nonatomic, retain) IBOutlet UISegmentedControl *BackColor;
@property(nonatomic, retain) IBOutlet UISegmentedControl *StarColor;
@property(nonatomic, retain) IBOutlet UISegmentedControl *Star;
@property(nonatomic, retain) IBOutlet UISegmentedControl *StarSize;
// デリゲート先で参照できるようにするためプロパティを定義しておく
@property (nonatomic, assign) id<PaletteDelegate> delegate;

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