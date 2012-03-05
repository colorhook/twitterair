package com.colorhook.twitterair.controller
{
	import com.swfjunkie.tweetr.events.TweetEvent;
	
	import mx.managers.CursorManager;
	
	public class RefreshHomeTimeLineCommand extends GetHomeTimeLineCommand
	{
		override public function execute():void{
			logService.info("RefreshHomeTimeLineCommand execute");
			super.execute();
			CursorManager.setBusyCursor();
		}
		
		override protected function onTweetrResult(event:TweetEvent):void{
			logService.info("RefreshHomeTimeLineCommand onTweetrResult");
			super.onTweetrResult(event);
			CursorManager.removeBusyCursor();
		}
		
		override protected function onTweetrFault(event:TweetEvent):void{
			logService.info("RefreshHomeTimeLineCommand onTweetrFault");
			CursorManager.removeBusyCursor();
		}
		
	}
}