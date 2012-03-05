/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view{

	import com.colorhook.twitterair.model.MessageConst;
	import com.colorhook.twitterair.model.SystemModel;
	import com.colorhook.twitterair.model.SystemModelEvent;
	import com.colorhook.twitterair.services.ILogService;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.robotlegs.mvcs.Mediator;

	public class ApplicationViewMediator extends Mediator{

		[Inject]public var view:ApplicationView;
		[Inject]public var logService:ILogService;
		[Inject]public var systemModel:SystemModel;
		
		override public function onRegister():void{
			logService.info("ApplicationView onRegister");
			eventMap.mapListener(eventDispatcher,
					SystemModelEvent.LOGIN_SUCCESS,onLoginSuccess);
			eventMap.mapListener(eventDispatcher,
					SystemModelEvent.LOGOUT_SUCCESS,onLogoutSuccess);
			eventMap.mapListener(view.resizeButton,
					MouseEvent.MOUSE_DOWN,onResizeButtonClicked);
			eventMap.mapListener(eventDispatcher,
					SystemModelEvent.CURRENT_PAGE_CHANGED,onCurrentPageChanged);
			eventMap.mapListener(view.menu,Event.CHANGE,onMenuChanged);
			eventMap.mapListener(view,UIEvent.LOGOUT_REQUEST,doLogout);
			
			eventMap.mapListener(view,UIEvent.GO_BACK,goBack);
			eventMap.mapListener(view,UIEvent.ABOUT,showAbout);
			eventMap.mapListener(view,UIEvent.USER_PREF,gotoUserPref);
			eventMap.mapListener(eventDispatcher,UIEvent.CANCEL_USER_PREFERENCES,onUserPrefSaved);
			eventMap.mapListener(eventDispatcher,UIEvent.SAVE_USER_PREFERENCES,onUserPrefSaved);
		}

		private function onMenuChanged(event:Event):void{
			var selectedIndex:int=view.menu.selectedIndex;
			systemModel.currentPage=selectedIndex;
		}
		private function gotoUserPref(event:UIEvent):void{
			view.menu.visible=view.menu.includeInLayout=false;
			view.viewStack.selectedIndex=2;
			view.settingButton.visible=view.settingButton.includeInLayout=false;
			view.homeButton.visible=view.homeButton.includeInLayout=true;
		}
		private function goBack(event:UIEvent):void{
			onUserPrefSaved(null)
		}
		private function showAbout(event:UIEvent):void{
			var aboutView:AboutView=PopUpManager.createPopUp(this.contextView,AboutView,true) as AboutView;
			aboutView.toCenter();
		}
		private function onUserPrefSaved(event:UIEvent):void{
			if(systemModel.loggedIn){
				view.menu.visible=view.menu.includeInLayout=true;
				view.viewStack.selectedIndex=1;
			}else{
				view.viewStack.selectedIndex=0;
			}
			view.homeButton.visible=view.homeButton.includeInLayout=false;
			view.settingButton.visible=view.settingButton.includeInLayout=true;
		}
		/**
		 * @description execute on systemModel.currentPage changed
		 */ 
		 private function onCurrentPageChanged(event:SystemModelEvent):void{
		 	view.mainView.selectedIndex=systemModel.currentPage;
		 }
		 
		private function doLogout(event:UIEvent):void{
			Alert.show(MessageConst.LOGOUT_MESSAGE,"",
					Alert.YES|Alert.NO,null,alertCloseHandler);
		}
		
		private function alertCloseHandler(event:CloseEvent):void{
			if(event.detail==Alert.YES){
				this.dispatch(new UIEvent(UIEvent.LOGOUT_REQUEST));
			}
		}
		
		private function onLoginSuccess(event:SystemModelEvent):void{
			view.menu.visible=view.menu.includeInLayout=true;
			view.logoutButton.visible=true;
			view.viewStack.selectedIndex=1;
		}
		private function onLogoutSuccess(event:SystemModelEvent):void{
			view.menu.visible=view.menu.includeInLayout=false;
			view.logoutButton.visible=false;
			view.viewStack.selectedIndex=0;
			view.mainView.selectedIndex=0;
			view.menu.selectedIndex=0;
		}
		private function onResizeButtonClicked(event:MouseEvent):void{
			view.stage.nativeWindow.startResize();
		}
		
	}
}