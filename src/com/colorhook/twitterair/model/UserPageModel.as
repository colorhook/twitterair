/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model
{
	import com.colorhook.twitterair.view.TwitterUserWindow;
	import com.colorhook.twitterair.vo.StatusItem;
	import com.colorhook.twitterair.vo.UserItem;
	import com.swfjunkie.tweetr.data.objects.StatusData;
	import com.swfjunkie.tweetr.data.objects.UserData;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.core.IInjector;
	import org.robotlegs.mvcs.Actor;

	public class UserPageModel extends Actor{
	
		protected var userPageMap:Dictionary;
		protected var userStatusesMap:Dictionary;
		protected var userDataMap:Dictionary;
		
		[Inject]public var helper:TwitterServiceHelper;
		[Inject]public var systemModel:SystemModel;
		
		protected static var instance:UserPageModel;
		
		public function UserPageModel(){
			userPageMap=new Dictionary;
			userDataMap=new Dictionary;
			userStatusesMap=new Dictionary;
		}

		public function setUserData(userData:UserData):void{
			userDataMap[userData.screenName]=userData;
			var event:UserPageModelEvent=new UserPageModelEvent(UserPageModelEvent.USER_DATA_CHANGED)
			event.screenName=userData.screenName;
			this.dispatch(event);
		}
		
		public function getUserStatus(screenName:String):Array{
			return userStatusesMap[screenName]||[];
		}
		public function setUserStatus(screenName:String,statuses:Array):void{
			userStatusesMap[screenName]=statuses;
			var event:UserPageModelEvent=new UserPageModelEvent(UserPageModelEvent.USER_STATUSES_CHANGED)
			event.screenName=screenName;
			this.dispatch(event);
		}
		
		public function getUserItem(screenName:String):UserItem{
			var userData:UserData=userDataMap[screenName];
			return helper.userDataToUserItem(userData);
		}
		
		public function getUserStatusDataProvider(screenName:String):ArrayCollection{
			var dataProvider:ArrayCollection=new ArrayCollection;
			var _userTimeline:Array=userStatusesMap[screenName];
			for(var i:int=0;i<_userTimeline.length;i++){
				var statusItem:StatusItem;
				var statusData:StatusData=_userTimeline[i]
				statusItem=helper.statusDataToStatusItem(statusData);
				statusItem.isMyTweet= (screenName==systemModel.username);
				dataProvider.addItem(statusItem);
			}
			return dataProvider;
		}
		
		public function registerUserPage(screenName:String,window:TwitterUserWindow,injector:IInjector):void{
			userPageMap[screenName]= window;
			window.screenName=screenName;
			window.injector=injector;
			window.onRegister();
		}
		public function hasUserPage(screenName:String):Boolean{
			return userPageMap[screenName]!=null;
		}
		
		public function retrieveUserPage(screenName:String):TwitterUserWindow{
			return TwitterUserWindow(userPageMap[screenName]);
		}
		
		public function getAllOpendWindowsMap():Dictionary{
			return userPageMap;
		}
		
		public function removeUserPage(screenName:String):void{
			var window:TwitterUserWindow=userPageMap[screenName];
			delete userPageMap[screenName];
			delete userDataMap[screenName];
			delete userStatusesMap[screenName];
			if(window){
				window.onRemove();
			}
		}
	}
}