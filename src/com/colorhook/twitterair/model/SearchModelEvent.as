/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model{
	
	import flash.events.Event;

	public class SearchModelEvent extends Event{
		
		public static const USER_NOT_FOUND:String="SearchModelEvent_userNotFound";
		public static const SEARCH_COMPLETE:String="SearchModelEvent_searchComplete";
		
		public function SearchModelEvent(type:String, 
										 bubbles:Boolean=false, 
										 cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
	}
}