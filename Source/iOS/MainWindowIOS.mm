/*
  ==============================================================================

    MainWindowIOS.mm
    Created: 14 Oct 2016 8:25:38pm
    Author:  Adam Wilson

  ==============================================================================
*/


#include "MainWindowIOS.h"

#import <UIKit/UIKit.h>
//#import <AVFoundation/AVFoundation.h>

//#import "RCTRootView.h"  // vanilla React Native
#import "RCCManager.h"     // React Native Navigation


//-----------------------------------------------------------

MainWindow::MainWindow (String name)  : DocumentWindow (name,
                                                        Colours::lightgrey,
                                                        DocumentWindow::allButtons)
{
    
    //------------------------------------------------------
    // React Native
    //------------------------------------------------------
    
    NSURL *jsCodeLocation;
    
    /**
     * Loading JavaScript code - uncomment the one you want.
     *
     * OPTION 1
     * Load from development server. Start the server from the repository root:
     *
     * $ npm start
     *
     * To run on device, change `localhost` to the IP address of your computer
     * (you can get this by typing `ifconfig` into the terminal and selecting the
     * `inet` value under `en0:`) and make sure your computer and iOS device are
     * on the same Wi-Fi network.
     */
    
#if JUCE_DEBUG
    jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
#else
    /**
     * OPTION 2
     * Load from pre-bundled file on disk. The static bundle is automatically
     * generated by "Bundle React Native code and images" build step.
     */

    jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
    
    /** 
     * React Native Navigation bootstrap
     */
  
    // Get reference to current JuceApplication instance
    NSObject<UIApplicationDelegate> *appDelegate = [[UIApplication sharedApplication] delegate];
    
    appDelegate.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    appDelegate.window.backgroundColor = [UIColor blackColor];
    [[RCCManager sharedInstance] initBridgeWithBundleURL:jsCodeLocation];
    

    /**
     * This is the bootstrap for "vanilla" React Native
     * without React Native Navigation
     *
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"ReactDrum"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = rootView;
    window.rootViewController = rootViewController;
    [window makeKeyAndVisible];
    
    */
}
    
void MainWindow::closeButtonPressed()
{
    // This is called when the user tries to close this window. Here, we'll just
    // ask the app to quit when this happens, but you can change this to do
    // whatever you need.
    JUCEApplication::getInstance()->systemRequestedQuit();
}

/**
 * Attach a JUCE Component to a Native iOS UIView
 */
void MainWindow::addComponentToUIView (Component& comp, void* uiView)
{
    comp.addToDesktop (0, uiView);
    UIView* view = (UIView*) uiView;
    comp.setVisible (true);
    comp.setBounds (view.bounds.origin.x, view.bounds.origin.y,
                    view.bounds.size.width, view.bounds.size.height);
}
