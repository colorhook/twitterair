/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.UserModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	public class DeleteStatusCommand extends TwitterCommand{
		
		[Inject]public var event:TwitterServiceEvent;
		[Inject]public var logService:ILogService;
		[Inject]public var userModel:UserModel;
		
		public var deleteId:Number;
		override public function execute():void{
			logService.info("DeleteStatusCommand execute");
			super.execute();
			deleteId=event.statusId;
			this.tweetr.destroyStatus(event.statusId);
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("DeleteStatusCommand onTweetrFault");
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			logService.info("DeleteStatusCommand onTweetrResult");
			var homeTimeline:Array=userModel.homeTimeline;
			var userTimeline:Array=userModel.userTimeline;
			for(var i:int=0;i<homeTimeline.length;i++){
				if(homeTimeline[i].id==deleteId){
					homeTimeline.splice(i,1);
					userModel.homeTimeline=homeTimeline;
					break;
				}
			}
			for(var j:int=0;j<userTimeline.length;j++){
				if(userTimeline[j].id==deleteId){
					userTimeline.splice(i,1);
					userModel.userTimeline=userTimeline;
					break;
				}
			}
		}
	}
}