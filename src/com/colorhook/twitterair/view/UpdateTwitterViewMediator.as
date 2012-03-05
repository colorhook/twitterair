/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{
	
	import caurina.transitions.Tweener;
	
	import com.colorhook.twitterair.controller.TwitterServiceEvent;
	import com.colorhook.twitterair.model.MessageConst;
	import com.colorhook.twitterair.model.SystemModel;
	import com.colorhook.twitterair.model.SystemModelEvent;
	import com.colorhook.twitterair.model.UserModelEvent;
	import com.colorhook.twitterair.services.ILogService;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.controls.Alert;
	import mx.events.FlexEvent;
	
	import org.robotlegs.mvcs.Mediator;

	public class UpdateTwitterViewMediator extends Mediator{
		
		[Inject]public var updateTwitterView:UpdateTwitterView;
		[Inject]public var systemModel:SystemModel;
		[Inject]public var logService:ILogService;
		
		private var replyToStatusId:Number=0;
		
		override public function onRegister():void{	
			eventMap.mapListener(updateTwitterView.submit_btn,MouseEvent.CLICK,submitStatus);
			eventMap.mapListener(updateTwitterView.status_input,KeyboardEvent.KEY_DOWN,onInputKeyDown);
			eventMap.mapListener(updateTwitterView.status_input,Event.CHANGE,onUserInputTwitter);
			
			eventMap.mapListener(eventDispatcher,UIEvent.REPLY_TWITTER,replyTwitter,UIEvent);
			eventMap.mapListener(eventDispatcher,UIEvent.RETWEET_TWITTER,retweetTwitter,UIEvent);
			
			eventMap.mapListener(eventDispatcher,SystemModelEvent.LOGIN_SUCCESS,onLogin);
			
			eventMap.mapListener(eventDispatcher,UserModelEvent.STATUS_UPDATE_COMPLETE,
									onStatusUpdateComplete);
			eventMap.mapListener(updateTwitterView.status_input,FocusEvent.FOCUS_IN,expandUpdateArea);
			eventMap.mapListener(updateTwitterView.status_input,FocusEvent.FOCUS_OUT,collapseUpdateArea);
			eventMap.mapListener(eventDispatcher,UserModelEvent.STATUS_UPDATE_FAULT,
									onStatusUpdateFault);
			onLogin(null);
		}
		
		private function onInputKeyDown(event:KeyboardEvent):void{
			if(event.altKey&&event.keyCode==Keyboard.S){
				submitStatus();
			}else if(event.ctrlKey&&event.keyCode==Keyboard.ENTER){
				submitStatus();
			}
		}
		
		private function onLogin(event:SystemModelEvent):void{
			updateView();
		}
		
		private function onUserInputTwitter(event:Event):void{
			updateView();
		}
		
		private function expandUpdateArea(event:FocusEvent=null):void{
			Tweener.addTween(updateTwitterView,{pHeight:60,time:0.2});
		}
		
		private function collapseUpdateArea(event:FocusEvent=null):void{
			if(updateTwitterView.status_input.text.length==0)
			Tweener.addTween(updateTwitterView,{pHeight:30,time:0.2});
		}
		
		protected function updateView():void{
			var inputContent:String=updateTwitterView.status_input.text;
			if(inputContent==""){
				replyToStatusId=0;
				updateTwitterView.submit_btn.enabled=false;
			}else{
				updateTwitterView.submit_btn.enabled=true;
			}
			inputContent=inputContent.replace("\r"," ");
			updateTwitterView.status_input.text=inputContent;
			if(inputContent.charAt(0)=="@"){
				updateTwitterView.submit_btn.label="Reply";
			}else{
				replyToStatusId=0;
				updateTwitterView.submit_btn.label="Update";
			}
			var leaveCount:Number=140-inputContent.length;
			var countColor:uint;
			if(leaveCount>=60){
				countColor=0xCCCCCC;
			}else if(leaveCount>=20){
				countColor=0xCC6666;
			}else{
				countColor=0xCC3333;
			}
			updateTwitterView.twitterWordsCounter.setStyle("color",countColor);
			updateTwitterView.twitterWordsCounter.text=String(leaveCount);
		}
		
		private function replyTwitter(event:UIEvent):void{
			replyToStatusId=event.tweetId;
			updateTwitterView.status_input.setFocus();
			var str:String="@"+event.replyUsername+" ";
			updateTwitterView.status_input.text=str;
			updateTwitterView.status_input.setSelection(str.length,str.length);
			updateView();
		}
		private function retweetTwitter(event:UIEvent):void{
			var str:String=" RT @"+event.screenName+": "+event.status;
			if(str.length>140){
				str=str.substr(0,137)+"...";
			}
			updateTwitterView.status_input.text=str;
			updateTwitterView.status_input.setFocus();
			updateTwitterView.status_input.setSelection(0,0);
			updateView();
		}
		
		private function submitStatus(event:Event=null):void{
			var event2:TwitterServiceEvent=new TwitterServiceEvent(
				TwitterServiceEvent.UPDATE_STATUS
			);
			event2.statusText=updateTwitterView.status_input.text;
			event2.replyToStatusId=replyToStatusId;
			dispatch(event2);
			updateTwitterView.status_input.enabled=false;
			updateView();
		}
		
		private function onStatusUpdateFault(event:UserModelEvent):void{
			updateTwitterView.status_input.enabled=true;
			Alert.show(MessageConst.STATUS_UPDATE_FAULT);
			collapseUpdateArea();
			updateView();
		}
		private function onStatusUpdateComplete(event:UserModelEvent):void{
			updateTwitterView.status_input.text="";
			updateTwitterView.status_input.enabled=true;
			collapseUpdateArea();
			updateView();
		}
		
	}
}