/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	
	import com.colorhook.twitterair.model.MessageConst;
	import com.colorhook.twitterair.model.SystemModel;
	import com.colorhook.twitterair.model.SystemModelEvent;
	import com.colorhook.twitterair.model.UserPrefModel;
	import com.colorhook.twitterair.model.UserPrefModelEvent;
	import com.colorhook.twitterair.services.ILogService;
	import com.colorhook.twitterair.vo.UserPreferences;
	
	import mx.controls.Alert;
	
	import org.robotlegs.mvcs.Mediator;

	public class LoginViewMediator extends Mediator{
		
		[Inject]public var loginView:LoginView;
		[Inject]public var systemModel:SystemModel;
		[Inject]public var userPrefModel:UserPrefModel;
		[Inject]public var logService:ILogService;

		override public function onRegister():void{
			logService.info("LoginViewMediator onRegister");
			eventMap.mapListener(loginView, UIEvent.LOGIN_REQUEST,onLoginRequest);
			eventMap.mapListener(eventDispatcher,SystemModelEvent.LOGIN_FAILED,onLoginFailed);
			eventMap.mapListener(eventDispatcher,
					SystemModelEvent.TWITTER_SERVER_DOWN,onTwitterServiceFailed);
			eventMap.mapListener(eventDispatcher,SystemModelEvent.LOGOUT_SUCCESS,onLogout);
			eventMap.mapListener(eventDispatcher,UserPrefModelEvent.USER_PREF_SAVED,onUserPrefSaved);
			initViewWithUserPref(userPrefModel.userPreferences);
		}

		private function initViewWithUserPref(userPref:UserPreferences):void{
			loginView.username_txt.text=userPref.username;
			loginView.autoLogin_check.selected=userPref.autoLogin;
			if(userPref.autoLogin){
				loginView.password_txt.text=userPref.password;
				onLoginRequest(null);
			}
		}
		private function onUserPrefSaved(event:UserPrefModelEvent):void{
			loginView.autoLogin_check.selected=userPrefModel.userPreferences.autoLogin;
		}
		private function onLogout(event:SystemModelEvent):void{
			loginView.password_txt.text="";
			loginView.submitButton.enabled=true;
		}
		private function onLoginFailed(event:SystemModelEvent):void{
			logService.info("LoginViewMediator login failed");
			loginView.submitButton.enabled=true;
			Toast.makeText(MessageConst.LOGIN_FAILED_MESSAGE);
		}
		private function onTwitterServiceFailed(event:SystemModelEvent):void{
			logService.info("LoginViewMediator onTwitterServiceFailed");
			loginView.submitButton.enabled=true;
			systemModel.loggedIn=false;
			Alert.show(MessageConst.TWITTER_SERVICE_FAULT);
		}
		private function onLoginRequest(event:UIEvent):void{
			logService.info("LoginViewMediator onLoginRequest");
			var event:UIEvent=new UIEvent(UIEvent.LOGIN_REQUEST);
			event.userPref=new UserPreferences;
			event.userPref.username=loginView.username_txt.text;
			event.userPref.password=loginView.password_txt.text;
			event.userPref.autoLogin=loginView.autoLogin_check.selected;
			loginView.submitButton.enabled=false;
			this.dispatch(event);
		}
	}
}