/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	import com.colorhook.twitterair.model.UserModelEvent;
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.data.objects.StatusData;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	import mx.managers.CursorManager;
	
	public class UpdateStatusCommand extends TwitterCommand{
		[Inject]public var logService:ILogService;
		[Inject]public var event:TwitterServiceEvent;
		
		override public function execute():void{
			logService.info("UpdateStatusCommand execute");
			super.execute();
			CursorManager.setBusyCursor();
			var status:String=event.statusText;
			if(status.charAt(0)=="@"){
				status=" "+status;
			}
			this.tweetr.updateStatus(status,event.replyToStatusId);
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			logService.info("UpdateStatusCommand onTweetrResult");
			CursorManager.removeBusyCursor();
			this.dispatch(new UserModelEvent(UserModelEvent.STATUS_UPDATE_COMPLETE));
			this.dispatch(new TwitterServiceEvent(TwitterServiceEvent.GET_USER_TIME_LINE));
			this.dispatch(new TwitterServiceEvent(TwitterServiceEvent.GET_HOME_TIME_LINE));
			var statusData:StatusData=event.responseArray[0] as StatusData;
			
			if(statusData){
				var newEvent:SNSEvent=new SNSEvent(SNSEvent.RENREN);
				newEvent.text=statusData.text;
				this.dispatch(newEvent);
			}
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("UpdateStatusCommand onTweetrFault");
			CursorManager.removeBusyCursor();
			this.dispatch(new UserModelEvent(UserModelEvent.STATUS_UPDATE_FAULT));
		}
		
	}
}