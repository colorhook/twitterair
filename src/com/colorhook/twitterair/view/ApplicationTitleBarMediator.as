/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	
	import com.colorhook.twitterair.model.UserPageModel;
	import com.colorhook.twitterair.services.ILogService;
	
	import flash.display.NativeWindow;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import mx.core.IWindow;
	
	import org.robotlegs.mvcs.Mediator;

	public class ApplicationTitleBarMediator extends Mediator{
		
		[Inject] public var titleBar:ApplicationTitleBar;
		[Inject] public var logService:ILogService;
		[Inject] public var userPageModel:UserPageModel;
		
		override public function onRegister():void{
			logService.info("ApplicationTitleBarMediator onRegister");
			eventMap.mapListener(titleBar,UIEvent.MINIMIZE,minimize);
			eventMap.mapListener(titleBar,UIEvent.MAXIMIZE,maximize);
			eventMap.mapListener(titleBar,UIEvent.CLOSE,close);
			eventMap.mapListener(titleBar.banner,MouseEvent.MOUSE_DOWN,onTitleMouseDown);

		}
		
		private function onTitleMouseDown(event:MouseEvent):void{
			eventMap.mapListener(titleBar.stage,MouseEvent.MOUSE_UP,onStageMouseUp);
			titleBar.stage.nativeWindow.startMove();
		}
		

		
		private function onStageMouseUp(event:MouseEvent):void{
			eventMap.unmapListener(titleBar.stage,MouseEvent.MOUSE_UP,onStageMouseUp);
		}
		
		private function minimize(event:UIEvent):void{
			logService.info("[User action] minimize");
			titleBar.stage.nativeWindow.minimize();
		}
		
		private function maximize(event:UIEvent):void{
			logService.info("[User action] maximize");
			var window:NativeWindow=titleBar.stage.nativeWindow;
			if(window.displayState=="normal"){
				window.maximize();
			}else{
				window.restore();
			}
		}
		
		private function close(event:UIEvent):void{
			logService.info("[User action] close");
			var dict:Dictionary=userPageModel.getAllOpendWindowsMap();
			for(var item:String in dict){
				var window:IWindow=IWindow(dict[item]);
				window.close();
			}
			titleBar.stage.nativeWindow.close();
		}
		
	}
}