//
//  Document.h
//  Editor
//
//  Created by Artem Boiko on 16.01.2018.
//  Copyright © 2018 Artem Boiko. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ViewController.h"

@interface Document : NSDocument

@property (strong, nonatomic) NSAttributedString *textString;
@property (strong, nonatomic) NSMutableArray *saveArray;

-(ViewController *)viewController;


@end

