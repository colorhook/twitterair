/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view
{
	import com.colorhook.twitterair.controller.TwitterServiceEvent;
	import com.colorhook.twitterair.model.UserPageModel;
	import com.colorhook.twitterair.model.UserPageModelEvent;
	import com.colorhook.twitterair.services.ILogService;
	
	import org.robotlegs.mvcs.Mediator;

	public class TwitterUserPanelMediator extends Mediator
	{
		[Inject]public var userPageModel:UserPageModel;
		[Inject]public var logService:ILogService
		[Inject]public var userPage:TwitterUserPanel;
		
		override public function onRegister():void{
			logService.info("TwitterUserPageMediator onRegister");
			eventMap.mapListener(eventDispatcher,UserPageModelEvent.USER_DATA_CHANGED,
					onUserDataChanged);
			eventMap.mapListener(eventDispatcher,UserPageModelEvent.USER_STATUSES_CHANGED,
					onUserStatusesChanged);
			eventMap.mapListener(userPage,UIEvent.REMOVE_OLDER,removeOlderTwitter);
			eventMap.mapListener(userPage,UIEvent.GET_MORE_TWITTER,getMoreTwitter);
		}
		
		private function onUserDataChanged(event:UserPageModelEvent):void{
			logService.info("TwitterUserPageMediator onUserDataChanged");
			if(event.screenName==userPage.screenName){
				userPage.userItem=userPageModel.getUserItem(event.screenName);
			}
		}
		
		public function getMoreTwitter(event:UIEvent=null):void{
			var event2:TwitterServiceEvent=new TwitterServiceEvent(
				TwitterServiceEvent.GET_USER_TIME_LINE);
			event2.screenName=userPage.screenName;
			event2.append=true;
			event2.userPageMode=true;
			dispatch(event2);
		}
		
		public function removeOlderTwitter(event:UIEvent=null):void{
			var userStatus:Array=userPageModel.getUserStatus(userPage.screenName);
			if(userStatus&&userStatus.length>20){
				userPageModel.setUserStatus(userPage.screenName,userStatus.slice(0,20))
			}
		}
		
		private function onUserStatusesChanged(event:UserPageModelEvent):void{
			logService.info("TwitterUserPageMediator onUserStatusesChanged");
			if(event.screenName==userPage.screenName){
				var vPos:Number=userPage.userTwitterList.verticalScrollPosition;
				userPage.userTwitterList.dataProvider=userPageModel.getUserStatusDataProvider(event.screenName);
				if(!isNaN(vPos)){
					userPage.userTwitterList.verticalScrollPosition=vPos;
				}
			}
		}
		override public function onRemove():void{
			logService.info("TwitterUserPageMediator onRemove");

			eventMap.unmapListener(eventDispatcher,UserPageModelEvent.USER_DATA_CHANGED,
					onUserDataChanged);
			eventMap.unmapListener(eventDispatcher,UserPageModelEvent.USER_STATUSES_CHANGED,
					onUserStatusesChanged);
			eventMap.unmapListener(userPage,UIEvent.REMOVE_OLDER,removeOlderTwitter);
			eventMap.unmapListener(userPage,UIEvent.GET_MORE_TWITTER,getMoreTwitter);
			
		}
		
	}
}