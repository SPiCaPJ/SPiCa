//
//  ViewController.h
//  test0921
//
//  Created by takuya on 2014/09/21.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"PaletteViewController.h"

@interface editStarViewController : UIViewController<PaletteDelegate>

@property UIImage *picture;

@property int backColor;

@property int starColor;

@property int starKind;

@property int starSize;


@end
