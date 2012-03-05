/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import com.colorhook.twitterair.model.SystemModelEvent;
	import com.colorhook.twitterair.model.UserPrefModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.colorhook.twitterair.vo.UserPreferences;
	
	import org.robotlegs.mvcs.Command;

	public class AutoUpdateCommand extends Command{
		
		[Inject]public var logService:ILogService;
		[Inject]public var userPrefModel:UserPrefModel;
		
		private var updateUI:ApplicationUpdaterUI=new ApplicationUpdaterUI();
		
		override public function execute():void{
			logService.info("AutoUpdateCommand execute");
			var userPreferences:UserPreferences=userPrefModel.userPreferences;
			updateUI=new ApplicationUpdaterUI();
			updateUI.updateURL=userPreferences.AIRUpdateAddress;
			updateUI.isCheckForUpdateVisible=false;
			updateUI.addEventListener(UpdateEvent.INITIALIZED,onUpdateUIInitialize);
			updateUI.initialize();
		} 
		
		private function onUpdateUIInitialize(event:UpdateEvent):void{
			logService.info("StartupCommand updateUI initialize");
			var updateUI:ApplicationUpdaterUI=event.target as ApplicationUpdaterUI;
			updateUI.removeEventListener(UpdateEvent.INITIALIZED,onUpdateUIInitialize);
			updateUI.checkNow();
		}
		
	}
}