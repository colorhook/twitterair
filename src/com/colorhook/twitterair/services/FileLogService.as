/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.services{
	
	import com.adobe.air.logging.FileTarget;
	
	import flash.filesystem.File;
		
	public class FileLogService extends LogService{
		
		public var fileName:String="TwitterAir.log";
		
		public function FileLogService(){
			super();
		}
		
		override protected function initLogTarget():void{
			var file:File=new File(File.desktopDirectory.nativePath+"/"+fileName);
			var fielTarget:FileTarget=new FileTarget(file);
			fielTarget.includeDate=true;
			fielTarget.includeTime=true;
			Log.addTarget(fielTarget);
		}
		
	}
}