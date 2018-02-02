//
//  ToolbarWindowController.h
//  Editor
//
//  Created by Artem on 1/30/18.
//  Copyright © 2018 Artem Boiko. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WebViewController.h"

@interface ToolbarWindowController : NSWindowController <NSToolbarDelegate>

-(WebViewController *) webViewController;


@end
