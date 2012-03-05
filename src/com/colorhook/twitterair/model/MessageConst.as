/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model{
	
	public class MessageConst{
		public static const LOGIN_FAILED_MESSAGE:String="Login failed, Please check your username and password.";
		public static const LOGOUT_MESSAGE:String="Sure you want to sign out?";
		public static const DELETE_TWITTER_MESSAGE:String="Sure you want to delete this tweet?";
		public static const RETWEET_MESSAGE:String="Retweet to your followers?";
		public static const TWITTER_SERVICE_FAULT:String="Twitter is over capacity. Please wait a moment and try again."
		public static const STATUS_UPDATE_FAULT:String="Update failed, please try again.";
		public static const FOLLOW_MESSAGE:String="Sure you want to follow {0}?";
		public static const UNFOLLOW_MESSAGE:String="Sure you want to unfollow {0}?";
		public static const RATE_LIMIT_MESSAGE:String="Rate limit exceeded, please try again later.";
		
		public static function format(str:String,...rest):String{
			var newValue:String=str;
			for(var i:int=0;i<rest.length;i++){
				newValue=str.replace("{"+i+"}",rest[i]);
			}
			return newValue;
		}
	}
}