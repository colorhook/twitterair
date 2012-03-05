/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.services{
	
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.logging.targets.TraceTarget;
	
	import org.robotlegs.mvcs.Actor;

	public class LogService extends Actor implements ILogService{
		
		protected var logger:ILogger
		
		public function LogService(){
			logger=Log.getLogger("TwitterAir");
			initLogTarget();
			this.info("Log setup");
		}
		
		protected function initLogTarget():void{
			var traceTarget:TraceTarget=new TraceTarget();
			traceTarget.includeDate=true;
			traceTarget.includeTime=true;
			Log.addTarget(traceTarget);
		}
		
		public function info(message:String, ...rest):void{
			logger.info(message,rest);
		}
		
		public function debug(message:String, ...rest):void{
			logger.debug(message,rest);
		}
		
		public function warn(message:String, ...rest):void{
			logger.warn(message,rest);
		}
		
		public function error(message:String, ...rest):void{
			logger.error(message,rest);
		}
		
		public function fatal(message:String, ...rest):void{
			logger.fatal(message,rest);
		}
		
	}
}