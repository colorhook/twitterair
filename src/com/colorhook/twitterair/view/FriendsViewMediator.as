/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	
	import com.colorhook.twitterair.controller.TwitterServiceEvent;
	import com.colorhook.twitterair.model.FriendsModel;
	import com.colorhook.twitterair.model.FriendsModelEvent;
	import com.colorhook.twitterair.model.SystemModelEvent;
	import com.colorhook.twitterair.services.ILogService;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	
	import org.robotlegs.mvcs.Mediator;

	public class FriendsViewMediator extends Mediator{
		
		[Inject]public var friendsView:FriendsView;
		[Inject]public var friendsModel:FriendsModel;
		[Inject]public var logService:ILogService;
		
		override public function onRegister():void{
			eventMap.mapListener(eventDispatcher,TwitterServiceEvent.UNFOLLOW_USER_RESULT,onFollowOrUnfollowSuccess);
			eventMap.mapListener(eventDispatcher,TwitterServiceEvent.FOLLOW_USER_RESULT,onFollowOrUnfollowSuccess);
			
			eventMap.mapListener(eventDispatcher,
							SystemModelEvent.LOGIN_SUCCESS,
							onLoginSuccess);
							
			eventMap.mapListener(eventDispatcher,FriendsModelEvent.FRIENDS_GET,onFriendsGet);
			eventMap.mapListener(friendsView.refreshButton,MouseEvent.CLICK,refreshView);
			initialize();
		}
		private function initialize():void{
			if(friendsModel.friends==null||friendsModel.friends.length==0){
				getFriends();
			}else{
				onFriendsGet(null);
			}
		}
		private function onLoginSuccess(event:SystemModelEvent):void{
			refreshView();
		}
		public function refreshView(event:MouseEvent=null):void{
			getFriends();
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
			friendsModel.handleFriendShip(event.screenName,isFriendship);
		}
		public function getFriends():void{
			CursorManager.setBusyCursor();
			friendsView.userList.dataProvider=null;
			var event:TwitterServiceEvent=new TwitterServiceEvent(
				TwitterServiceEvent.GET_FRIENDS);
			this.dispatch(event);
		}
		
		private function onFriendsGet(event:FriendsModelEvent=null):void{
			CursorManager.removeBusyCursor();
			var dp:ArrayCollection=friendsModel.friendsDataProvider;
			friendsView.userList.dataProvider=dp;
		}
	}
}