/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller
{
	import com.colorhook.twitterair.model.SystemModel;
	import com.colorhook.twitterair.services.ILogService;
	
	import org.robotlegs.mvcs.Command;
	
	public class LogoutSuccessCommand extends Command
	{
		[Inject]public var logService:ILogService;
		[Inject]public var systemModel:SystemModel;
		
		override public function execute():void
		{
			logService.info("LogoutSuccessCommand execute");
		}
	}
}