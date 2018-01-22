//
//  Document.m
//  Editor
//
//  Created by Artem Boiko on 16.01.2018.
//  Copyright © 2018 Artem Boiko. All rights reserved.
//

#import "Document.h"

@interface Document ()

@end

@implementation Document

- (instancetype)init {
    self = [super init];
    if (self) {
        self.textString = [[NSAttributedString alloc]initWithString:@""];
    }
    return self;
}

+ (BOOL)autosavesInPlace {
    return YES;
}


- (void)makeWindowControllers {
    // Override to return the Storyboard file name of the document.
    [self addWindowController:[[NSStoryboard storyboardWithName:@"Main" bundle:nil] instantiateControllerWithIdentifier:@"Document Window Controller"]];
    
    NSMutableAttributedString *str = self.viewController.textView.textStorage;
    [str setAttributedString: self.textString];
    
    [self.viewController setImage:_saveArray];
}


- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    // Save text
    NSData *dataText;
    self.textString = self.viewController.textView.textStorage;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:NSRTFTextDocumentType
                                                                   forKey:NSDocumentTypeDocumentAttribute];
    dataText = [self.textString dataFromRange:NSMakeRange(0, [self.textString length])
                           documentAttributes:dict error:outError];
    if (!dataText && outError) {
        *outError = [NSError errorWithDomain:NSCocoaErrorDomain
                                        code:NSFileWriteUnknownError userInfo:nil];
    }
    
    //  Save image with NSKeyedArchiver
    
    NSArray *array = [[NSArray alloc]init];
    array = [self.viewController getImage];
    NSData *dataImage = [NSKeyedArchiver archivedDataWithRootObject:array];
    
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
    [dataDictionary setObject:dataImage forKey:@"dataImage"];
    [dataDictionary setObject:dataText forKey:@"dataText"];
    
    //   NSDictionary -> NSData
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataDictionary];
    
    return data;
    
}


- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    //    NSData -> NSDictionary
    
    NSDictionary *dataDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    BOOL readSuccess = NO;
    
    NSAttributedString *fileContents = [[NSAttributedString alloc]
                                        initWithData:[dataDictionary objectForKey:@"dataText"] options:NULL documentAttributes:NULL
                                        error:outError];
    
    if (!fileContents && outError) {
        *outError = [NSError errorWithDomain:NSCocoaErrorDomain
                                        code:NSFileReadUnknownError userInfo:nil];
    }
    if (fileContents) {
        readSuccess = YES;
        self.textString = fileContents;
    }
    
    //    Unarchive image with NSKeyedUnarchiver
    _saveArray = [NSKeyedUnarchiver unarchiveObjectWithData:[dataDictionary objectForKey:@"dataImage"]];
    
    
    return YES;
}

-(ViewController *) viewController {
    return (ViewController *)self.windowControllers[0].contentViewController;
}
@end
