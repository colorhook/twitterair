/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.UserPrefModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.colorhook.twitterair.view.UIEvent;
	import com.colorhook.twitterair.vo.UserPreferences;
	
	import org.robotlegs.mvcs.Command;

	public class SaveUserPreferencesCommand extends Command{
		
		[Inject]public var userPrefModel:UserPrefModel;
		[Inject]public var logService:ILogService;
		[Inject]public var event:UIEvent;
		
		override public function execute():void{
			logService.info("SaveUserPreferencesCommand execute");
			var userPreferences:UserPreferences=userPrefModel.userPreferences;
			var newUserPref:UserPreferences=event.userPref;
			
			if(newUserPref.password){
				userPreferences.username=newUserPref.username;
				userPreferences.password=newUserPref.password;
			}else{
				userPreferences.useProxy=newUserPref.useProxy;
				if(newUserPref.useProxy){
					userPreferences.twitterAPIProxy=newUserPref.twitterAPIProxy;
					if(!userPreferences.twitterAPIProxy||userPreferences.twitterAPIProxy==""){
						userPreferences.twitterAPIProxy=userPreferences.defaultTwitterAPIProxy;
					}
				}else{
					userPreferences.twitterAPIProxy="";
				}
				userPreferences.updateDuration=newUserPref.updateDuration;
				if(newUserPref.renrenID!=""){
					userPreferences.renrenID=newUserPref.renrenID;
					userPreferences.renrenPassword=newUserPref.renrenPassword
				}else{
					userPreferences.renrenID="";
					userPreferences.renrenPassword="";
				}
			}
			userPreferences.autoLogin=newUserPref.autoLogin;
			
				
			userPrefModel.userPreferences=userPreferences;
		}
	}
}