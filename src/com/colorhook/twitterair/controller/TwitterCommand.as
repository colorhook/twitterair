/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.MessageConst;
	import com.colorhook.twitterair.model.SystemModel;
	import com.colorhook.twitterair.model.UserPrefModel;
	import com.colorhook.twitterair.view.Toast;
	import com.swfjunkie.tweetr.Tweetr;
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class TwitterCommand extends Command{
		
		protected var tweetr:Tweetr;
		[Inject]public var systemModel:SystemModel;
		[Inject]public var userPrefModel:UserPrefModel;
		
		override public function execute():void{
			initialize();
		}
		protected function initialize():void{
			tweetr=new Tweetr(systemModel.username,systemModel.password);
			tweetr.serviceHost=userPrefModel.userPreferences.twitterAPIProxy;
			tweetr.addEventListener(TweetEvent.COMPLETE,tweetrCompleteHandler);
			tweetr.addEventListener(TweetEvent.FAILED,tweetrFaultHandler);
		}
		
		private function tweetrCompleteHandler(event:TweetEvent):void{
			tweetr.removeEventListener(TweetEvent.COMPLETE,tweetrCompleteHandler);
			tweetr.removeEventListener(TweetEvent.FAILED,tweetrFaultHandler);
			this.dispatch(new TwitterServiceEvent(TwitterServiceEvent.TWITTER_SERVICE_RESULT));
			onTweetrResult(event);
		}
		private function tweetrFaultHandler(event:TweetEvent):void{
			tweetr.removeEventListener(TweetEvent.COMPLETE,tweetrCompleteHandler);
			tweetr.removeEventListener(TweetEvent.FAILED,tweetrFaultHandler);
			if(event.info.indexOf("Rate limit exceeded")!=-1){
				Toast.makeText(MessageConst.RATE_LIMIT_MESSAGE);
				this.dispatch(new TwitterServiceEvent(TwitterServiceEvent.RATE_LIMIT_EXCEEDED));
			}else{
				this.dispatch(new TwitterServiceEvent(TwitterServiceEvent.TWITTER_SERVICE_FAULT));
			}
			onTweetrFault(event);
		}
		protected function onTweetrResult(event:TweetEvent):void{
		}
		
		protected function onTweetrFault(event:TweetEvent):void{	
		}
		
	}
}