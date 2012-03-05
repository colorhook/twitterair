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

	public class SearchModel extends Actor{
		
		private var _users:Array=[];
		[Inject]public var helper:TwitterServiceHelper;
		public function SearchModel(){
			super();
		}
		
		public function get users():Array{
			return _users||[];
		}
		
		public function set users(value:Array):void{
			_users=value||[];
			this.dispatch(new SearchModelEvent(SearchModelEvent.SEARCH_COMPLETE))
		}
		
		public function handleFriendShip(screenName:String, isFriendship:Boolean):void{

			for(var i:int=0;i<_users.length;i++){
				var userData:UserData=_users[i] as UserData;
				if(userData.screenName==screenName){
					userData.extended.following=isFriendship;
					this.dispatch(new SearchModelEvent(SearchModelEvent.SEARCH_COMPLETE));
					return;
				}
			}
		}
		
		public function get usersDataProvider():ArrayCollection{
			var result:ArrayCollection=new ArrayCollection();
			for(var i:int=0;i<users.length;i++){
				var user:UserItem;
				user=helper.userDataToUserItem(_users[i]);
				result.addItem(user);
			}
			return result;
		}
	}
}