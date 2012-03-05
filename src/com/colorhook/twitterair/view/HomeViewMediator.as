/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	import com.colorhook.twitterair.controller.TimerCallLater;
	import com.colorhook.twitterair.controller.TwitterServiceEvent;
	import com.colorhook.twitterair.model.SystemModel;
	import com.colorhook.twitterair.model.SystemModelEvent;
	import com.colorhook.twitterair.model.UserModel;
	import com.colorhook.twitterair.model.UserModelEvent;
	import com.colorhook.twitterair.model.UserPrefModel;
	import com.colorhook.twitterair.model.UserPrefModelEvent;
	import com.colorhook.twitterair.services.ILogService;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;

	public class HomeViewMediator extends Mediator{
		
		[Inject]public var logService:ILogService;
		[Inject]public var homeView:HomeView;
		[Inject]public var systemModel:SystemModel;
		[Inject]public var userPrefModel:UserPrefModel;
		[Inject]public var userModel:UserModel;
		

		protected var callLater:TimerCallLater;
		
		override public function onRegister():void{
			logService.info("HomeViewMediator onRegister");
			eventMap.mapListener(homeView,UIEvent.GET_MORE_TWITTER,getMoreTwitter);
			eventMap.mapListener(homeView,UIEvent.REMOVE_OLDER,removeOlderTwitter);
			eventMap.mapListener(eventDispatcher,
					UserModelEvent.HOME_LIST_CHANGE,onHomeTimelineChange);
			eventMap.mapListener(homeView.refreshButton,MouseEvent.CLICK,refreshView);
			eventMap.mapListener(eventDispatcher,SystemModelEvent.LOGIN_SUCCESS,onLoginSuccess);
			eventMap.mapListener(eventDispatcher,UserPrefModelEvent.USER_PREF_SAVED,onUserPrefSaved);
			onLoginSuccess();
		}
		
		private function onLoginSuccess(event:SystemModelEvent=null):void{
			initialize();
			refreshView();
		}
		private function initialize():void{
			if(callLater==null){
				callLater=new TimerCallLater(getUpdateDuration());
			}
			callLater.call(timeCallLaterCallback);
		}
		private function onUserPrefSaved(event:UserPrefModelEvent):void{
			callLater.duration=getUpdateDuration();
		}
		private function timeCallLaterCallback():void{
			if(systemModel.loggedIn){
				getLastestTwitter();
				callLater.call(timeCallLaterCallback);
			}
		}
		private function getUpdateDuration():Number{
			var duration:Number=userPrefModel.userPreferences.updateDuration;
			if(!duration){
				duration=1; //1 minutes refresh
			}
			return duration*60000;
		}
		public function refreshView(event:MouseEvent=null):void{			
			var event1:TwitterServiceEvent=new TwitterServiceEvent(
					TwitterServiceEvent.REFRESH_HOME_TIME_LINE);
			this.dispatch(event1);
		}
		
		
		public function getLastestTwitter():void{
			var event1:TwitterServiceEvent=new TwitterServiceEvent(
					TwitterServiceEvent.GET_HOME_TIME_LINE);
			this.dispatch(event1);
		}
		public function getMoreTwitter(event:UIEvent=null):void{
			var event2:TwitterServiceEvent=new TwitterServiceEvent(
				TwitterServiceEvent.GET_HOME_TIME_LINE);
			event2.append=true;
			dispatch(event2);
		}
		public function removeOlderTwitter(event:UIEvent=null):void{
			if(userModel.homeTimeline&&userModel.homeTimeline.length>20)
			userModel.homeTimeline=userModel.homeTimeline.slice(0,20);
		}
		
		private function onHomeTimelineChange(event:UserModelEvent):void{			
			var dataProvider:ArrayCollection=userModel.homeTimelineDataProvider;
			var vPos:Number=homeView.homeTimeline.verticalScrollPosition;
			homeView.homeTimeline.dataProvider=dataProvider;
			if(!isNaN(vPos)){
				homeView.homeTimeline.verticalScrollPosition=vPos;
			}
		}
	}
}