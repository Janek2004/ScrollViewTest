//
//  DJViewController.m
//  ScrollViewTest
//
//  Created by sadmin on 1/25/14.
//  Copyright (c) 2014 DJMobileInc. All rights reserved.
//
#import "DJView.h"
#import "DJViewController.h"

@interface DJViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;
@property (strong,nonatomic)  IBOutlet UIView * allView;
@property (strong, nonatomic) IBOutlet DJView *paintView;

@end

@implementation DJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.scrollView.scrollEnabled = YES;
    self.backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    [self.allView setNeedsDisplay];
    [self.scrollView addSubview:self.allView];
  
    self.scrollView.delegate = self;

    self.scrollView.contentSize = self.allView.frame.size;
    self.scrollView.minimumZoomScale = 0.3;
    self.scrollView.maximumZoomScale = 2;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;  {
    
    return self.allView;
}

-(CGAffineTransform)getCurrentTransform{
    CGAffineTransform tr = CGAffineTransformMakeTranslation(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y);
     CGAffineTransform tr1 = CGAffineTransformMakeScale(self.scrollView.zoomScale, self.scrollView.zoomScale);
    
    CGAffineTransform tx = CGAffineTransformConcat(tr1, tr);
    return tx;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView;                                               {
    self.backgroundView.transform = self.allView.transform;
    self.paintView.transform =self.allView.transform;
    [self.paintView setNeedsDisplay];
    
    }// any offset changes

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    self.paintView.transform =self.allView.transform;
    self.backgroundView.transform = self.allView.transform;
    [self.paintView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
