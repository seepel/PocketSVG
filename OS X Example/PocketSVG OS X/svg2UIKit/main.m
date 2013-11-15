//
//  main.m
//  svg2UIKit
//
//  Created by Sean Lynch on 11/14/13.
//  Copyright (c) 2013 Ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PocketSVG.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        if(argc < 3) {
            NSLog(@"Usage svg2UIKit <file> <path variable name>");
            return -1;
        }
        NSString *filePath = [NSString stringWithCString:argv[1] encoding:NSASCIIStringEncoding];
        NSString *pathName = [NSString stringWithCString:argv[2] encoding:NSASCIIStringEncoding];
        
        PocketSVG *svg = [[PocketSVG alloc] initFromSVGFileAtPath:filePath];
        
        NSBezierPath *path = svg.bezier;
        
        path = [path bezierPathByReversingPath];
        
        NSAffineTransform *transform = [NSAffineTransform transform];
        [transform translateXBy:-path.bounds.origin.x yBy:-path.bounds.origin.y];
        [path transformUsingAffineTransform:transform];
        
        printf("%s", [[NSString stringWithFormat:@"UIBezierPath *%@ = [[UIBezierPath alloc] init];\n", pathName] cStringUsingEncoding:NSUTF8StringEncoding]);
        
        for(NSInteger i=0; i != path.elementCount; i++) {
            NSPoint points[3];
            NSBezierPathElement element = [path elementAtIndex:i associatedPoints:points];
            switch (element) {
                case NSMoveToBezierPathElement:
                    printf("%s", [[NSString stringWithFormat:@"[%@ moveToPoint:CGPointMake(%ff, %ff)];", pathName, points[0].x, points[0].y] cStringUsingEncoding:NSUTF8StringEncoding]);
                    break;
                    
                case NSCurveToBezierPathElement:
                    printf("%s", [[NSString stringWithFormat:@"[%@ addCurveToPoint:CGPointMake(%ff, %ff) controlPoint1:CGPointMake(%ff, %ff) controlPoint2:CGPointMake(%ff, %ff)];", pathName, points[2].x, points[2].y, points[0].x, points[0].y, points[1].x, points[1].y] cStringUsingEncoding:NSUTF8StringEncoding]);
                    break;
                    
                case NSLineToBezierPathElement:
                    printf("%s", [[NSString stringWithFormat:@"[%@ addLineToPoint:CGPointMake(%ff, %ff)];", pathName, points[0].x, points[0].y] cStringUsingEncoding:NSUTF8StringEncoding]);
                    break;
                    
                case NSClosePathBezierPathElement:
                    printf("%s", [[NSString stringWithFormat:@"[%@ closePath];", pathName] cStringUsingEncoding:NSUTF8StringEncoding]);
                    break;
                    
                default:
                    NSLog(@"Forgot something");
                    break;
            }
            printf("\n");
        }
        printf("\n");
    }
    return 0;
}

