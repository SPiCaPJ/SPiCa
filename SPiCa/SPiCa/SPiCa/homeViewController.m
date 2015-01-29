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

NSTimer *tm;

UIAlertView *alert;

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

- (BOOL)canBecomeFirstResponder {
    return YES;
}


//メニュー画面が呼び出される度
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    //背景の回転処理
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat:(M_PI / 180) * 360];
    
    rotationAnimation.duration = 300.0f;
    
    rotationAnimation.repeatCount = HUGE_VALF;
    
    [_starView.layer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
    
    //10秒ごとに流れ星の処理を呼ぶ
    tm =
    [NSTimer
     scheduledTimerWithTimeInterval:10.0f
     target:self
     selector:@selector(hoge:)
     userInfo:nil
     repeats:YES
     ];
    
    
    //ナビゲーションバーを非表示
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

//メニュー画面が閉じるとき
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [tm invalidate];
    tm = nil;
    //くるくるを閉じる
    [alert dismissWithClickedButtonIndex:0 animated:NO];
    //ナビゲーションバーを表示
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//流れ星の処理
-(void)hoge:(NSTimer*)timer{
    _line.hidden = NO;
    
    _line.center = [self randomPoint];
    int hight =self.view.bounds.size.height;
    CGPoint aPoint;
    if(_line.center.x == 0)
    {
        aPoint = CGPointMake(self.view.bounds.size.width,arc4random()%hight);
    }
    else
    {
        aPoint = CGPointMake(0,arc4random()%hight);
    }
    
    CGFloat angle = atan2(aPoint.y - _line.center.y,aPoint.x - _line.center.x);
    _line.transform = CGAffineTransformMakeRotation(angle);
    
    
    [UIView animateWithDuration:0.1
                          delay:0
                        options:0
                     animations:^{
                         _line.center = aPoint;
                     }
                     completion:^(BOOL finished) {
                         _line.hidden = YES;
                         
                     }];
}





//流れ星の始点
-(CGPoint)randomPoint
{
    CGPoint pt;
    
    int hight = self.view.bounds.size.height;
    int y = arc4random()%hight;
    
    int isLeft = arc4random()%2;
    if(isLeft){
        pt = CGPointMake(0,y);
    }
    else{
        pt = CGPointMake(self.view.bounds.size.width  , y);
    }
    return pt;
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
    
    //くるくる
    
    alert = [[UIAlertView alloc]initWithTitle:nil
                                                  message:@"読み込み中"
                                                 delegate:nil
                                        cancelButtonTitle:nil
                                        otherButtonTitles:nil, nil];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
      indicator.color = [UIColor blueColor];
    [indicator startAnimating];
    
    [alert setValue:indicator forKey:@"accessoryView"];
    [alert show];

    // オリジナル画像
    UIImage *saveImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    //写真の向きどうりになるように画像を作り直す
    UIGraphicsBeginImageContext(saveImage.size);
    [saveImage drawInRect:CGRectMake(0, 0, saveImage.size.width, saveImage.size.height)];
    saveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //次画面に送る用の画像をフィールド変数にセット
    selectedImage = saveImage;
    //取得した画像を受け渡して、遷移する動作が入る
    [self performSegueWithIdentifier:@"toEditStar" sender:self];
    
    NSArray  *aOsVersions = [[[UIDevice currentDevice]systemVersion] componentsSeparatedByString:@"."];
    NSInteger iOsVersionMajor  = [[aOsVersions objectAtIndex:0] intValue];
    if (iOsVersionMajor <= 7)
    {
        [tm invalidate];
        tm = nil;
        //くるくるを閉じる
        [alert dismissWithClickedButtonIndex:0 animated:NO];
        //ナビゲーションバーを表示
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

//画面遷移時
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    //Segueの特定
    if ( [[segue identifier] isEqualToString:@"toEditStar"] ) {
        editStarViewController *editStarViewController = [segue destinationViewController];
        //遷移先ビューの変数に値を渡す
        editStarViewController.picture = selectedImage;
        
    }
}



@end
