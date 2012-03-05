/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model{
	
	import com.colorhook.twitterair.vo.StatusItem;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Actor;

	public class PublicModel extends Actor{
		
		private var _publicTimeLine:Array=[];
		
		[Inject]public var helper:TwitterServiceHelper;
		
		public function get publicTimeLine():Array{
			return _publicTimeLine||[];
		}
		
		public function set publicTimeLine(value:Array):void{
			_publicTimeLine=value||[];
			dispatch(new PublicModelEvent(PublicModelEvent.PUBLIC_LIST_CHANGE));
		}
		
		public function get publicTimeLineDataProvider():ArrayCollection{
			var result:ArrayCollection=new ArrayCollection;
			for(var i:int=0;i<_publicTimeLine.length;i++){
				var statusItem:StatusItem;
				statusItem=helper.statusDataToStatusItem(_publicTimeLine[i]);
				result.addItem(statusItem);
			}
			return result;
		}
	}
}