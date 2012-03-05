/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.FriendsModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	public class GetFriendsCommand extends TwitterCommand{
		
		[Inject]public var event:TwitterServiceEvent;
		[Inject]public var logService:ILogService;
		[Inject]public var friendsModel:FriendsModel;
		
		override public function execute():void{
			logService.info("GetFriendsCommand execute");
			super.execute();
			this.tweetr.getFriends();
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			logService.info("GetFriendsCommand onTweetrResult");
			friendsModel.friends=event.responseArray;
			
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("GetFriendsCommand onTweetrFault");
		}
		
	}
}