//
//  ViewController.m
//  test0921
//
//  Created by takuya on 2014/09/21.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "editStarViewController.h"
#import "DragView.h"
#import "editLineViewController.h"
#import "PaletteViewController.h"
// opencv の import
#import <opencv2/opencv.hpp>
#import <opencv2/highgui/ios.h>
#import <opencv2/legacy/legacy.hpp>
#import <opencv2/opencv_modules.hpp>

@interface editStarViewController ()

@end

//ベースとなる画像
UIImageView *showImageView;
//貼付け中の画像
DragView *currentStampView;
//貼付け中かどうか
BOOL _isPressStamp;
//前画面から受け取る画像
UIImage *picture;

NSInteger tagNo;

NSMutableArray *stars;
CGRect  screen;
CGFloat screenWidth;
CGFloat screenHeight;
CGFloat statusBarHeight;
CGFloat navBarHeight;
CGFloat availableHeight;
CGFloat availableWidth;

int starCount;


const int STAR_SIZE_SMALL = 20;
const int STAR_SIZE_MIDDLE = 30;
const int STAR_SIZE_BIG = 40;

@implementation editStarViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //初期化
    stars = [NSMutableArray array];
    tagNo = 1;
    self.backColor = 0;
    self.starColor = 0;
    self.starKind = 0;
    self.starSize = 1;
    starCount = 0;
    
    //戻るボタンの文字を変更
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @"戻る";
    self.navigationItem.backBarButtonItem = backButton;
    
    
    //ナビゲーションツールバーを除いた大きさの取得
    screen = [[UIScreen mainScreen] bounds];
    screenWidth = CGRectGetWidth(screen);
    screenHeight = CGRectGetHeight(screen);
    statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    navBarHeight = self.navigationController.navigationBar.bounds.size.height;
    availableHeight = screenHeight - statusBarHeight - navBarHeight;
    availableWidth = screenWidth;
    
    self.view.frame = CGRectMake(0, statusBarHeight + navBarHeight, availableWidth, availableHeight);
    
    showImageView = [[UIImageView alloc] init];
    
    
    //背景画像の追加
    UIImageView *backView;
    backView.contentMode = UIViewContentModeScaleAspectFit;
    backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back1.png"]];
    
    
    backView.tag = -1;
    [self.view addSubview:backView];
    [self.view sendSubviewToBack:backView];
    
    showImageView.contentMode = UIViewContentModeScaleAspectFit;
    showImageView.image = [self regionSegmentation:self.picture];
    
    cv::Mat mat = [self matWithImage:showImageView.image];
    
    // グレイスケール化してから大津法で二値化
    cv::cvtColor(mat, mat, CV_BGR2GRAY);
    cv::threshold(mat, mat, 0, 255, cv::THRESH_BINARY|cv::THRESH_OTSU);
    showImageView.image = MatToUIImage(mat);
    
    
    //透過させる
    showImageView.alpha = 0.08;
    
    showImageView.frame = CGRectMake(0, statusBarHeight + navBarHeight, availableWidth, availableHeight);
    showImageView.contentMode = UIViewContentModeScaleAspectFit;
    showImageView.tag = 0;
    //表示
    [self.view addSubview:showImageView];
    
    //初期化
    currentStampView = nil;
    _isPressStamp = NO;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//ダブルタップされたときに呼ばれる
- (void)doubleTap:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded){
        [recognizer.view removeFromSuperview];
        //星の座標をなんか消したい(stars)
       
        
        starCount -= 1;
    }
}

//タッチされたとき
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    //タッチされた座標を取得
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    //星のオブジェクトの作成
    currentStampView = [self MakeStar:point];
    currentStampView.center = point;
    //タッチされているビューを識別するためにタグをつける
    currentStampView.userInteractionEnabled = YES;
    currentStampView.tag = tagNo;
    tagNo += 1;
    
    
    
    //既に配置されたビュー以外がタッチされた場合
    if(touch.view.tag != currentStampView.tag){
        //星の数が50個以上の場合は配置しない
        if(starCount > 50) return;
        //スタンプを貼付ける
        UITapGestureRecognizer *doubleTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(doubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [currentStampView addGestureRecognizer:doubleTap];
        
        [self.view addSubview:currentStampView];
        starCount += 1;
        _isPressStamp = YES;
        
    }
    
}

//タッチされがまま移動するとき
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //タッチされた座標を取得
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    currentStampView.center = point;
    
    //スタンプの位置を変更する
    if(_isPressStamp){
        if(self.starSize == 0)
        {
            currentStampView.frame = CGRectMake(point.x - STAR_SIZE_SMALL / 2, point.y - STAR_SIZE_SMALL / 2, STAR_SIZE_SMALL,STAR_SIZE_SMALL);
        }
        else if (self.starSize == 1)
        {
            currentStampView.frame = CGRectMake(point.x - STAR_SIZE_MIDDLE / 2, point.y - STAR_SIZE_MIDDLE / 2, STAR_SIZE_MIDDLE,STAR_SIZE_MIDDLE);
        }
        else
        {
            currentStampView.frame = CGRectMake(point.x - STAR_SIZE_BIG / 2, point.y - STAR_SIZE_BIG / 2, STAR_SIZE_BIG,STAR_SIZE_BIG);
        }
    }
}

