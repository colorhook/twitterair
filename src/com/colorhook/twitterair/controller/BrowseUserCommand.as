package com.colorhook.twitterair.controller
{
	import com.colorhook.twitterair.model.UserPageModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.colorhook.twitterair.view.TwitterUserWindow;
	import com.colorhook.twitterair.view.UIEvent;
	
	public class BrowseUserCommand extends TwitterCommand
	{
		[Inject]public var userPageModel:UserPageModel;
		[Inject]public var logService:ILogService;
		[Inject]public var event:UIEvent;
		
		private var screenName:String;
		
		override public function execute():void{
			logService.info("BrowseUserCommand execute");
			screenName=event.screenName;
			openWindow();
		}
		
		private function openWindow():TwitterUserWindow{
			var window:TwitterUserWindow;
			if(!userPageModel.hasUserPage(screenName)){
				getUserData();
				getUserStatuses();
				window=this.injector.instantiate(TwitterUserWindow);
				userPageModel.registerUserPage(screenName,window, this.injector);
				window.open();
			}else{
				window=userPageModel.retrieveUserPage(screenName);
			}
			window.orderToFront();
			return window;
		}
		
		private function getUserData():void{
			var event:TwitterServiceEvent=new TwitterServiceEvent(TwitterServiceEvent.GET_USER_DETAIL);
			event.screenName=screenName;
			this.dispatch(event);
		}
		
		private function getUserStatuses():void{
			var event:TwitterServiceEvent=new TwitterServiceEvent(TwitterServiceEvent.GET_USER_TIME_LINE);
			event.screenName=screenName;
			event.userPageMode=true;
			this.dispatch(event);
		}
	}
}