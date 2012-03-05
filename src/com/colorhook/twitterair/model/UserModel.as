/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model{
	
	import com.colorhook.twitterair.vo.StatusItem;
	import com.swfjunkie.tweetr.data.objects.StatusData;
	import com.swfjunkie.tweetr.data.objects.UserData;
	import com.swfjunkie.tweetr.utils.TweetUtil;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;
	
	public class UserModel extends Actor{
		
		[Inject]public var helper:TwitterServiceHelper;
		
		private var _userData:UserData;
		private var _homeTimeline:Array;
		private var _userTimeline:Array;
		
		public function UserModel(){
			super();
			initialize();
		}
		public function initialize():void{
			_homeTimeline=[];
			_userTimeline=[];
			_userData=null;
		}
		
		/////////////Twitter Data///////////////////////
		public function get homeTimeline():Array{
			return _homeTimeline||[];
		}
		
		public function set homeTimeline(value:Array):void{
			_homeTimeline=value||[]; 
			dispatch(new UserModelEvent(UserModelEvent.HOME_LIST_CHANGE));
		}
		public function get userTimeline():Array{
			return _userTimeline||[];
		}
		public function set userTimeline(value:Array):void{
			_userTimeline=value||[];
			dispatch(new UserModelEvent(UserModelEvent.USER_LIST_CHANGE));
		}
		public function get userData():UserData{
			return _userData;
		}
		public function set userData(value:UserData):void{
			_userData=value;
			dispatch(new UserModelEvent(UserModelEvent.USER_DATA_CHANGE));
		}
		
		public function get homeTimelineDataProvider():ArrayCollection{
			var dataProvider:ArrayCollection=new ArrayCollection;
			for(var i:int=0;i<_homeTimeline.length;i++){
				var statusItem:StatusItem;
				var statusData:StatusData=_homeTimeline[i]
				statusItem=helper.statusDataToStatusItem(statusData);
				if(userData){
					statusItem.isMyTweet=(statusData.user.id==userData.id);
				}
				dataProvider.addItem(statusItem);
			}
			return dataProvider;
		}
		
		public function get userTimelineDataProvider():ArrayCollection{
			var dataProvider:ArrayCollection=new ArrayCollection;
			for(var i:int=0;i<_userTimeline.length;i++){
				var statusItem:StatusItem;
				var statusData:StatusData=_userTimeline[i]
				statusItem=helper.statusDataToStatusItem(statusData);
				statusItem.isMyTweet=true;
				dataProvider.addItem(statusItem);
			}
			return dataProvider;
		}
		
		
	}
}