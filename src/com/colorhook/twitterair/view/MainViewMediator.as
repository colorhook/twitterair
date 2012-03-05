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
	import com.colorhook.twitterair.services.ILogService;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import org.robotlegs.mvcs.Mediator;

	public class MainViewMediator extends Mediator{
		
		[Inject]public var mainView:MainView;
		[Inject]public var logService:ILogService;
		[Inject]public var systemModel:SystemModel;
		
		override public function onRegister():void{
			logService.info("MainViewMediator onRegister");
		}
	}
}