/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.services{
	
	public class NullLogService implements ILogService{
		
		public function NullLogService()
		{
		}

		public function info(message:String, ...rest):void
		{
		}
		
		public function debug(message:String, ...rest):void
		{
		}
		
		public function warn(message:String, ...rest):void
		{
		}
		
		public function error(message:String, ...rest):void
		{
		}
		
		public function fatal(message:String, ...rest):void
		{
		}
		
	}
}