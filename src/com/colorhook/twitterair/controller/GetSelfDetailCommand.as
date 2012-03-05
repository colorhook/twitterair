/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.SystemModel;
	import com.colorhook.twitterair.model.UserModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.data.objects.UserData;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	public class GetSelfDetailCommand extends TwitterCommand{
		
		[Inject]public var logService:ILogService;
		[Inject]public var userModel:UserModel;
		
		override public function execute():void{
			logService.info("GetSelfDetailCommand execute");
			super.execute();
			this.tweetr.getUserDetails(systemModel.username);
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("GetSelfDetailCommand onTweetrFault");
		}

		override protected function onTweetrResult(event:TweetEvent):void{
			var userData:UserData=event.responseArray[0] as UserData;
			userModel.userData=userData;
			logService.info("GetSelfDetailCommand onTweetrResult");
		}
		
	}
}