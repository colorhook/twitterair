/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	
	import com.colorhook.twitterair.controller.TwitterServiceEvent;
	import com.colorhook.twitterair.model.FollowersModel;
	import com.colorhook.twitterair.model.FollowersModelEvent;
	import com.colorhook.twitterair.model.SystemModelEvent;
	import com.colorhook.twitterair.services.ILogService;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	
	import org.robotlegs.mvcs.Mediator;

	public class FollowersViewMediator extends Mediator{
		
		[Inject]public var followersView:FollowersView;
		[Inject]public var followersModel:FollowersModel;
		[Inject]public var logService:ILogService;
	
		override public function onRegister():void{
			eventMap.mapListener(eventDispatcher,TwitterServiceEvent.UNFOLLOW_USER_RESULT,onFollowOrUnfollowSuccess);
			eventMap.mapListener(eventDispatcher,TwitterServiceEvent.FOLLOW_USER_RESULT,onFollowOrUnfollowSuccess);
			eventMap.mapListener(eventDispatcher,
							SystemModelEvent.LOGIN_SUCCESS,
							onLoginSuccess);
			eventMap.mapListener(eventDispatcher,FollowersModelEvent.FOLLOWERS_GET,onFollowersGet);
			eventMap.mapListener(followersView.refreshButton,MouseEvent.CLICK,refreshView);
			initialize();
		}
		private function initialize():void{
			if(followersModel.followers==null||followersModel.followers.length==0){
				getFollowers();
			}else{
				onFollowersGet();
			}
		}
		private function onLoginSuccess(event:SystemModelEvent):void{
			refreshView();
		}
		public function refreshView(event:MouseEvent=null):void{
			getFollowers();
		}
		
		private function onFollowOrUnfollowSuccess(event:TwitterServiceEvent):void{
			var isFriendship:Boolean;
			switch(event.type){
				case TwitterServiceEvent.FOLLOW_USER_RESULT:
				isFriendship=true;
				break;
				case TwitterServiceEvent.UNFOLLOW_USER_RESULT:
				isFriendship=false;
				break;
			}
			followersModel.handleFriendShip(event.screenName,isFriendship);
		}
		
		public function getFollowers():void{
			followersView.userList.dataProvider=null;
			var event:TwitterServiceEvent=new TwitterServiceEvent(
				TwitterServiceEvent.GET_FOLLOWERS);
			this.dispatch(event);
			CursorManager.setBusyCursor();
		}
		
		private function onFollowersGet(event:FollowersModelEvent=null):void{
			var dp:ArrayCollection=followersModel.followersDataProvider;
			followersView.userList.dataProvider=dp;
			CursorManager.removeBusyCursor();
		}
	}
}