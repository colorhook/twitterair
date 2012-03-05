/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	
	import com.colorhook.twitterair.controller.TwitterServiceEvent;
	import com.colorhook.twitterair.model.SystemModelEvent;
	import com.colorhook.twitterair.model.UserModel;
	import com.colorhook.twitterair.model.UserModelEvent;
	import com.colorhook.twitterair.services.ILogService;
	import com.swfjunkie.tweetr.data.objects.UserData;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;

	public class UserProfileViewMediator extends Mediator{
		
		[Inject]public var userProfileView:UserProfileView;
		[Inject]public var logService:ILogService;
		[Inject]public var userModel:UserModel;
		
		override public function onRegister():void{
			logService.info("UserProfileViewMediator onRegister");
			eventMap.mapListener(eventDispatcher,
							UserModelEvent.USER_LIST_CHANGE,
							onUserTimelineChanged);
							
			eventMap.mapListener(eventDispatcher,
							UserModelEvent.USER_DATA_CHANGE,
							onUserDataChanged);
							
			eventMap.mapListener(eventDispatcher,
							SystemModelEvent.LOGIN_SUCCESS,
							onLoginSuccess);
										
			eventMap.mapListener(userProfileView,UIEvent.GET_MORE_TWITTER,getMoreTwitter);
			eventMap.mapListener(userProfileView,UIEvent.REMOVE_OLDER,removeOlderTwitter);
			eventMap.mapListener(userProfileView,UIEvent.CHANGE_PROFILE_IMAGE,changeProfileImage);
			eventMap.mapListener(userProfileView.refreshButton,MouseEvent.CLICK,refreshView);
			initialize();
		}
		private function initialize():void{
			initializeUserProfle();
			refreshView();
		}
		private function onLoginSuccess(event:SystemModelEvent):void{
			refreshView();
		}
		
		public function refreshView(event:MouseEvent=null):void{
			var event1:TwitterServiceEvent=new TwitterServiceEvent(
					TwitterServiceEvent.REFRESH_USER_TIME_LINE);
			this.dispatch(event1);
		}
		public function initializeUserProfle():void{
			var userData:UserData=userModel.userData;
			if(userData==null){
				userProfileView.username.text="";
				userProfileView.location.text="";
				userProfileView.description.text="";
				userProfileView.website.text="";
				userProfileView.friend_info.htmlText="<b>Firends: </b>?";
				userProfileView.follower_info.htmlText="<b>Followers: </b>?";
				userProfileView.status_info.htmlText="<b>Statuses: </b>?";
				userProfileView.frofileImage.source=null;
				return;
			}
			userProfileView.username.text=userData.screenName;			
			userProfileView.location.text=userData.location;
			
			userProfileView.website.htmlText=userData.url;
			userProfileView.friend_info.htmlText="<b>Firends: </b>"+userData.extended.friendsCount;
			userProfileView.follower_info.htmlText="<b>Followers: </b>"+userData.followersCount;
			userProfileView.status_info.htmlText="<b>Statuses: </b>"+userData.extended.statusesCount;
			
			userProfileView.description.text=userData.description;
			userProfileView.frofileImage.source=userData.profileImageUrl;
		}
		private function onUserDataChanged(event:UserModelEvent):void{
			initializeUserProfle();
		}
		private function getProfileList(username:String=null):void{
			var event:TwitterServiceEvent=new TwitterServiceEvent(
					TwitterServiceEvent.GET_USER_TIME_LINE);
			this.dispatch(event);
		}
		private function changeProfileImage(event:UIEvent):void{
			var fileRef:FileReference=new FileReference();
			fileRef.addEventListener(Event.SELECT,onFileRefSelected);
			fileRef.addEventListener(Event.CANCEL,onFileRefCancel);
			fileRef.browse([new FileFilter("Image (*.jpg;*.jpeg;*.png)","*.jpg;*.jpeg;*.png;")]);
		}
		private function onFileRefSelected(event:Event):void{
			event.target.removeEventListener(Event.SELECT,onFileRefSelected);
			event.target.removeEventListener(Event.CANCEL,onFileRefCancel);
			var fileRef:FileReference=event.target as FileReference;
			var event2:TwitterServiceEvent=new TwitterServiceEvent(
				TwitterServiceEvent.UPDATE_PROFILE_IMAGE);
			event2.fileReference=fileRef;
			this.dispatch(event2);
		}
		private function onFileRefCancel(event:Event):void{
			event.target.removeEventListener(Event.SELECT,onFileRefSelected);
			event.target.removeEventListener(Event.CANCEL,onFileRefCancel);
		}
		private function onUserTimelineChanged(event:UserModelEvent):void{
			var dp:ArrayCollection=userModel.userTimelineDataProvider
			userProfileView.userTwitterList.dataProvider=dp;
		}
		private function getMoreTwitter(event:UIEvent):void{
			var event2:TwitterServiceEvent=new TwitterServiceEvent(
					TwitterServiceEvent.GET_USER_TIME_LINE);
			event2.append=true;
			this.dispatch(event2);
		}
		private function removeOlderTwitter(event:UIEvent):void{
			if(userModel.userTimeline&&userModel.userTimeline.length>20)
			userModel.userTimeline=userModel.userTimeline.slice(0,20);
		}
	}
}