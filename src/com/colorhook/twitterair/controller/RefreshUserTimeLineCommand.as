package com.colorhook.twitterair.controller
{
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	import mx.managers.CursorManager;
	
	public class RefreshUserTimeLineCommand extends GetUserTimeLineCommand
	{
		override public function execute():void{
			logService.info("RefreshUserTimeLineCommand execute");
			super.execute();
			var event:TwitterServiceEvent=new TwitterServiceEvent(TwitterServiceEvent.GET_SELF_DETAIL);
			this.dispatch(event);
			CursorManager.setBusyCursor();
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			logService.info("RefreshUserTimeLineCommand onTweetrResult");
			super.onTweetrResult(event);
			CursorManager.removeBusyCursor();
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("RefreshUserTimeLineCommand onTweetrFault");
			CursorManager.removeBusyCursor();
		}
		
	}
}