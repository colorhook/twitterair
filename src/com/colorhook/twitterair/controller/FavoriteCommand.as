/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	public class FavoriteCommand extends TwitterCommand{
		
		[Inject]public var event:TwitterServiceEvent;
		[Inject]public var logService:ILogService;
		
		override public function execute():void{
			logService.info("FavoriteCommand execute");
			super.execute();
			this.tweetr.createFavorite(event.statusId);
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("FavoriteCommand onTweetrFault");
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			logService.info("FavoriteCommand onTweetrResult");
		}
		
	}
}