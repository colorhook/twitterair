/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	import org.robotlegs.mvcs.Mediator;
	
	public class AboutViewMediator extends Mediator{
		
		[Inject]public var aboutView:AboutView;
		
		override public function onRegister():void{
		}
	
	}
}
