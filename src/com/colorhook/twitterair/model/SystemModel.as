/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model{
	
	import com.colorhook.twitterair.services.ILogService;
	
	import org.robotlegs.mvcs.Actor;

	public class SystemModel extends Actor{
		
		public var username:String=""
		public var password:String="";
		public var autoLogin:Boolean;
		
		private var _loggedIn:Boolean;

		private var _currentPage:int=0;
		
		[Inject]public var logService:ILogService;
		
		public function get loggedIn():Boolean{
			return _loggedIn;
		}
		
		public function set loggedIn(value:Boolean):void{
			if(value==_loggedIn){
				return;
			}
			_loggedIn=value;
			if(_loggedIn){
				dispatch(new SystemModelEvent(SystemModelEvent.LOGIN_SUCCESS));
			}else{
				dispatch(new SystemModelEvent(SystemModelEvent.LOGOUT_SUCCESS));
			}
			logService.info("[SystemModel change] "+(_loggedIn?"Login":"Logout"));
		}
		/////////////get and set current page///////////
		public function get currentPage():int{
			return _currentPage;
		}
		public function set currentPage(value:int):void{
			if(value==_currentPage){
				return;
			}
			_currentPage=value;
			dispatch(new SystemModelEvent(SystemModelEvent.CURRENT_PAGE_CHANGED));
		}
		
	}
}