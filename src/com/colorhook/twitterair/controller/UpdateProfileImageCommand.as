/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.UserModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.data.objects.UserData;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	import mx.managers.CursorManager;
	
	public class UpdateProfileImageCommand extends TwitterCommand{
		
		[Inject]public var event:TwitterServiceEvent;
		[Inject]public var logService:ILogService;
		[Inject]public var userModel:UserModel;
		override public function execute():void{
			logService.info("UpdateProfileImageCommand execute");
			super.execute();
			this.tweetr.updateProfileImage(event.fileReference);
			CursorManager.setBusyCursor();
		}

		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("UpdateProfileImageCommand onTweetrFault");
			CursorManager.removeBusyCursor();
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			var userData:UserData=event.responseArray[0] as UserData;
			CursorManager.removeBusyCursor();
			if(userData){
				userModel.userData=userData;
			}
			logService.info("UpdateProfileImageCommand onTweetrResult");
		}
	}
}