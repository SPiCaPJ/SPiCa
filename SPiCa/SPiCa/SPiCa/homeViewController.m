//
//  ViewController.m
//  SPiCa
//
//  Created by 六反園　卓也 on 2014/09/05.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "homeViewController.h"
#import "editStarViewController.h"

@interface homeViewController ()

@end

//撮影もしくは選択された画像
UIImage *selectedImage;

@implementation homeViewController


- (void)viewDidLoad
{
//    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
    
    //戻るボタンの文字を変更
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"戻る";
    self.navigationItem.backBarButtonItem = backButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//ステータスバーの文字色を白に
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//メニュー画面が呼び出される度、画像回転
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:(M_PI / 180) * 360];
    
    rotationAnimation.duration = 300.0f;
    
    rotationAnimation.repeatCount = HUGE_VALF;
    
    [_starView.layer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
    
    
    //ナビゲーションバーを非表示
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
        //シミュレータでのテストのため画面遷移させる
        [self performSegueWithIdentifier:@"toEditStar" sender:self];

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


// 写真撮影後、もしくはフォトライブラリでサムネイル選択後に呼ばれるDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //モーダルを閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // オリジナル画像
    UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    // 編集画像（いらない、送るのは全てオリジナル）
    UIImage *editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    UIImage *saveImage;
    
    if(editedImage)
    {
        saveImage = editedImage;
    }
    else
    {
        saveImage = originalImage;
    }
    
    //以下UIImageViewを配置して、保存をする動作
    //サンプルではトリミングをONにしていたが、今回は必要ないので
    
    
    //次画面に送る用の画像をフィールド変数にセット
    selectedImage = saveImage;
    //取得した画像を受け渡して、遷移する動作が入る
    [self performSegueWithIdentifier:@"toEditStar" sender:self];
    
//    // UIImageViewに画像を設定、
//    self.pictureImage.image = saveImage;
//    
//    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//    {
//        // カメラから呼ばれた場合は画像をフォトライブラリに保存してViewControllerを閉じる
//        UIImageWriteToSavedPhotosAlbum(saveImage, nil, nil, nil);
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//    else
//    {
////        // フォトライブラリから呼ばれた場合はPopOverを閉じる（iPad用なのでいらない）
////        [popover dismissPopoverAnimated:YES];
////        [popover release];
////        popover = nil;
//    }
}

//画面遷移時
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
    
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"toEditStar"] ) {
        editStarViewController *editStarViewController = [segue destinationViewController];
        //遷移先ビューの変数に値を渡す
        editStarViewController.picture = selectedImage;
        
    }
}



@end
