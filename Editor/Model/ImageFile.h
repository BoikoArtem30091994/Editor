//
//  ImageFile.h
//  Editor
//
//  Created by Artem on 1/18/18.
//  Copyright © 2018 Artem Boiko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageFile : NSObject


#pragma mark File Properties

@property(copy) NSURL *url;
@property(copy) NSString *fileName;

@end
