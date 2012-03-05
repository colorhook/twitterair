/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model{
	
	import flash.events.Event;

	public class UserModelEvent extends Event{
		
		public static const HOME_LIST_CHANGE:String="UserModelEvent_homeListChange";
		public static const USER_LIST_CHANGE:String="UserModelEvent_userListChange";
		public static const USER_DATA_CHANGE:String="UserModelEvent_userDataChange";
		public static const STATUS_UPDATE_FAULT:String="UserModelEvent_statusUpdateFault";
		public static const STATUS_UPDATE_COMPLETE:String="UserModelEvent_statusUpdateComplete";
		
		public function UserModelEvent(type:String, 
						bubbles:Boolean=false, 
						cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
	}
}