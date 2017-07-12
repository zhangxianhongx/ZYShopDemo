//
//  ConversationListViewController.m
//  ZYShopping
//
//  Created by zhangxianhonog on 17/5/21.
//  Copyright © 2017年 ybon. All rights reserved.
//

#import "ConversationListViewController.h"

@interface ConversationListViewController ()

@end

@implementation ConversationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.showRefreshHeader = YES;
    //首次进入加载数据
    [self tableViewDidTriggerHeaderRefresh];
}
/*!
 @method
 @brief 获取点击会话列表的回调
 @discussion 获取点击会话列表的回调后,点击会话列表用户可以根据conversationModel自定义处理逻辑
 @param conversationListViewController 当前会话列表视图
 @param conversationModel 会话模型
 @result
 */
- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel;{
    
}



@end
