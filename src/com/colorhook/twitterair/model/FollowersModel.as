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

	public class FollowersModel extends Actor{
		
		private var _followers:Array=[];
		
		[Inject]public var helper:TwitterServiceHelper;
		
		public function get followers():Array{
			return _followers||[];
		}
		public function set followers(value:Array):void{
			this._followers=value||[];
			this.dispatch(new FollowersModelEvent(FollowersModelEvent.FOLLOWERS_GET));
		}
		
		public function handleFriendShip(screenName:String, isFriendship:Boolean):void{

			for(var i:int=0;i<_followers.length;i++){
				var userData:UserData=_followers[i] as UserData;
				if(userData.screenName==screenName){
					userData.extended.following=isFriendship;
					this.dispatch(new FollowersModelEvent(FollowersModelEvent.FOLLOWERS_GET));
					return;
				}
			}
		}
		
		public function get followersDataProvider():ArrayCollection{
			var result:ArrayCollection=new ArrayCollection();
			for(var i:int=0;i<_followers.length;i++){
				var userItem:UserItem=new UserItem;
				userItem=helper.userDataToUserItem(_followers[i]);
				result.addItem(userItem);
			}
			return result;
		}
	}
}