//タッチが終了したとき
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // スタンプモード終了（スタンプを確定する）
    //　hashmapにidをキーにしてcurrentStampViewを格納
    _isPressStamp = NO;
}

//タッチがキャンセルされたとき
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    // スタンプモード終了（スタンプを確定する）
    _isPressStamp = NO;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Segueの特定    
    if ( [[segue identifier] isEqualToString:@"toEditLine"] ) {
        editLineViewController *editLineViewController = [segue destinationViewController];

        [self listSubviewsOfView:self.view];
        UIView* starView = [[UIView alloc] initWithFrame:CGRectMake(0, statusBarHeight + navBarHeight, availableWidth, availableHeight)];
        UIColor *color_ = [UIColor darkGrayColor];
        UIColor *alphaColor_ = [color_ colorWithAlphaComponent:0.0]; //透過率
        starView.backgroundColor = alphaColor_;
    
        
        for(DragView *subview in stars){
           [subview removeFromSuperview];
        　　[starView addSubview:subview];
         }
        
        
        picture = [self captureImage:starView];
        //picture = [self captureImage];
        editLineViewController.picture = picture;
        editLineViewController.backGround =[self captureImage:self.view];
        editLineViewController.stars = stars;
  
        
        for(DragView *subview in stars){
           [self.view addSubview:subview];
        }
        
    }
    else if ([[segue identifier] isEqualToString:@"toPalette"] ){
        PaletteViewController *paletteViewController = [segue destinationViewController];
        paletteViewController.delegate = self;
        paletteViewController.int_Back_color = self.backColor;
        paletteViewController.int_Star_color = self.starColor;
        paletteViewController.int_Star_obj = self.starKind;
        paletteViewController.int_Star_size = self.starSize;
    }
}



//重なっているビューの中のDragViewのみをリストに入れるメソッド
- (void)listSubviewsOfView:(UIView *)view {
    
    [stars removeAllObjects];
    
    // Get the subviews of the view
    NSArray *subviews = [view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0) return;
    
    for (DragView *subview in subviews) {
        
        if(subview.tag > 0){
            
            
            [stars addObject:subview];
        }
        
    }
}

