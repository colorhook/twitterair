/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.TwitterServiceHelper;
	import com.colorhook.twitterair.model.UserModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.data.objects.StatusData;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	public class GetHomeTimeLineCommand extends TwitterCommand{
		
		[Inject]public var logService:ILogService;
		[Inject]public var event:TwitterServiceEvent;
		[Inject]public var serviceHelper:TwitterServiceHelper;
		[Inject]public var userModel:UserModel;
		
		override public function execute():void{
			logService.info("GetHomeTimeLineCommand execute");
			super.execute();
			var max_id:Number=0;
			var count:Number=20;
			var page:Number=0;
			if(event.append){
				var timeline:Array=userModel.homeTimeline;
				max_id=timeline.length>0?timeline[timeline.length-1].id:0;
				page=Math.ceil(timeline.length/20);
				trace('page:',page);
			}
			this.tweetr.getHomeTimeLine(null,null,max_id,count,page);
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			logService.info("GetHomeTimeLineCommand onTweetrResult");
			if(!systemModel.loggedIn){
				return;
			}
			var responseArr:Array=event.responseArray;
			if(!responseArr||responseArr.length==0||responseArr[0].id==0){
				return;
			}
			var status:StatusData=responseArr[0]as StatusData;
		 	var homeTimeline:Array=userModel.homeTimeline;
			userModel.homeTimeline=serviceHelper.mergeResponseArray(homeTimeline,responseArr);
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("GetHomeTimeLineCommand onTweetrFault");
		}
	}
}