/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	
	import com.colorhook.twitterair.vo.UserPreferences;
	
	import flash.events.Event;

	public class UIEvent extends Event{
		
		public static const MINIMIZE:String="UIEvent_minimize";
		public static const MAXIMIZE:String="UIEvent_maximize";
		public static const CLOSE:String="UIEvent_close";
		public static const RESIZE:String="UIEvent_resize";
		
		public static const GO_BACK:String="UIEvent_goBack";
		public static const USER_PREF:String="UIEvent_userPref";
		public static const ABOUT:String="UIEvent_about";
		
		public static const BROWSE_USER:String="UIEvent_browseUser";
		public static const USER_PROFILE:String="UIEvent_userProfile";
		public static const LOGIN_REQUEST:String="UIEvent_loginRequest";
		public static const LOGOUT_REQUEST:String="UIEvent_logoutRequest";
		
		public static const SET_USER_PREFERENCES:String="UIEvent_setUserPreferences";
		public static const SAVE_USER_PREFERENCES:String="UIEvent_saveUserPreferences";
		public static const CANCEL_USER_PREFERENCES:String="UIEvent_cancelUserPreferences";
		
	
		public static const SUBMIT_TWITTER:String="UIEvent_submiteTwitter";
		public static const SEARCH_REQUEST:String="UIEvent_searchRequest";
		public static const REPLY_TWITTER:String="UIEvent_replyTwitter";
		public static const RETWEET_TWITTER:String="UIEvent_retweetTwitter";
		public static const FAVORITE_TWITTER:String="UIEvent_favoriteTwitter";
		public static const FOLLOW_USER:String="UIEvent_followUser";
		public static const UNFOLLOW_USER:String="UIEvent_unfollowUser";
		public static const BLOCK_USER:String="UIEvent_blockUser";
		public static const UNBLOCK_USER:String="UIEvent_unblockUser";
		public static const DELETE_TWITTER:String="UIEvent_deleteTwitter";
		public static const GET_MORE_TWITTER:String="UIEvent_getMoreTitter";
		public static const CHANGE_PROFILE_IMAGE:String="UIEvent_changeProfileImage";
		public static const REMOVE_OLDER:String="UIEvent_removeOlder";
		
		
		public var screenName:String;
		public var replyUsername:String;
		public var tweetId:Number;
		public var status:String;
		
		public var userPref:UserPreferences;
		
		public function UIEvent(type:String, 
							bubbles:Boolean=false, 
							cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
	}
}