/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model{
	
	import flash.events.Event;
	
	public class FriendsModelEvent extends Event{
		
		public static const FRIENDS_GET:String="FriendsModelEvent_friendsGet";
		
		public function FriendsModelEvent(type:String, 
										  bubbles:Boolean=false, 
										  cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
	}
}