/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model
{
	import flash.events.Event;
	
	public class UserPageModelEvent extends Event
	{
		public static const USER_DATA_CHANGED:String="UserPageModelEvent_userDataChanged";
		public static const USER_STATUSES_CHANGED:String="UserPageModelEvent_userStatusesChanged";
		
		public var screenName:String;
		
		public function UserPageModelEvent(type:String, 
										  bubbles:Boolean=false, 
										  cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}

	}
}