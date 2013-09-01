//
//  ViewController.h
//  HybridHost
//
//  Created by Brion on 9/1/13.
//  Copyright (c) 2013 Brion Vibber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *languageButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bookmarkButton;

- (IBAction)menuButtonPushed:(id)sender;
- (IBAction)searchButtonPushed:(id)sender;

- (IBAction)backButtonPushed:(id)sender;
- (IBAction)forwardButtonPushed:(id)sender;
- (IBAction)languageButtonPushed:(id)sender;
- (IBAction)actionButtonPushed:(id)sender;
- (IBAction)bookmarkButtonPushed:(id)sender;

@end
