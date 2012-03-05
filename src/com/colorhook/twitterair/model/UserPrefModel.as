/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model{
	
	import com.colorhook.twitterair.controller.UserPreferencesManager;
	import com.colorhook.twitterair.vo.UserPreferences;
	
	import org.robotlegs.mvcs.Actor;

	public class UserPrefModel extends Actor{
		
		private var _userPreferences:UserPreferences;
		
		public function get userPreferences():UserPreferences{
			if(!_userPreferences){
				_userPreferences=UserPreferencesManager.loadUserPreferences();
				if(!_userPreferences){
					_userPreferences=new UserPreferences;
				}
			}
			return _userPreferences;
		}
		
		public function set userPreferences(value:UserPreferences):void{
			_userPreferences=value;
			if(!_userPreferences.autoLogin){
				_userPreferences.password="";
			}
			UserPreferencesManager.saveUserPreferences(_userPreferences);
			this.dispatch(new UserPrefModelEvent(UserPrefModelEvent.USER_PREF_SAVED));
		}
	}
}