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
	
	public class FollowUserCommand extends TwitterCommand{
		
		[Inject]public var event:TwitterServiceEvent;
		[Inject]public var logService:ILogService;
		
		override public function execute():void{
			logService.info("FollowUserCommand execute");
			super.execute();
			CursorManager.setBusyCursor();
			this.tweetr.createFriendship(event.screenName);
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("FollowUserCommand onTweetrFault");
			CursorManager.removeAllCursors();
			this.dispatch(new TwitterServiceEvent(TwitterServiceEvent.FOLLOW_USER_FAULT));
			
		}
		
		override protected function onTweetrResult(e:TweetEvent):void{
			logService.info("FollowUserCommand onTweetrResult");
			CursorManager.removeAllCursors();
			var newEvent:TwitterServiceEvent=new TwitterServiceEvent(TwitterServiceEvent.FOLLOW_USER_RESULT)
			newEvent.screenName=this.event.screenName;
			this.dispatch(newEvent);
		}
		
	}
}