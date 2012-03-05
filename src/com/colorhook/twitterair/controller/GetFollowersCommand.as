/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.FollowersModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.events.TweetEvent;

	public class GetFollowersCommand extends TwitterCommand{
		
		[Inject]public var event:TwitterServiceEvent;
		[Inject]public var logService:ILogService;
		[Inject]public var followersModel:FollowersModel;
		
		override public function execute():void{
			logService.info("GetFollowersCommand execuete");
			super.execute();
			this.tweetr.getFollowers();
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			logService.info("GetFollowersCommand onTweetrResult");
			followersModel.followers=event.responseArray;
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("GetFollowersCommand onTweetrFault");
		}
	}
}