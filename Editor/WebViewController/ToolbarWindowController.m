//
//  ToolbarWindowController.m
//  Editor
//
//  Created by Artem on 1/30/18.
//  Copyright © 2018 Artem Boiko. All rights reserved.
//

#import "ToolbarWindowController.h"

@interface ToolbarWindowController ()

@end

@implementation ToolbarWindowController


-(void)awakeFromNib{
    // create the toolbar object
    NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:@"toolbarForWebView"];
    
    // set initial toolbar properties
    [toolbar setAllowsUserCustomization:YES];
    [toolbar setAutosavesConfiguration:YES];
    [toolbar setDisplayMode:NSToolbarDisplayModeIconAndLabel];
    
    // set our controller as the toolbar delegate
    [toolbar setDelegate:self];
    
    // attach the toolbar to our window
    [self.window setToolbar:toolbar];
    
    
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
}

- (NSArray *) toolbarAllowedItemIdentifiers: (NSToolbar *) toolbar {
    return [NSArray arrayWithObjects:
            @"MyBackButtonToolbarItem",
            @"MyNextButtonToolbarItem",
            @"MyCancelButtonToolbarItem",
            nil];
}

- (NSArray *) toolbarDefaultItemIdentifiers: (NSToolbar *) toolbar {
    return [NSArray arrayWithObjects:
            @"MyBackButtonToolbarItem",
            @"MyNextButtonToolbarItem",
            @"MyCancelButtonToolbarItem",
            NSToolbarCustomizeToolbarItemIdentifier,
            NSToolbarFlexibleSpaceItemIdentifier,
            nil];
}

-(NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSToolbarItemIdentifier)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
    
    
    NSToolbarItem *toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier: itemIdentifier];
    
    if ( [itemIdentifier isEqualToString:@"MyBackButtonToolbarItem"] ) {
        
        // Configuration code for "MyBackButtonToolbarItem"
        [toolbarItem setView: [[NSButton alloc]init]];
        [toolbarItem setMinSize:NSMakeSize(25, 25)];
        [toolbarItem setMaxSize:NSMakeSize(25, 25)];
        [toolbarItem setLabel:@"Back"];
        [toolbarItem setPaletteLabel:@"Back"];
        [toolbarItem setImage:[NSImage imageNamed:@"001-back"]];
        [toolbarItem setTarget:self];
        [toolbarItem setAction:@selector(backButtonPressed:)];
    
    } else if ( [itemIdentifier isEqualToString:@"MyNextButtonToolbarItem"] ) {
        
        // Configuration code for "MyNextButtonToolbarItem"
        [toolbarItem setView: [[NSButton alloc]init]];
        [toolbarItem setMinSize:NSMakeSize(25, 25)];
        [toolbarItem setMaxSize:NSMakeSize(25, 25)];
        [toolbarItem setLabel:@"Next"];
        [toolbarItem setPaletteLabel:@"Next"];
        [toolbarItem setImage:[NSImage imageNamed:@"002-next"]];
        [toolbarItem setTarget:self];
        [toolbarItem setAction:@selector(nextButtonPressed:)];
    
    } else if ( [itemIdentifier isEqualToString:@"MyCancelButtonToolbarItem"] ) {
        
        // Configuration code for "MyCancelButtonToolbar"
        [toolbarItem setView: [[NSButton alloc]init]];
        [toolbarItem setMinSize:NSMakeSize(25, 25)];
        [toolbarItem setMaxSize:NSMakeSize(25, 25)];
        [toolbarItem setLabel:@"Cancel"];
        [toolbarItem setPaletteLabel:@"Cancel"];
        [toolbarItem setImage:[NSImage imageNamed:@"001-cancel"]];
        [toolbarItem setTarget:self];
        [toolbarItem setAction:@selector(cancelButtonPressed:)];
        
    }
    
    return toolbarItem;

}

-(IBAction)backButtonPressed:(id)sender{
        [self.webViewController.webView goBack];
}

-(IBAction)nextButtonPressed:(id)sender{
    [self.webViewController.webView goForward];
}

-(IBAction)cancelButtonPressed:(id)sender{
    [self.webViewController.webView stopLoading];   
}

-(WebViewController *) webViewController {
    return (WebViewController *)self.window.contentViewController;
}

@end
