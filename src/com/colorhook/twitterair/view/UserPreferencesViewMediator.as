/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	
	import com.colorhook.twitterair.model.SystemModel;
	import com.colorhook.twitterair.model.UserPrefModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.colorhook.twitterair.vo.UserPreferences;
	
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class UserPreferencesViewMediator extends Mediator{
		
		[Inject]public var logService:ILogService;
		[Inject]public var userPreferencesView:UserPreferencesView;
		[Inject]public var systemModel:SystemModel;
		[Inject]public var userPrefModel:UserPrefModel;
		
		override public function onRegister():void{
			eventMap.mapListener(userPreferencesView,FlexEvent.SHOW,onPageShow);
			eventMap.mapListener(userPreferencesView,UIEvent.SAVE_USER_PREFERENCES,saveUserPreferences);
			eventMap.mapListener(userPreferencesView,UIEvent.CANCEL_USER_PREFERENCES,cancelUserPreferences);
			eventMap.mapListener(userPreferencesView.useProxy_check,Event.CHANGE,onUseProxyCheckBoxChanged);
			eventMap.mapListener(userPreferencesView.update_renren,Event.CHANGE,onUpdateRenrenCheckBoxChanged);
		}
		private function onPageShow(event:FlexEvent):void{
			updateView();
		}
		private function updateView():void{
			var userPreferences:UserPreferences=userPrefModel.userPreferences;
			userPreferencesView.autoLogin_check.selected=userPreferences.autoLogin;
			userPreferencesView.useProxy_check.selected=userPreferences.useProxy;
			userPreferencesView.timeSlider.value=userPreferences.updateDuration;
			userPreferencesView.update_renren.selected=userPreferences.renrenID!="";
			onUpdateRenrenCheckBoxChanged(null);
			onUseProxyCheckBoxChanged(null);
		}
		private function onUseProxyCheckBoxChanged(event:Event):void{
			var userPreferences:UserPreferences=userPrefModel.userPreferences;
			if(userPreferencesView.useProxy_check.selected){
				var address:String=userPreferences.twitterAPIProxy||userPreferences.defaultTwitterAPIProxy;
				userPreferencesView.customTwitterAPIAddr.text=address;
			}
		}
		private function onUpdateRenrenCheckBoxChanged(event:Event):void{
			var userPreferences:UserPreferences=userPrefModel.userPreferences;
			if(userPreferencesView.update_renren.selected){
				userPreferencesView.renren_id.text=userPreferences.renrenID;
				userPreferencesView.renren_password.text=userPreferences.renrenPassword;
			}else{
				userPreferencesView.renren_id.text="";
				userPreferencesView.renren_password.text="";
			}
		}
		
		private function cancelUserPreferences(event:UIEvent):void{
			updateView();
			var event2:UIEvent=new UIEvent(UIEvent.CANCEL_USER_PREFERENCES);
			this.dispatch(event2);
		}
		
		private function saveUserPreferences(event:UIEvent):void{
			var event2:UIEvent=new UIEvent(UIEvent.SAVE_USER_PREFERENCES);
			var userPref:UserPreferences=new UserPreferences;
			userPref.autoLogin=userPreferencesView.autoLogin_check.selected;
			userPref.updateDuration=userPreferencesView.timeSlider.value;
			userPref.useProxy=userPreferencesView.useProxy_check.selected;
			if(userPref.useProxy){
				userPref.twitterAPIProxy=userPreferencesView.customTwitterAPIAddr.text;
			}
			
			if(userPreferencesView.update_renren.selected){
				if(userPreferencesView.renren_id.text!=""&&userPreferencesView.renren_password.text!=""){
					userPref.renrenID=userPreferencesView.renren_id.text;
					userPref.renrenPassword=userPreferencesView.renren_password.text;
				}
			}else{
				userPref.renrenID="";
				userPref.renrenPassword="";
			}
			event2.userPref=userPref;
			this.dispatch(event2);
		}
	}
}