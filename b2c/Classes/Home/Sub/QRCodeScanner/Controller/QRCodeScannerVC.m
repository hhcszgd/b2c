//
//  QRCodeScannerVC.m
//  b2c
//
//  Created by wangyuanfei on 4/11/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "QRCodeScannerVC.h"

#import <AVFoundation/AVFoundation.h>

@interface QRCodeScannerVC ()<AVCaptureMetadataOutputObjectsDelegate>
@property(nonatomic,strong) AVCaptureMetadataOutput *output  ;
@property(nonatomic,strong)  AVCaptureDevice *device ;
@property(nonatomic,strong)  AVCaptureDeviceInput *input  ;
@property(nonatomic,strong)   AVCaptureSession *session ;
@property(nonatomic,weak) AVCaptureVideoPreviewLayer *preview ;
@end

@implementation QRCodeScannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupAboutCamaro];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupAboutCamaro
{
    //获取一个AVCaptureDevice对象，可以理解为打开摄像头这样的动作
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.device = device;
    //设置闪光灯
    NSError *error;
    if (device.hasTorch) {  // 判断设备是否有闪光灯
        BOOL b = [device lockForConfiguration:&error];
        if (!b) {
            if (error) {
                NSLog(@"lock torch configuration error:%@", error.localizedDescription);
            }
            return;
        }
        device.torchMode = (device.torchMode == AVCaptureTorchModeOff ? AVCaptureTorchModeOn : AVCaptureTorchModeOff);
        [device unlockForConfiguration];
    }
    //获取一个AVCaptureDeviceInput对象，将上面的'摄像头'作为输入设备
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    self.input = input;
    //拍完照片以后，需要一个AVCaptureMetadataOutput对象将获取的'图像'输出，以便进行对其解析
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    self.output=output;
    //获取输出需要设置代理，在代理方法中获取
//    [output setMetadataObjectsDelegate:<#(id<AVCaptureMetadataOutputObjectsDelegate>)#> queue:<#(dispatch_queue_t)#>]
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置输出类型，如AVMetadataObjectTypeQRCode是二维码类型，下面还增加了条形码。如果扫描的是条形码也能识别
//    output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
//                                   AVMetadataObjectTypeEAN8Code,
//                                   AVMetadataObjectTypeCode128Code,
//                                   AVMetadataObjectTypeQRCode];
//    output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code,
//                                   AVMetadataObjectTypeEAN8Code,
//                                   AVMetadataObjectTypeCode128Code,
//                                   AVMetadataObjectTypeQRCode];
    //设置扫描框
    
    CGSize size = self.view.bounds.size;
    CGSize transparentAreaSize = CGSizeMake(200,200);
    CGRect cropRect = CGRectMake((size.width - transparentAreaSize.width)/2, (size.height - transparentAreaSize.height)/2, transparentAreaSize.width, transparentAreaSize.height);
    output.rectOfInterest = CGRectMake(cropRect.origin.y/size.width,
                                       cropRect.origin.x/size.height,
                                       cropRect.size.height/size.height,
                                       cropRect.size.width/size.width);
    
    
    //设置会话
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    self.session = session;
    [session setSessionPreset:AVCaptureSessionPresetHigh];//扫描的质量
    if ([session canAddInput:input]){
        [session addInput:input];//将输入添加到会话中
    }
    if ([session canAddOutput:output]){
        [session addOutput:output];//将输出添加到会话中
    }
    
    
    
    AVCaptureVideoPreviewLayer *preview =[AVCaptureVideoPreviewLayer layerWithSession:session];
    self.preview = preview;
    preview.videoGravity = AVLayerVideoGravityResize;
    [preview setFrame:self.view.bounds];//设置取景器的frame
    [self.view.layer insertSublayer:preview atIndex:0];
    
    
    
    
    [session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    [self.session stopRunning];//停止会话
    [self.preview removeFromSuperlayer];//移除取景器
    
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSString *result = obj.stringValue;//这就是扫描的结果啦
        LOG(@"_%@_%d_%@",[self class] , __LINE__,result)
        //对结果进行处理...
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//从图片中直接读取二维码的功能。主要用到的是读取主要用到CoreImage。
+ (NSString *)scQRReaderForImage:(UIImage *)qrimage{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *image = [CIImage imageWithCGImage:qrimage.CGImage];
    NSArray *features = [detector featuresInImage:image];
    CIQRCodeFeature *feature = [features firstObject];
    NSString *result = feature.messageString;
    return result;
}
//从相册获取照片主要用到的是UIImagePickerController，这是苹果给我们分装好的一个相册选取的控制器。实现起来也是很简单的。
- (void)readerImage{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;//遵守鞋业
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    photoPicker.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:photoPicker animated:YES completion:NULL];
}
//获取相册的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:^{
        //code is here ...
    }];
    
    UIImage *srcImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *result = [QRCodeScannerVC scQRReaderForImage:srcImage];//调用上面讲过的方法对图片中的二维码进行处理
    LOG(@"_%@_%d_%@",[self class] , __LINE__,result)
    [self.navigationController popViewControllerAnimated:YES];
}


//生成二维码和从图片中读取二维码一样要用到CoreImage,具体步骤如下：
- (UIImage *)makeQRCodeForString:(NSString *)string{
    NSString *text = string;
    NSData *stringData = [text dataUsingEncoding: NSUTF8StringEncoding];
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    //二维码颜色
    UIColor *onColor = [UIColor redColor];
    UIColor *offColor = [UIColor blueColor];
    //上色，如果只要白底黑块的QRCode可以跳过这一步
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:onColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:offColor.CGColor],
                             nil];
    //绘制
    CIImage *qrImage = colorFilter.outputImage;
    CGSize size = CGSizeMake(300, 300);
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage     fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);//生成的QRCode就是上下颠倒的,需要翻转一下
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    
    return [UIImage imageWithCIImage:qrImage];
}
@end
