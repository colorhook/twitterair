/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{

	 import flash.utils.Dictionary;
	 import flash.utils.Timer;
	 import flash.events.TimerEvent;
	 
	public class TimerCallLater{
		
		private var _duration:Number;
		private var methods:Dictionary;
		private var _timer:Timer;
		private var inCallLaterPhase:Boolean=false;
		
		public function TimerCallLater(duration:Number){
			this._duration=duration;
			methods=new Dictionary();
			_timer=new Timer(_duration);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
		}
		
		public function call(fun:Function):void{

			methods[fun]=true;
			
			if(!_timer.running){
				_timer.start();
			}
		}
		
		private function timerHandler(event:TimerEvent):void {
			_timer.stop()
			for (var method:Object in methods) {
				delete(methods[method]);
				method();
			}
		}
		
		
		public function get duration():Number{
			return _duration;
		}
		
		public function set duration(value:Number):void{
			if(value==_duration){
				return;
			}
			_duration=value;
			var running:Boolean=_timer.running;
			_timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			_timer=new Timer(_duration);
			_timer.addEventListener(TimerEvent.TIMER,timerHandler);
			if(running){
				_timer.start();
			}
		}
		
	}
}