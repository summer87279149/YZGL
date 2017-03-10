//
//  PIDrawerView.m
//  PIImageDoodler
//
//  Created by Pavan Itagi on 07/03/14.
//  Copyright (c) 2014 Pavan Itagi. All rights reserved.
//

#import "PIDrawerView.h"
#import "RSColorPickerView.h"
#import "RSColorFunctions.h"
#import "RSBrightnessSlider.h"
#import "RSOpacitySlider.h"


#define draw_width [[UIScreen mainScreen] bounds].size.width
#define draw_height 550
#define draw_tool_height 50

@interface PIDrawerView ()<RSColorPickerViewDelegate>
{
    CGPoint previousPoint;
    CGPoint currentPoint;
    NSArray *colorArr;
    NSArray *paintWidthArr;
    NSArray *rubberWidthArr;
    CGPoint previousPoint2; //2 points behind
    CGPoint previousPoint1; //1 point behind
    CGPoint lastPoint;
    BOOL mouseSwiped;
    int mouseMoved;
    BOOL testHits;
}
@property (nonatomic, strong) UIImage * viewImage;
@property (nonatomic, strong) RSColorPickerView *colorPicker;
@property (nonatomic, strong) RSBrightnessSlider *brightnessSlider;
@property (nonatomic, strong) RSOpacitySlider *opacitySlider;
@property (nonatomic, strong) UIView *colorPatch;
@property (nonatomic, strong)UIView *colorView;

@end

@implementation PIDrawerView


-(UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if(testHits){
        return nil;
    }
    
//    if(!self.passthroughViews
//       || (self.passthroughViews && self.passthroughViews.count == 0)){
//        return self;
//    } else {
    
        UIView *hitView = [super hitTest:point withEvent:event];
        
        if (hitView == self) {
            //Test whether any of the passthrough views would handle this touch
            testHits = YES;
            CGPoint superPoint = [self.superview convertPoint:point fromView:self];
            UIView *superHitView = [self.superview hitTest:superPoint withEvent:event];
            testHits = NO;
            
            if ([self isPassthroughView:superHitView]) {
                hitView = superHitView;
            }
        }
        
        return hitView;
//    }
}

- (BOOL)isPassthroughView:(UIView *)view {
    
    if (view == nil) {
        return NO;
    }
    
    if ([self.passthroughViews containsObject:view]) {
        return YES;
    }
    
    return [self isPassthroughView:view.superview];
}

-(void) dealloc{
    self.passthroughViews = nil;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

- (void)drawRect:(CGRect)rect
{
    [self.viewImage drawInRect:self.bounds];
}


#pragma mark - setter methods
- (void)setDrawingMode:(DrawingMode)drawingMode
{
    _drawingMode = drawingMode;
}

#pragma mark - Private methods
- (void)initialize
{
    
    
    _paintColor = [UIColor redColor];
    [self colorPickerInit];
    previousPoint2 = CGPointZero; //2 points behind
    previousPoint1 = CGPointZero; //1 point behind
    lastPoint = CGPointZero;
    mouseSwiped = NO;
    mouseMoved = 0;
    
    currentPoint = CGPointMake(0, 0);
    previousPoint = currentPoint;
    
    _drawingMode = DrawingModePaint;
    _rubberWidth=5;
    _paintWidth=1;
    
    
    colorArr = [[NSArray alloc]initWithObjects:[UIColor blackColor],[UIColor redColor],[UIColor blueColor],[UIColor greenColor], nil];
    paintWidthArr =[[NSArray alloc]initWithObjects:@"1",@"3",@"10", nil];
    
    rubberWidthArr =[[NSArray alloc]initWithObjects:@"5",@"10",@"60", nil];
    
    
    UIView *huabiView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, draw_width, draw_tool_height)];
    
    int x = 10;
    int y = 10;
    
    _colorPatch = [[UIView alloc] initWithFrame:CGRectMake(x, y, 40, 40)];
    _colorPatch.layer.cornerRadius=20;
    [huabiView addSubview:_colorPatch];
    UIButton *colorSelectBtn =[[UIButton alloc]initWithFrame:_colorPatch.frame];
    [colorSelectBtn addTarget:self action:@selector(colorViewHidden:) forControlEvents:UIControlEventTouchUpInside];
    [huabiView addSubview:colorSelectBtn];
    x+=40;
    UIImageView * widthImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"draw_width"]];
    widthImage.width = 40;
    widthImage.height = 40;
    widthImage.originX =x;
    widthImage.originY =9;
    widthImage.contentMode = UIViewContentModeCenter;
    [huabiView addSubview:widthImage];
    x+=40;
    
    for (int i=0; i<paintWidthArr.count; i++) {
        UIButton *paintWidthBtn = [[UIButton alloc]init];
        [paintWidthBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"draw_width_%d",i+1]] forState:UIControlStateNormal];
        [paintWidthBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"draw_width_%d_s",i+1]] forState:UIControlStateSelected];
        paintWidthBtn.tag = 20+i;
        [paintWidthBtn addTarget:self action:@selector(paintWidth:) forControlEvents:UIControlEventTouchUpInside];
        paintWidthBtn.frame = CGRectMake(x, y, 40, 40);
        paintWidthBtn.layer.masksToBounds = YES;
        paintWidthBtn.layer.cornerRadius =paintWidthBtn.frame.size.width/2;
        [huabiView addSubview:paintWidthBtn];
        x+=40;
    }
    
    x+=40;
    UIImageView * rubberImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"draw_rubber"]];
    rubberImage.width = 40;
    rubberImage.height = 40;
    rubberImage.originX =x;
    rubberImage.originY =9;
    rubberImage.contentMode = UIViewContentModeCenter;
    [huabiView addSubview:rubberImage];
    x+=40;
    
    for (int i=0; i<rubberWidthArr.count; i++) {
        UIButton *paintWidthBtn = [[UIButton alloc]init];
        [paintWidthBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"draw_width_%d",i+1]] forState:UIControlStateNormal];
        [paintWidthBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"draw_width_%d_s",i+1]] forState:UIControlStateSelected];
        paintWidthBtn.tag = 30+i;
        [paintWidthBtn addTarget:self action:@selector(rubberWidth:) forControlEvents:UIControlEventTouchUpInside];
        paintWidthBtn.frame = CGRectMake(x, y, 40, 40);
        paintWidthBtn.layer.masksToBounds = YES;
        paintWidthBtn.layer.cornerRadius =paintWidthBtn.frame.size.width/2;
        [huabiView addSubview:paintWidthBtn];
        x+=40;
    }
    
    [self addSubview:huabiView];
    UIButton *btn1 = (UIButton *)[self viewWithTag:10];
    UIButton *btn2 = (UIButton *)[self viewWithTag:20];
    btn1.selected = YES;
    btn2.selected = YES;
}




