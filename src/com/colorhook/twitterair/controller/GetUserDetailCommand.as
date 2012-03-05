/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.UserPageModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.data.objects.UserData;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	public class GetUserDetailCommand extends TwitterCommand{
		
		[Inject]public var event:TwitterServiceEvent;
		[Inject]public var logService:ILogService;
		[Inject]public var userPageModel:UserPageModel;
	
		override public function execute():void{
			logService.info("GetUserDetailCommand execute");
			super.execute();
			this.tweetr.getUserDetails(event.screenName);
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("GetUserDetailCommand onTweetrFault");
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			logService.info("GetUserDetailCommand onTweetrResult");
			var userData:UserData=event.responseArray[0] as UserData;
			if(userData==null){
				return;
			}
			userPageModel.setUserData(userData);
		}
	}
}