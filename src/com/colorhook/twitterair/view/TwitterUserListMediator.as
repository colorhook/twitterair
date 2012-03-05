/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	
	import com.colorhook.twitterair.controller.TwitterServiceEvent;
	import com.colorhook.twitterair.model.SystemModel;
	import com.colorhook.twitterair.services.ILogService;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class TwitterUserListMediator extends Mediator{
		
		[Inject]public var twitterList:TwitterUserList;
		[Inject]public var systemModel:SystemModel;
		[Inject]public var logService:ILogService;
		
		override public function onRegister():void{
			logService.info("TwitterUserListMediator onRegister");
			eventMap.mapListener(twitterList,UIEvent.FOLLOW_USER,followUser);
			eventMap.mapListener(twitterList,UIEvent.UNFOLLOW_USER,unfollowUser);
			eventMap.mapListener(twitterList,UIEvent.BLOCK_USER,blockUser);
			eventMap.mapListener(twitterList,UIEvent.UNBLOCK_USER,unblockUser);
			eventMap.mapListener(twitterList,UIEvent.BROWSE_USER,browseUser);
		}
		private function followUser(event:UIEvent):void{
			var event2:TwitterServiceEvent=new TwitterServiceEvent(
				TwitterServiceEvent.FOLLOW_USER);
			event2.screenName=event.screenName;
			this.dispatch(event2);
		}
		private function unfollowUser(event:UIEvent):void{
			var event2:TwitterServiceEvent=new TwitterServiceEvent(
				TwitterServiceEvent.UNFOLLOW_USER);
			event2.screenName=event.screenName;
			this.dispatch(event2);
		}
		private function blockUser(event:UIEvent):void{
			var event2:TwitterServiceEvent=new TwitterServiceEvent(
				TwitterServiceEvent.BLOCK_USER);
			event2.screenName=event.screenName;
			this.dispatch(event2);
		}
		private function unblockUser(event:UIEvent):void{
			var event2:TwitterServiceEvent=new TwitterServiceEvent(
				TwitterServiceEvent.UNBLOCK_USER);
			event2.screenName=event.screenName;
			this.dispatch(event2);
		}
		private function browseUser(event:UIEvent):void{
			var event2:UIEvent=new UIEvent(UIEvent.BROWSE_USER);
			event2.screenName=event.screenName;
			this.dispatch(event2);
		}
	}
}