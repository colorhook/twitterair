/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.SearchModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	import mx.managers.CursorManager;
	
	public class SearchUserCommand extends TwitterCommand{
		
		[Inject]public var event:TwitterServiceEvent;
		[Inject]public var logService:ILogService;
		[Inject]public var searchModel:SearchModel;
		
		override public function execute():void{
			logService.info("SearchUserCommand execute");
			super.execute();
			searchModel.users=null;
			CursorManager.setBusyCursor();
			this.tweetr.searchUser(event.screenName);
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("SearchUserCommand onTweetrFault");
			CursorManager.removeAllCursors();
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			logService.info("SearchUserCommand onTweetrResult");
			CursorManager.removeAllCursors();
			searchModel.users=event.responseArray;
		}
	}
}