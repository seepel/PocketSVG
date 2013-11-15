//
//  ViewController.m
//
//  Copyright (c) 2013 Ponderwell, Ariel Elkin, and Contributors
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "PocketSVG.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    //1: Create a PocketSVG object from your SVG file:
    PocketSVG *myVectorDrawing = [[PocketSVG alloc] initFromSVGFileNamed:@"BezierCurve1"];
    
    
    //2: Its bezier property is the corresponding UIBezierPath:
    UIBezierPath *myBezierPath = myVectorDrawing.bezier;
    [myBezierPath applyTransform:CGAffineTransformMakeTranslation(-myBezierPath.bounds.origin.x, -myBezierPath.bounds.origin.y)];
    
    
    //3: To display it on screen, create a CAShapeLayer and set 
    //the CGPath property of the above UIBezierPath as its 
    //path. 
    CAShapeLayer *myShapeLayer = [CAShapeLayer layer];
    myShapeLayer.path = myBezierPath.CGPath;
    
    
    //4: Fiddle with it using CAShapeLayer's properties:
    myShapeLayer.strokeColor = [[UIColor redColor] CGColor];
    myShapeLayer.lineWidth = 4;
    myShapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    
    //5: Display it!
    [self.view.layer addSublayer:myShapeLayer];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
