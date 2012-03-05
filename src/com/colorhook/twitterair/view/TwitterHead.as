/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	
	import com.colorhook.twitterair.controller.ProfileImagePool;
	
	import flash.display.Bitmap;
	
	import mx.controls.Image;

	public class TwitterHead extends Image{
		
		protected var profileImagePool:ProfileImagePool=ProfileImagePool.getInstance();
		private var imageAddr:String;
		
		public function TwitterHead(){
			super();
		}
		
		override public function set source(value:Object):void{
			if(value is String){
				if(value==imageAddr){
					return;
				}
				imageAddr=String(value);
				if(profileImagePool.get(imageAddr)){
					super.source=new Bitmap(profileImagePool.get(imageAddr))
				}else{
					super.source=null;
					profileImagePool.registerImage(imageAddr,this);
				}
				return;
			}
			imageAddr=null;
			super.source=value;
		}
		
	}
}