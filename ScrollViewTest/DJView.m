//
//  DJView.m
//  ScrollViewTest
//
//  Created by sadmin on 1/27/14.
//  Copyright (c) 2014 DJMobileInc. All rights reserved.
//

#import "DJView.h"

@implementation DJView
int i=0;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        
        
    }
    return self;
    
}


- (void)drawRect:(CGRect)rect
{

    i++;    // Drawing code
   

    
    CGContextRef ctx1 =UIGraphicsGetCurrentContext();
    CGContextConcatCTM(ctx1, self.transform);
    

    CGColorRef wh = [[UIColor redColor]CGColor];
    CGContextSetStrokeColorWithColor(ctx1, wh);
    CGContextMoveToPoint(ctx1, 0, 0);
    CGContextAddLineToPoint(ctx1, 200, 200);
    CGContextStrokePath(ctx1);
    
    
    CGRect  r = CGRectApplyAffineTransform(rect,self.transform );

    //that gives a big image
    UIGraphicsBeginImageContextWithOptions(r.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(ctx, self.transform);
    
     CGContextSetStrokeColorWithColor(ctx, wh);
     CGContextMoveToPoint(ctx, 0, 0);
     CGContextAddLineToPoint(ctx, 200, 200);
     CGContextStrokePath(ctx);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    CGImageRef cgImg = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *img = [UIImage imageWithCGImage:cgImg];
    
     NSData * d = UIImageJPEGRepresentation(img, 0.8);
 
    
    [self save:d forFrame:i];
    UIGraphicsEndImageContext();

//    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
//    [image drawAtPoint:rect.origin];
//   
//    CGContextClipToRect(ctx1, rect);
//   UIImage *imageResult = UIGraphicsGetImageFromCurrentImageContext();
//     NSData * d = UIImageJPEGRepresentation(imageResult, 0.8);
//    [self save:d forFrame:i];
//     UIGraphicsEndImageContext();

}

-(void)save:(NSData *)data forFrame:(int)frame{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *fileArray = [fileManager URLsForDirectory:NSDocumentDirectory  inDomains:NSUserDomainMask];
    NSString *filePath = [NSString stringWithFormat:@"%@cache%d.jpg", [fileArray lastObject],frame];
    NSURL *fileUrl = [NSURL URLWithString:filePath];
    [data writeToURL:fileUrl atomically:YES];
}

@end
