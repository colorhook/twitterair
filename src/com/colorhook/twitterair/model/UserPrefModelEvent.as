/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model{
	
	import flash.events.Event;

	public class UserPrefModelEvent extends Event{
		

		public static const USER_PREF_LOAD:String="UserPrefModelEvent_userPrefLoad";
		public static const USER_PREF_SAVED:String="UserPrefModelEvent_userPrefSaved";
		
		public function UserPrefModelEvent(type:String, 
					bubbles:Boolean=false, 
					cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
	}
}