/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	public class BlockUserCommand extends TwitterCommand{
		
		[Inject]public var event:TwitterServiceEvent;
		[Inject]public var logService:ILogService;
		
		override public function execute():void{
			logService.info("BlockUserCommand execute");
			super.execute();
			this.tweetr.blockUser(event.screenName);
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("BlockUserCommand onTweetrFault");
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			logService.info("BlockUserCommand onTweetrResult");
		}
	}
}