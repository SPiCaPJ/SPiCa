//
//  editLineViewController.m
//  test0921
//
//  Created by takuya on 2014/09/22.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "editLineViewController.h"
#import "DragView.h"

@implementation editLineViewController
//ベースとなる画像
UIImageView *showImageView;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //ナビゲーションツールバーを除いた大きさの取得
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = CGRectGetWidth(screen);
    CGFloat screenHeight = CGRectGetHeight(screen);
    CGFloat statusBarHeight = 30;
    CGFloat navBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat availableHeight = screenHeight - statusBarHeight - navBarHeight;
    CGFloat availableWidth = screenWidth;
    
    //ここで渡された画像を表示
    showImageView = [[UIImageView alloc] init];
    showImageView.image = self.picture;
    //[showImageView setFrame:[[UIScreen mainScreen]applicationFrame]];
    
    showImageView.frame = CGRectMake(0, statusBarHeight + navBarHeight, availableWidth, availableHeight);
    
    showImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:showImageView];
    
    for (DragView *subview in self.stars) {
        NSLog(@"%f",subview.frame.origin.x);
        
    }
    
}
- (IBAction)closeView:(UIBarButtonItem *)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
    
}

// cancelボタンが押された時の処理
- (void)cancel
{
    return;
}

// saveボタンが押された時の処理
- (void)save
{
    ////保存する画像を指定
    //UIImage *image = [UIImage imageNamed:_imageName];
    //画像を保存する
    //UIImageWriteToSavedPhotosAlbum(showImageView, self, NULL, NULL);
    
    
    //次のアラート
    UIAlertController *alert2 =
    [UIAlertController alertControllerWithTitle:@"完了"
                                        message:@"画像を保存しました、SNSへ投稿しますか？" preferredStyle:UIAlertControllerStyleAlert];
    [alert2 addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                               style:UIAlertActionStyleDestructive
                                             handler:^(UIAlertAction *action) {
                                                 NSLog(@"Cancel pushed");
                                                 [self cancel];
                                             }]];
    
    [alert2 addAction:[UIAlertAction actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *action) {
                                                 NSLog(@"OK pushed");
                                                 [self activ];
                                                 
                                             }]];
    
    [self presentViewController:alert2 animated:YES completion:nil];
}

// activボタンが押された時の処理
- (void)activ
{
    //投稿するテキスト
    NSString *sharedText = @"テキスト #SPiCa";
    //投稿するコンテンツ、ここに画像を記載
    NSArray *activityItems = @[sharedText];
    
    //連携できるアプリの取得
    UIActivity *activity = [[UIActivity alloc] init];
    NSArray *appActivivities = @[activity];
    
    //アクティビティ作成
    UIActivityViewController *activityVC =[[UIActivityViewController alloc]
                                           initWithActivityItems:
                                           activityItems
                                           applicationActivities:
                                           appActivivities];
    //表示
    [self presentViewController:activityVC animated:YES completion:nil];
}

//完了ボタン
- (IBAction)actionsocial:(id)sender {
    
    //最初のアラート
    UIAlertController *alert1 =
    [UIAlertController alertControllerWithTitle:@"確認"
                                        message:@"加工を終了して、画像を保存しますか？" preferredStyle:UIAlertControllerStyleAlert];
    
    //押されたときのハンドラ
    [alert1 addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction *action) {
                                          
                                                
                                                NSLog(@"Cancel pushed");
                                                 [self cancel];
                                            }]];
    [alert1 addAction:[UIAlertAction actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *action) {
                                                 NSLog(@"OK pushed");
                                                 [self save];
                                             }]];
    
    //アラート表示
    [self presentViewController:alert1 animated:YES completion:nil];
    

    }
@end

