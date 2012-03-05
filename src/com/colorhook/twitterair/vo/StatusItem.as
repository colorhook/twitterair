/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.vo{
	
	import com.colorhook.twitterair.controller.ProfileImagePool;
	import flash.display.Bitmap;
	
	[Bindable]
	public class StatusItem{
		
		public var createAt:String;
		public var source:String;
		public var favorited:Boolean;
		public var name:String;
		public var screenName:String;
		public var userId:Number;
		public var tweetId:Number;
		public var date:Date;
		public var text:String;
		public var isMyTweet:Boolean;
		public var profileImageUrl:String;

	}
}