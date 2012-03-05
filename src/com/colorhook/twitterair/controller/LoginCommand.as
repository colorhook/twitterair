/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.SystemModelEvent;
	import com.colorhook.twitterair.model.UserModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.colorhook.twitterair.view.UIEvent;
	import com.swfjunkie.tweetr.data.objects.UserData;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	import mx.managers.CursorManager;

	public class LoginCommand extends TwitterCommand{
		
		[Inject]public var logService:ILogService;
		[Inject]public var event:UIEvent;
		[Inject]public var userModel:UserModel;
		
		override public function execute():void{
			logService.info("LoginCommand execute");
			systemModel.username=event.userPref.username;
			systemModel.password=event.userPref.password;
			systemModel.autoLogin=event.userPref.autoLogin;
			super.execute();
			tweetr.verifyCredentials();
			CursorManager.setBusyCursor();
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("LoginCommand onTweetrFault");
			CursorManager.removeBusyCursor();
			systemModel.username="";
			systemModel.password="";
			systemModel.autoLogin=false;
			var event2:SystemModelEvent=new SystemModelEvent(
				SystemModelEvent.LOGIN_FAILED);
			this.dispatch(event2);
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
		    logService.info("LoginCommand onTweetrResult");
		    var userData:UserData=event.responseArray[0] as UserData;
		    CursorManager.removeBusyCursor();
		    if(userData==null){//IF "Twitter is over capacity"
		    	systemModel.username="";
				systemModel.password="";
				systemModel.autoLogin=false;
		    	var event2:SystemModelEvent=new SystemModelEvent(
		    		SystemModelEvent.TWITTER_SERVER_DOWN);
		    	this.dispatch(event2);
		    	return;
		    }
			userModel.userData=userData;
			systemModel.loggedIn=true;
		}
	}
}