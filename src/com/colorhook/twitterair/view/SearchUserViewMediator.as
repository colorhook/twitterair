/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	
	import com.colorhook.twitterair.controller.TwitterServiceEvent;
	import com.colorhook.twitterair.model.SearchModel;
	import com.colorhook.twitterair.model.SearchModelEvent;
	import com.colorhook.twitterair.model.SystemModelEvent;
	import com.colorhook.twitterair.services.ILogService;
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	import org.robotlegs.mvcs.Mediator;

	public class SearchUserViewMediator extends Mediator{
		
		[Inject]public var searchUserView:SearchUserView;
		[Inject]public var logService:ILogService;
		[Inject]public var searchModel:SearchModel;
		
		override public function onRegister():void{
			eventMap.mapListener(eventDispatcher,TwitterServiceEvent.UNFOLLOW_USER_RESULT,onFollowOrUnfollowSuccess);
			eventMap.mapListener(eventDispatcher,TwitterServiceEvent.FOLLOW_USER_RESULT,onFollowOrUnfollowSuccess);
			eventMap.mapListener(searchUserView,UIEvent.SEARCH_REQUEST,doSearch);
			eventMap.mapListener(eventDispatcher,
					SystemModelEvent.LOGOUT_SUCCESS,onLogoutSuccess);
			eventMap.mapListener(eventDispatcher,SearchModelEvent.SEARCH_COMPLETE,onSearchComplete);
		}
		
		private function doSearch(event:UIEvent):void{
			var event2:TwitterServiceEvent=new TwitterServiceEvent(
					TwitterServiceEvent.SEARCH_USER);
			event2.screenName=StringUtil.trim(searchUserView.search_input.text);
			this.dispatch(event2);
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
			searchModel.handleFriendShip(event.screenName,isFriendship);
		}
		
		private function onLogoutSuccess(event:SystemModelEvent):void{
			searchUserView.search_input.text="";
		}
		
		private function onSearchComplete(event:SearchModelEvent):void{
			var dp:ArrayCollection=searchModel.usersDataProvider;
			searchUserView.userList.dataProvider=dp;
		}
	}
}