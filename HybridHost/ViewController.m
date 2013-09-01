//
//  ViewController.m
//  HybridHost
//
//  Created by Brion on 9/1/13.
//  Copyright (c) 2013 Brion Vibber. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadFirstPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Navbar button handlers

- (IBAction)menuButtonPushed:(id)sender {
}

- (IBAction)searchButtonPushed:(id)sender {
}

#pragma mark Toolbar button handlers

- (IBAction)backButtonPushed:(id)sender {
    [self.webView goBack];
}

- (IBAction)forwardButtonPushed:(id)sender {
    [self.webView goForward];
}

- (IBAction)languageButtonPushed:(id)sender {
}

- (IBAction)actionButtonPushed:(id)sender {
}

- (IBAction)bookmarkButtonPushed:(id)sender {
}

#pragma mark UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // FIXME check if we should pass off to an external browser
    // or internal native module
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"webView didFailLoadWithError: %@", error);
}

#pragma mark private methods

- (void)loadFirstPage {
    NSString *urlString = @"https://en.m.wikipedia.org/wiki/";
    [self loadURL:[NSURL URLWithString:urlString]];
}

- (void)loadURL:(NSURL *)url {
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}


@end
