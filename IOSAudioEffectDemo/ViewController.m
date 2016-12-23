//
//  ViewController.m
//  IOSAudioEffectDemo
//
//  Created by Xinhou Jiang on 23/12/16.
//  Copyright © 2016年 Xinhou Jiang. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h> // System Sound Service

// 定义sound的ID
static SystemSoundID system_sound_id_0 = 0;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册声音ID
    [self registerSoundWithName:@"effect" andID:system_sound_id_0];
}

// 系统声音资源注册函数
- (void) registerSoundWithName: (NSString *)name andID:(SystemSoundID)sound_id {
    // 1.获取音频文件url
    NSString *audioFile=[[NSBundle mainBundle] pathForResource:name ofType:@"mp3"];
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
    // 2.将音效文件加入到系统音频服务中并返回一个长整形ID
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &system_sound_id_0);
    // 3.注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(system_sound_id_0, NULL, NULL, soundCompleteCallback, NULL);
}

// 声音播放完成回调
void soundCompleteCallback(SystemSoundID sound_id,void *data) {
    // 声音已经播放完成...
}

// 手机震动
- (IBAction)vibrate {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

// 播放短暂音频
- (IBAction)playShortMusic {
    AudioServicesPlaySystemSound(system_sound_id_0);  // 播放音效
    //AudioServicesPlayAlertSound(system_sound_id_0); // 播放音效并震动
}

@end