-(IBAction)paintColor:(UIButton *)sender
{
    [self clearBtnStatus];
    sender.selected = YES;
    _paintColor = colorArr[sender.tag-10];
    _drawingMode = DrawingModePaint;
    
    NSInteger colorIndex= [paintWidthArr indexOfObject:[NSString stringWithFormat:@"%ld",_paintWidth]];
    UIButton *btn = (UIButton *)[self viewWithTag:20+colorIndex];
    btn.selected = YES;
}
-(void)paintWidth:(UIButton *)sender
{
    [self clearBtnStatus];
    sender.selected = YES;
    _paintWidth = [paintWidthArr[sender.tag-20] integerValue];
    _drawingMode = DrawingModePaint;
    
    NSInteger colorIndex= [colorArr indexOfObject:_paintColor];
    UIButton *btn = (UIButton *)[self viewWithTag:10+colorIndex];
    btn.selected = YES;
}

-(void)rubberWidth:(UIButton *)sender
{
    [self clearBtnStatus];
    sender.selected = YES;
    _rubberWidth = [rubberWidthArr[sender.tag-30] integerValue];
    _drawingMode = DrawingModeErase;
}


-(void)clearBtnStatus
{
    for (int i=0; i<4; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:10+i];
        btn.selected = NO;
    }
    for (int i=0; i<3; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:20+i];
        btn.selected = NO;
    }
    for (int i=0; i<3; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:30+i];
        btn.selected = NO;
    }
}

- (void)eraseLine
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.viewImage drawInRect:self.bounds];
//    [self.viewImage drawInRect:CGRectMake(self.bounds.origin.x, self.bounds.origin.y+60, self.bounds.size.width, self.bounds.size.height-60)];
    
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _rubberWidth);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), previousPoint.x, previousPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    previousPoint = currentPoint;
    
    [self setNeedsDisplay];
}


- (void)drawLineNew
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.viewImage drawInRect:self.bounds];
//    [self.viewImage drawInRect:CGRectMake(self.bounds.origin.x, self.bounds.origin.y+60, self.bounds.size.width, self.bounds.size.height-60)];
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), _paintColor.CGColor);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _paintWidth);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), previousPoint.x, previousPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    previousPoint = currentPoint;
    
    [self setNeedsDisplay];
}

- (void)handleTouches
{
    if (self.drawingMode == DrawingModePaint) {
        [self drawLineNew];
    }
    else
    {
        [self eraseLine];
    }
}

