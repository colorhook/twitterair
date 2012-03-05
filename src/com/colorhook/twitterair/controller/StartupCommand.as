/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.SystemModelEvent;
	import com.colorhook.twitterair.services.ILogService;
	
	import flash.events.UncaughtErrorEvent;
	import flash.events.UncaughtErrorEvents;
	
	import org.robotlegs.mvcs.Command;

	public class StartupCommand extends Command{
		
		[Inject]public var logService:ILogService;
		
		override public function execute():void{
			logService.info("StartupCommand execute");
			catchGlobalErrors();
			doUpdate();
		}
		
		private function doUpdate():void{
			var event:SystemModelEvent=new SystemModelEvent(
						SystemModelEvent.AUTO_UPDATE_REQUEST);
			this.dispatch(event);
		}
		
		private function catchGlobalErrors():void{
			var globalErrorEvents:UncaughtErrorEvents=contextView.loaderInfo.uncaughtErrorEvents;
			globalErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,errorHandler);
		}
		private function errorHandler(event:UncaughtErrorEvent):void{
			logService.error("[Global Error]"+event.toString());
			event.preventDefault();
		}
		
	}
}