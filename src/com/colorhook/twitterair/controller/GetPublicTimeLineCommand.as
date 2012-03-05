/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.PublicModel;
	import com.colorhook.twitterair.model.TwitterServiceHelper;
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	public class GetPublicTimeLineCommand extends TwitterCommand{
		
		[Inject]public var logService:ILogService;
		[Inject]public var event:TwitterServiceEvent;
		[Inject]public var serviceHelper:TwitterServiceHelper;
		[Inject]public var publicModel:PublicModel;
		
		override public function execute():void{
			logService.info("GetPublicTimeLineCommand execute");
			super.execute();
			this.tweetr.getPublicTimeLine()
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			logService.info("GetPublicTimeLineCommand onTweetrResult");
			var responseArr:Array=event.responseArray;
			if(!responseArr||responseArr.length==0||responseArr[0].id==0){
				return;
			}
		 	publicModel.publicTimeLine=responseArr
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("GetPublicTimeLineCommand onTweetrFault");
		}
	}
}