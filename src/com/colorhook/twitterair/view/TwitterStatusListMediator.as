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
	
	public class TwitterStatusListMediator extends Mediator{
		
		[Inject]public var twitterList:TwitterStatusList;
		[Inject]public var systemModel:SystemModel;
		[Inject]public var logService:ILogService;
		
		override public function onRegister():void{
			logService.info("TwitterStatusListMediator onRegister");
			eventMap.mapListener(twitterList,UIEvent.REPLY_TWITTER,replyTwitter);
			eventMap.mapListener(twitterList,UIEvent.RETWEET_TWITTER,retweetTwitter);
			eventMap.mapListener(twitterList,UIEvent.FAVORITE_TWITTER,favoriteTwitter);
			eventMap.mapListener(twitterList,UIEvent.DELETE_TWITTER,deleteTwitter);
			eventMap.mapListener(twitterList,UIEvent.BROWSE_USER,browseUser);
		}
		private function favoriteTwitter(event:UIEvent):void{
			var event2:TwitterServiceEvent=new TwitterServiceEvent(
				TwitterServiceEvent.FAVORITE);
			event2.statusId=event.tweetId;
			this.dispatch(event2);
		}
		private function replyTwitter(event:UIEvent):void{
			var event2:UIEvent=new UIEvent(UIEvent.REPLY_TWITTER);
			event2.replyUsername=event.replyUsername;
			event2.tweetId=event.tweetId;
			this.dispatch(event2);
		}
		private function deleteTwitter(event:UIEvent):void{
			var event2:TwitterServiceEvent=new TwitterServiceEvent(
				TwitterServiceEvent.DELETE_STATUS);
			event2.statusId=event.tweetId;
			this.dispatch(event2);
		}
		private function retweetTwitter(event:UIEvent):void{
			var event2:UIEvent=new UIEvent(UIEvent.RETWEET_TWITTER);
			event2.screenName=event.screenName;
			event2.tweetId=event.tweetId;
			event2.status=event.status;
			this.dispatch(event2);
		}
		private function browseUser(event:UIEvent):void{
			var event2:UIEvent=new UIEvent(UIEvent.BROWSE_USER);
			event2.screenName=event.screenName;
			this.dispatch(event2);
		}
	}
}