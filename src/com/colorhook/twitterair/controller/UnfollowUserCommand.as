/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	import mx.managers.CursorManager;
	
	public class UnfollowUserCommand extends TwitterCommand{
		
		[Inject]public var event:TwitterServiceEvent;
		[Inject]public var logService:ILogService;
		
		override public function execute():void{
			logService.info("UnfollowUserCommand execute");
			super.execute();
			CursorManager.setBusyCursor();
			this.tweetr.destroyFriendship(event.screenName);
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("UnfollowUserCommand onTweetrFault");
			CursorManager.removeAllCursors();
			this.dispatch(new TwitterServiceEvent(TwitterServiceEvent.UNFOLLOW_USER_FAULT));
		}
		
		override protected function onTweetrResult(e:TweetEvent):void{
			logService.info("UnfollowUserCommand onTweetrResult");
			CursorManager.removeAllCursors();
			var newEvent:TwitterServiceEvent=new TwitterServiceEvent(TwitterServiceEvent.UNFOLLOW_USER_RESULT);
			newEvent.screenName=this.event.screenName;
			this.dispatch(newEvent);
		}
	}
}