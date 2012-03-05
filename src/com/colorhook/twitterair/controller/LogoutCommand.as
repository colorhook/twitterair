/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
	import com.colorhook.twitterair.model.FollowersModel;
	import com.colorhook.twitterair.model.FriendsModel;
	import com.colorhook.twitterair.model.PublicModel;
	import com.colorhook.twitterair.model.SearchModel;
	import com.colorhook.twitterair.model.SystemModel;
	import com.colorhook.twitterair.model.UserModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.colorhook.twitterair.view.HomeView;
	
	import org.robotlegs.mvcs.Command;

	public class LogoutCommand extends Command{
		
		[Inject]public var systemModel:SystemModel;
		[Inject]public var userModel:UserModel;
		[Inject]public var followersModel:FollowersModel;
		[Inject]public var friendsModel:FriendsModel;
		[Inject]public var publicModel:PublicModel;
		[Inject]public var searchModel:SearchModel;
		[Inject]public var logService:ILogService;
		
		override public function execute():void{
			logService.info("LogoutCommand execute");
			userModel.homeTimeline=null;
			userModel.userTimeline=null;
			userModel.userData=null;
			followersModel.followers=null;
			friendsModel.friends=null;
			publicModel.publicTimeLine=null;
			searchModel.users=null;
			systemModel.loggedIn=false;
		}
		
	}
}