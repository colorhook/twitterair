/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.services
{
	
	public interface ILogService
	{
		function info(message:String,...rest):void;
		
		function debug(message:String,...rest):void;
		
		function warn(message:String,...rest):void;
		
		function error(message:String,...rest):void;
		
		function fatal(message:String,...rest):void;
		
	}
}