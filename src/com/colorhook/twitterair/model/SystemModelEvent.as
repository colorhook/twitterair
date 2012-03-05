/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model{
	
	import flash.events.Event;

	public class SystemModelEvent extends Event{
		
		public static const LOGIN_SUCCESS:String='SystemModelEvent_loginSuccess';
		public static const LOGIN_FAILED:String="SystemModelEvent_loginFailed";
		public static const SHOW_LOGIN_PANEL:String="SystemModelEvent_showLoginPanel";
		public static const LOGOUT_SUCCESS:String="SystemModelEvent_logoutSuccess";
		public static const CURRENT_PAGE_CHANGED:String="SystemModelEvent_currentPageChanged";
		public static const TWITTER_SERVER_DOWN:String="SystemModelEvent_twitterServerDown";
		
		public static const AUTO_UPDATE_REQUEST:String="SystemModelEvent_autoUpateRequest";
		public static const AUTO_UPDATE_START:String="SystemModelEvent_autoUpateStart";
		public static const AUTO_UPDATE_FAULT:String="SystemModelEvent_autoUpateFault";
		public static const AUTO_UPDATE_COMPLETE:String="SystemModelEvent_autoUpateComplete";
		
		public function SystemModelEvent(type:String, 
					bubbles:Boolean=false, 
					cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
	}
}