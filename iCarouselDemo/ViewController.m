//
//  ViewController.m
//  iCarouselDemo
//
//  Created by Amit Jain on 24/11/14.
//  Copyright (c) 2014 ajonnet. All rights reserved.
//

#import "ViewController.h"
#import "iCarousel.h"

@interface ViewController () <iCarouselDataSource,iCarouselDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *iCarouselV;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.iCarouselV.wrapEnabled = YES;
    self.iCarouselV.type = iCarouselTypeLinear;
}

#pragma mark - iCarouselDataSource methods
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 4;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    static NSInteger lastIdx = -1;
    static NSInteger lastVal =0;
    
    if (lastIdx != -1) {
        
        NSInteger diff = index - lastIdx;
        
        if (diff == 1) {
            lastVal++;
        }else if(diff == -1) {
            lastVal--;
        }else if(diff > 0) {
            lastVal --;
        }else if(diff < 0) {
            lastVal++;
        }
    }
    
    UILabel *lbl = (UILabel *)view;
    if (!lbl) {
        NSLog(@"creating view for index %d",index);
        CGRect frm = CGRectMake(0, 0, carousel.frame.size.width, 20);
        frm.origin = carousel.center;
        lbl = [[UILabel alloc] initWithFrame:frm];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.backgroundColor = [UIColor whiteColor];
    }
    NSLog(@"%d",index);
    lbl.text = [NSString stringWithFormat:@"%d",lastVal];
    lbl.backgroundColor = (index%2)?[UIColor whiteColor]:[UIColor purpleColor];
    
    
    lastIdx = index;
    return lbl;
}

#pragma mark - iCarouselDelegate methods
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    CGFloat val = value;
    switch (option) {
        case iCarouselOptionWrap:
            val = 1;
            break;
            
        default:
            break;
    }
    
    return val;
}
@end
