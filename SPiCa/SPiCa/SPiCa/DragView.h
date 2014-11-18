//
//  DragView.h
//  test0921
//
//  Created by takuya on 2014/09/21.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DragView : UIImageView {
	CGPoint startLocation;
}

@property CGPoint center;
-(void)changeFigure:(NSInteger)figure ;

@end