#pragma mark - Touches methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _colorView.hidden= YES;
    CGPoint p = [[touches anyObject] locationInView:self];
    if (p.y<draw_tool_height) {
        return;
    }
    previousPoint = p;
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    
    lastPoint = [touch locationInView:self];
    
    if (lastPoint.y<draw_tool_height) {
        lastPoint.y = draw_tool_height;
    }
    
    previousPoint2 = lastPoint;
    previousPoint1 = lastPoint;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self];
    if (p.y<draw_tool_height) {
        return;
    }
    
    currentPoint = [[touches anyObject] locationInView:self];
    
    if (self.drawingMode == DrawingModePaint) {
        UITouch *touch = [touches anyObject];
        CGPoint currentPointTemp = [touch locationInView:self];
        [self updatePoint:currentPointTemp];
        
        if (!CGPointEqualToPoint(previousPoint2, CGPointZero))
        {
            [self drawCurve:NO];
        }
        mouseMoved++;
        if (mouseMoved == 10) {
            mouseMoved = 0;
        }
        mouseSwiped = YES;
    }
    else
    {
        [self eraseLine];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint p = [[touches anyObject] locationInView:self];
    if (p.y<draw_tool_height) {
        return;
    }
    currentPoint = [[touches anyObject] locationInView:self];
    
    if (self.drawingMode == DrawingModePaint) {
        UITouch *touch = [touches anyObject];
        CGPoint currentPointTemp = [touch locationInView:self];
        [self updatePoint:currentPointTemp];
        //for better performance
        if (!mouseSwiped)
        {
            if (!CGPointEqualToPoint(previousPoint2, CGPointZero))
            {
                [self drawCurve:YES];
            }
        }
        
        //for double tap to clean the image
        if ([touch tapCount]==2)
        {
//            self.viewImage = nil;
        }
    }
    else
    {
        [self eraseLine];
    }
}


CGPoint midPoint(CGPoint p1, CGPoint p2)
{
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

- (void)updatePoint:(CGPoint)newPoint {
    previousPoint2 = previousPoint1;
    previousPoint1 = lastPoint;
    lastPoint = newPoint;
}

-(void)drawLine:(CGPoint)fPoint toPoint:(CGPoint)tPoint controlPoint:(CGPoint)cPoint
{
    UIGraphicsBeginImageContext(self.frame.size);
    [self.viewImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _paintWidth);
//    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 0.0, 0.5, 1.0);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), _paintColor.CGColor);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), fPoint.x, fPoint.y);
    //for drawing curve
    CGContextAddQuadCurveToPoint(UIGraphicsGetCurrentContext(), cPoint.x, cPoint.y, tPoint.x, tPoint.y);
    //CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), tPoint.x, tPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setNeedsDisplay];
}

-(void)drawCurve:(BOOL)isFinal
{
    CGPoint mid1 = midPoint(previousPoint1, previousPoint2);
    CGPoint mid2 = midPoint(lastPoint, previousPoint1);
    
    //for drawing the beginning line
    if (!mouseSwiped)
    {
        CGPoint midTemp = midPoint(previousPoint2, mid1);
        [self drawLine:previousPoint2 toPoint:mid1 controlPoint:midTemp];
    }
    
    [self drawLine:mid1 toPoint:mid2 controlPoint:previousPoint1];
}


-(void)colorPickerInit
{
    _colorView = [[UIView alloc]initWithFrame:CGRectMake(20, 78, 250, 320)];
    _colorView.backgroundColor = [UIColor whiteColor];
    _colorView.layer.cornerRadius = 8;
    _colorView.layer.borderColor = [UIColor colorWithRed:0.965 green:0.682 blue:0.000 alpha:1.000].CGColor;
    _colorView.layer.borderWidth = 1;
    _colorView.hidden= YES;
    [self addSubview:_colorView];
    
    _colorPicker = [[RSColorPickerView alloc] initWithFrame:CGRectMake(25.0, 10.0, 200, 200)];
    _colorPicker.cropToCircle=YES;
    [_colorPicker setSelectionColor:_paintColor];
    [_colorPicker setBrightness:1.0];
    [_colorPicker setOpacity:1.0];
    [_colorPicker setDelegate:self];
    [_colorView addSubview:_colorPicker];
    
    // View that controls brightness
    _brightnessSlider = [[RSBrightnessSlider alloc] initWithFrame:CGRectMake(25, 220.0, 200, 30.0)];
    [_brightnessSlider setColorPicker:_colorPicker];
    [_colorView addSubview:_brightnessSlider];
    
    // View that controls opacity
    _opacitySlider = [[RSOpacitySlider alloc] initWithFrame:CGRectMake(25, 270.0, 200, 30.0)];
    [_opacitySlider setColorPicker:_colorPicker];
    [_colorView addSubview:_opacitySlider];
    
}


- (void)colorPickerDidChangeSelection:(RSColorPickerView *)cp {
    
    // Get color data
    UIColor *color = [cp selectionColor];
    CGFloat r, g, b, a;
    [[cp selectionColor] getRed:&r green:&g blue:&b alpha:&a];
    
    // Update important UI
    _colorPatch.backgroundColor = color;
    _brightnessSlider.value = [cp brightness];
    _opacitySlider.value = [cp opacity];
    _paintColor = color;
}

-(IBAction)colorViewHidden:(id)sender
{
    _colorView.hidden = !_colorView.hidden;
}


@end