//重なっているビューを一つのUIimageとして返すメソッド
-(UIImage *)captureImage:(UIView *)view
{
    // 描画領域の設定
    CGSize size = CGSizeMake(showImageView.frame.size.width , showImageView.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    // グラフィックスコンテキスト取得
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // コンテキストの位置を切り取り開始位置に合わせる
    CGPoint point = showImageView.frame.origin;
    CGAffineTransform affineMoveLeftTop
    = CGAffineTransformMakeTranslation(
                                       -(int)point.x ,
                                       -(int)point.y );
    CGContextConcatCTM(context , affineMoveLeftTop );
    
    // viewから切り取る
    [(CALayer*)view.layer renderInContext:context];
    
    // 切り取った内容をUIImageとして取得
    UIImage *cnvImg = UIGraphicsGetImageFromCurrentImageContext();
    
    // コンテキストの破棄
    UIGraphicsEndImageContext();
    
    return cnvImg;
}


//画像を領域分割するメソッド
-(UIImage *)regionSegmentation:(UIImage *)image{
    
    //領域分割
    CvRect roi;
    CvMemStorage *storage = 0;
    CvSeq *comp = 0;
    storage = cvCreateMemStorage (0);
    IplImage *ipImage = [self IplImageFromUIImage:image];
    roi.x = roi.y = 0;
    roi.width = ipImage->width & -(1 << 4);
    roi.height = ipImage->height & -(1 << 4);
    cvSetImageROI (ipImage, roi);
    IplImage *dst_img = cvCloneImage (ipImage);
    //領域分割をするopenCvのメソッド
    cvPyrSegmentation (ipImage, dst_img, storage, &comp, 4, 255.0, 100.0);
    cvReleaseMemStorage (&storage);
    return [self UIImageFromIplImage:dst_img];

}

//UIImageからIplImageを作成するメソッド
- (IplImage*)IplImageFromUIImage:(UIImage*)image
{
    CGImageRef imageRef = image.CGImage;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    IplImage *iplimage = cvCreateImage(cvSize(image.size.width,image.size.height), IPL_DEPTH_8U, 4 );
    
    CGContextRef contextRef = CGBitmapContextCreate(
                                                    iplimage->imageData,
                                                    iplimage->width,
                                                    iplimage->height,
                                                    iplimage->depth,
                                                    iplimage->widthStep,
                                                    colorSpace,
                                                    kCGImageAlphaPremultipliedLast|kCGBitmapByteOrderDefault);
    CGContextDrawImage(contextRef,
                       CGRectMake(0, 0, image.size.width, image.size.height),
                       imageRef);
    
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    IplImage *ret = cvCreateImage(cvGetSize(iplimage), IPL_DEPTH_8U, 3);
    cvCvtColor(iplimage, ret, CV_RGBA2BGR);
    cvReleaseImage(&iplimage);
    
    return ret;
}

//iplimageからuiimageを作成するメソッド
- (UIImage*)UIImageFromIplImage:(IplImage*)image
{
    CGColorSpaceRef colorSpace;
    if (image->nChannels == 1)
    {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
        //BGRになっているのでRGBに変換
        cvCvtColor(image, image, CV_BGR2RGB);
    }
    NSData *data = [NSData dataWithBytes:image->imageData length:image->imageSize];
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    CGImageRef imageRef = CGImageCreate(image->width,
                                        image->height,
                                        image->depth,
                                        image->depth * image->nChannels,
                                        image->widthStep,
                                        colorSpace,
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,
                                        provider,
                                        NULL,
                                        false,
                                        kCGRenderingIntentDefault
                                        );
    UIImage *ret = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return ret;
}

//uiimageをmatに変換するメソッド
- (cv::Mat)matWithImage:(UIImage*)image
{
    // 画像の回転を補正する（内蔵カメラで撮影した画像などでおかしな方向にならないようにする）
    UIImage* correctImage = image;
    UIGraphicsBeginImageContext(correctImage.size);
    [correctImage drawInRect:CGRectMake(0, 0, correctImage.size.width, correctImage.size.height)];
    correctImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // UIImage -> cv::Mat
    cv::Mat mat;
    
    UIImageToMat(correctImage, mat);
    return mat;
}

//星のオブジェクトを作成するメソッド
-(DragView*)MakeStar :(CGPoint)point {
    
    DragView* returnView;
    
    //サイズを指定してオブジェクトを作成
    if(self.starSize == 0){
        returnView = [[DragView alloc] initWithFrame:CGRectMake(point.x-STAR_SIZE_SMALL / 2, point.y - STAR_SIZE_SMALL / 2, STAR_SIZE_SMALL, STAR_SIZE_SMALL)];
    }else if(self.starSize == 1){
        returnView = [[DragView alloc] initWithFrame:CGRectMake(point.x - STAR_SIZE_MIDDLE / 2, point.y - STAR_SIZE_MIDDLE / 2, STAR_SIZE_MIDDLE, STAR_SIZE_MIDDLE)];
    }else{
        returnView = [[DragView alloc] initWithFrame:CGRectMake(point.x - STAR_SIZE_BIG / 2, point.y- STAR_SIZE_BIG / 2, STAR_SIZE_BIG, STAR_SIZE_BIG)];
    }
    
    //形の変更
    UIImage *originImage;
    if(self.starKind == 0) originImage = [UIImage imageNamed:@"hoshi01.png"];
    else if (self.starKind == 1 ) originImage = [UIImage imageNamed:@"hoshi12.png"];
    else originImage = [UIImage imageNamed:@"hoshi21.png"];
    
    //星の色を変更
    UIColor* monochromeColor;
    
    if(self.starColor == 0) monochromeColor= [UIColor yellowColor];
    else if (self.starColor == 1) monochromeColor= [UIColor cyanColor];
    else if (self.starColor == 2) monochromeColor= [UIColor redColor];
    else if (self.starColor == 3) monochromeColor= [UIColor greenColor];
    else if (self.starColor == 4) monochromeColor= [UIColor whiteColor];
    
    CIImage* ciImage = [[CIImage alloc]initWithImage:originImage];
    CIColor* ciColor = [[CIColor alloc]initWithColor:monochromeColor];
    NSNumber* nsIntensity = @1.0f;
    CIContext* ciContext = [CIContext contextWithOptions:nil];
    CIFilter* ciMonochromeFilter = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues:kCIInputImageKey,ciImage,@"inputColor",ciColor,@"inputIntensity",nsIntensity,nil];
    CGImageRef cgMonochromeimage = [ciContext createCGImage:ciMonochromeFilter.outputImage fromRect:[ciMonochromeFilter.outputImage extent]];
    returnView.image = [UIImage imageWithCGImage:cgMonochromeimage scale:originImage.scale orientation:UIImageOrientationUp];
    CGImageRelease(cgMonochromeimage);
    
    return returnView;
}






//デリゲートメソッドを実装
-(void)returnSelectedValue:(int)back color:(int)color figure:(int)figure size:(int)size{
    self.backColor = back;
    self.starColor = color;
    self.starKind = figure;
    self.starSize = size;
    
    // Get the subviews of the view
    NSArray *subviews = [self.view subviews];
    
    // Return if there are no subviews
    if ([subviews count] == 0) return;
    
    for (DragView *subview in subviews) {
        if(subview.tag == -1){
            [subview removeFromSuperview];
        }
    }
    
    UIImageView *backView;
    if(back ==0) backView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back1.png"]];
    else if(back == 1) backView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back2.png"]];
    else if(back == 2) backView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back3.png"]];
    else if(back == 3) backView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back4.png"]];
    else backView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back5.png"]];

    backView.contentMode = UIViewContentModeScaleAspectFit;
    backView.tag = -1;
    [self.view addSubview:backView];
    [self.view sendSubviewToBack:backView];
     
}


@end

