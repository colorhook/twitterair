/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.TwitterServiceHelper;
	import com.colorhook.twitterair.model.UserModel;
	import com.colorhook.twitterair.model.UserPageModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.data.objects.StatusData;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	public class GetUserTimeLineCommand extends TwitterCommand{
		
		[Inject]public var logService:ILogService;
		[Inject]public var event:TwitterServiceEvent;
		[Inject]public var serviceHelper:TwitterServiceHelper;
		[Inject]public var userModel:UserModel;
		[Inject]public var userPageModel:UserPageModel;
		
		override public function execute():void{
			logService.info("GetUserTimeLineCommand execute");
			super.execute();
			var max_id:Number=0;
			var page:Number=0;
			if(event.append){
				var timeline:Array;
				if(!event.userPageMode){
					timeline=userModel.userTimeline;
				}else{
					timeline=userPageModel.getUserStatus(event.screenName);
				}
				max_id=timeline.length>0?timeline[timeline.length-1].id-1:0;
				page=Math.ceil(timeline.length/20);
				if(page>1){page--};
			}
			this.tweetr.getUserTimeLine(event.screenName,null,null,max_id,page);
		}
		
		override protected function onTweetrResult(event2:TweetEvent):void{
			logService.info("GetUserTimeLineCommand onTweetrResult");
			if(!systemModel.loggedIn){
				return;
			}
			var responseArr:Array=event2.responseArray;
			if(!responseArr||responseArr.length==0||responseArr[0].id==0){
				return;
			}
			
			if(!event.userPageMode){
				var userTimeline:Array=userModel.userTimeline;
				userModel.userTimeline=serviceHelper.mergeResponseArray(userTimeline,responseArr);
			}
			
			var status:StatusData=responseArr[0] as StatusData;
			var screenName:String=status.user.screenName;
			if(userPageModel.hasUserPage(screenName)){
				var oldData:Array=userPageModel.getUserStatus(screenName);
				var statuses:Array=serviceHelper.mergeResponseArray(oldData,responseArr);
				userPageModel.setUserStatus(screenName,statuses);
			}
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("GetUserTimeLineCommand onTweetrFault");
		}
	}
}