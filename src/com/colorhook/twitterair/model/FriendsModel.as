/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model{
	
	import com.colorhook.twitterair.vo.UserItem;
	import com.swfjunkie.tweetr.data.objects.UserData;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;

	public class FriendsModel extends Actor{
		
		private var _friends:Array=[];
		
		[Inject]public var helper:TwitterServiceHelper;
		
		public function get friends():Array{
			return _friends||[];
		}
		public function set friends(value:Array):void{
			this._friends=value||[];
			this.dispatch(new FriendsModelEvent(FriendsModelEvent.FRIENDS_GET));
		}
		
		public function handleFriendShip(screenName:String, isFriendship:Boolean):void{

			for(var i:int=0;i<_friends.length;i++){
				var userData:UserData=_friends[i] as UserData;
				if(userData.screenName==screenName){
					userData.extended.following=isFriendship;
					this.dispatch(new FriendsModelEvent(FriendsModelEvent.FRIENDS_GET));
					return;
				}
			}
		}
		
		public function get friendsDataProvider():ArrayCollection{
			var result:ArrayCollection=new ArrayCollection();
			for(var i:int=0;i<_friends.length;i++){
				var userItem:UserItem=new UserItem;
				userItem=helper.userDataToUserItem(_friends[i]);
				result.addItem(userItem);
			}
			return result;
		}
	}
}