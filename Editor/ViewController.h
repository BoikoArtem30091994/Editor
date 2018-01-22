//
//  ViewController.h
//  Editor
//
//  Created by Artem Boiko on 16.01.2018.
//  Copyright © 2018 Artem Boiko. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ImageFile.h"

@interface ViewController : NSViewController <NSCollectionViewDataSource, NSCollectionViewDelegate>


@property (weak) IBOutlet NSCollectionView *collectionView;
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property (weak) IBOutlet NSColorWell *colorPalette;

@property(strong, nonatomic) NSMutableArray *arrayCollection;
@property(strong, nonatomic) NSMutableArray *pastboardArray;
@property(strong, nonatomic) NSMutableArray<ImageFile*> *objectsArray;


-(void) downloadImages:(NSArray*) array;
-(void) downloadImagesPastboard:(NSArray*) arrayURLS;
-(NSMutableArray*) getImage;
-(void) setImage:(NSMutableArray*) array;
- (void)moveItemFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (IBAction)openBtn:(id)sender;
- (IBAction)deleteImageBtn:(id)sender;
- (IBAction)deleteAllImage:(id)sender;
- (IBAction)changeBackgroundColor:(id)sender;
- (IBAction)defaultSettings:(id)sender;




@end

