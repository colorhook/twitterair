/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import flash.events.Event;
	import flash.net.FileReference;

	public class TwitterServiceEvent extends Event{
		
		public static const RATE_LIMIT_EXCEEDED:String="TwitterServiceEvent_rateLimitExceeded";
		public static const TWITTER_SERVICE_FAULT:String="TwitterServiceEvent_twitterServiceFault";
		public static const TWITTER_SERVICE_RESULT:String="TwitterServiceEvent_twitterServiceResult";
		
		public static const GET_PUBLIC_TIME_LINE:String="TwitterServiceEvent_getPublicTimeLine";
		public static const REFRESH_PUBLIC_TIME_LINE:String="TwitterServiceEvent_refreshPublicTimeLine";
		
		public static const GET_HOME_TIME_LINE:String="TwitterServiceEvent_getHomeTimeLine";
		public static const REFRESH_HOME_TIME_LINE:String="TwitterServiceEvent_refreshHomeTimeLine";
		
		public static const GET_USER_TIME_LINE:String="TwitterServiceEvent_getUserTimeLine";
		public static const REFRESH_USER_TIME_LINE:String="TwitterServiceEvent_refreshUserTimeLine";
		
		public static const REPLY:String="TwitterServiceEvent_reply";
		public static const RETWEET:String="TwitterServiceEvent_retweet";
		public static const FAVORITE:String="TwitterServiceEvent_favorite";
		
		public static const FOLLOW_USER:String="TwitterServiceEvent_followUser";
		public static const FOLLOW_USER_RESULT:String="TwitterServiceEvent_followUser_result";
		public static const FOLLOW_USER_FAULT:String="TwitterServiceEvent_followUser_fault";
		
		public static const UNFOLLOW_USER:String="TwitterServiceEvent_unfollowUser";
		public static const UNFOLLOW_USER_RESULT:String="TwitterServiceEvent_unfollowUser_result";
		public static const UNFOLLOW_USER_FAULT:String="TwitterServiceEvent_unfollowUser_fault";
		
		public static const BLOCK_USER:String="TwitterServiceEvent_blockUser";
		public static const UNBLOCK_USER:String="TwitterServiceEvent_unblockUser";
		public static const DELETE_STATUS:String="TwitterServiceEvent_delete";
		public static const UPDATE_STATUS:String="TwitterServiceEvent_updateStatus";
		public static const GET_FRIENDS:String="TwitterServiceEvent_getFriends";
		public static const GET_FOLLOWERS:String="TwitterServiceEvent_getFollowers";

		public static const UPDATE_PROFILE_IMAGE:String="TwitterServiceEvent_updateProfileImage";
		public static const GET_USER_DETAIL:String="TwitterServiceEvent_getUserDetail";
		public static const GET_SELF_DETAIL:String="TwitterServiceEvent_getSelfDetail";
		public static const SEARCH_USER:String="TwitterServiceEvent_searchUser";
		
		public var statusText:String;
		public var replyToStatusId:Number;
		public var replyTo:String;
		public var screenName:String;
		public var userId:Number;
		public var statusId:Number;
		public var maxId:Number;
		public var minId:Number;
		public var append:Boolean=false;
		public var userPageMode:Boolean=false;
		public var fileReference:FileReference;
		
		public function TwitterServiceEvent(type:String, 
				bubbles:Boolean=false, 
				cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
	}
}