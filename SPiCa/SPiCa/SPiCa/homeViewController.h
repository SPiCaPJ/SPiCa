//
//  ViewController.h
//  SPiCa
//
//  Created by 六反園　卓也 on 2014/09/05.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate>
{
    UIPopoverController *popover;

}
@property (weak, nonatomic) IBOutlet UIImageView *starView;

@property (weak, nonatomic) IBOutlet UIImageView *line;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;


//カメラを起動する
- (IBAction)Camera:(id)sender;

//アルバムを起動する
- (IBAction)Album:(id)sender;

@end
