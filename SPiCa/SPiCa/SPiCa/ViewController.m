//
//  ViewController.m
//  SPiCa
//
//  Created by 六反園　卓也 on 2014/09/05.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//背景画像の設定
- (void)viewDidLoad
{
    [super viewDidLoad];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"back2.jpg"]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//写真を撮る押下
- (IBAction)Camera:(id)sender {
    // カメラが利用できるか確認
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        // カメラかライブラリからの読込指定。カメラを指定。
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
        // トリミングをしない
        [imagePickerController setAllowsEditing:NO];
        // Delegate
        [imagePickerController setDelegate:self];
        
        // アニメーションをしてカメラUIを起動
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        NSLog(@"camera invalid.");
    }
}

- (IBAction)Album:(id)sender {
    //アルバムが利用できるか確認
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
       //ライブラリ指定
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
       //トリミングをしない
        [imagePickerController setAllowsEditing:NO];
        [imagePickerController setDelegate:self];
        //起動
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        NSLog(@"photo library invalid.");
    }
    
}


//// 写真撮影後、もしくはフォトライブラリでサムネイル選択後に呼ばれるDelegate
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    // オリジナル画像
//    UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
//    // 編集画像（いらない、送るのは全てオリジナル）
//    UIImage *editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
//    UIImage *saveImage;
//    
//    if(editedImage)
//    {
//        saveImage = editedImage;
//    }
//    else
//    {
//        saveImage = originalImage;
//    }
//    
//    //以下UIImageViewを配置して、保存をする動作
//    //サンプルではトリミングをONにしていたが、今回は必要ないので
//
//    //取得した画像を受け渡して、遷移する動作が入る
//    
//    
//    
//    
////    // UIImageViewに画像を設定、
////    self.pictureImage.image = saveImage;
////    
////    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
////    {
////        // カメラから呼ばれた場合は画像をフォトライブラリに保存してViewControllerを閉じる
////        UIImageWriteToSavedPhotosAlbum(saveImage, nil, nil, nil);
////        [self dismissViewControllerAnimated:YES completion:nil];
////    }
////    else
////    {
////        // フォトライブラリから呼ばれた場合はPopOverを閉じる（iPad用なのでいらない）
////        [popover dismissPopoverAnimated:YES];
////        [popover release];
////        popover = nil;
////    }
//}
//


@end
