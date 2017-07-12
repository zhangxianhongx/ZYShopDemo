//
//  CheatViewController.h
//  环信Demo
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 mada. All rights reserved.
//

#import "EaseMessageViewController.h"

@interface CheatViewController : EaseMessageViewController <EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource>
@property (nonatomic, strong) NSString *sendImgUrl;
@property (nonatomic, strong) NSString *selfImgUrl;
/**
 CheatViewController *chatController = [[CheatViewController alloc]initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
 chatController.title = conversationModel.title;
 [self.navigationController pushViewController:chatController animated:YES];
 */
- (void)showMenuViewController:(UIView *)showInView
                  andIndexPath:(NSIndexPath *)indexPath
                   messageType:(EMMessageBodyType)messageType;

@end
