/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	
	import com.colorhook.twitterair.controller.TwitterServiceEvent;
	import com.colorhook.twitterair.model.PublicModel;
	import com.colorhook.twitterair.model.PublicModelEvent;
	import com.colorhook.twitterair.model.SystemModelEvent;
	import com.colorhook.twitterair.services.ILogService;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Mediator;

	public class PublicViewMediator extends Mediator{
		
		[Inject]public var publicView:PublicView;
		[Inject]public var publicModel:PublicModel
		[Inject]public var logService:ILogService;
		
		override public function onRegister():void{
			logService.info("LoginViewMediator onRegister");
			eventMap.mapListener(eventDispatcher,
				PublicModelEvent.PUBLIC_LIST_CHANGE,onPublicModelChanged);
			eventMap.mapListener(eventDispatcher,
							SystemModelEvent.LOGIN_SUCCESS,
							onLoginSuccess);
			eventMap.mapListener(publicView.refreshButton,MouseEvent.CLICK,refreshView);
			refreshView();
		}
		
		private function onLoginSuccess(event:SystemModelEvent):void{
			refreshView();
		}
		
		public function refreshView(event:MouseEvent=null):void{			
			var event1:TwitterServiceEvent=new TwitterServiceEvent(
					TwitterServiceEvent.REFRESH_PUBLIC_TIME_LINE);
			this.dispatch(event1);
		}
		
		public function getPublicTimeLine():void{
			var event:TwitterServiceEvent=new TwitterServiceEvent(
				TwitterServiceEvent.GET_PUBLIC_TIME_LINE);
			this.dispatch(event);
		}
		
		private function onPublicModelChanged(event:PublicModelEvent):void{
			var dp:ArrayCollection=publicModel.publicTimeLineDataProvider;
			publicView.publicList.dataProvider=dp;
		}
	}
}