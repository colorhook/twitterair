/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair{
	
	import com.colorhook.twitterair.controller.*;
	import com.colorhook.twitterair.model.*;
	import com.colorhook.twitterair.services.*;
	import com.colorhook.twitterair.view.*;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	public class TwitterAirContext extends Context{
		
		
		/**
		 * The Startup Hook
		 * in this hook, initialize Model, Service, Controller and View
		 * follow the MVCS Design Pattern.
		 */ 
		override public function startup():void{	
			initializeModel();
			initializeController();
			initializeView();
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
		}
		/**
		 * initialize model and service.
		 * map Actor (contains Model and Service)
		 */ 
		protected function initializeModel():void{
			injector.mapSingleton(SystemModel);
			injector.mapSingleton(UserPrefModel);
			injector.mapSingleton(UserModel);
			injector.mapSingleton(SearchModel);
			injector.mapSingleton(FriendsModel);
			injector.mapSingleton(FollowersModel);
			injector.mapSingleton(PublicModel);
			injector.mapSingleton(TwitterServiceHelper);
			injector.mapSingleton(UserPageModel);
			/**/injector.mapSingletonOf(ILogService,NullLogService);
			//*/injector.mapSingletonOf(ILogService,LogService);
		}
		/**
		 * initialize controller
		 * map Event and Command
		 */ 
		protected function initializeController():void{
			commandMap.mapEvent(ContextEvent.STARTUP,StartupCommand,ContextEvent,true);
			commandMap.mapEvent(SystemModelEvent.AUTO_UPDATE_REQUEST,
								AutoUpdateCommand,SystemModelEvent,true);
			commandMap.mapEvent(UIEvent.LOGIN_REQUEST,LoginCommand);
			commandMap.mapEvent(UIEvent.LOGOUT_REQUEST,LogoutCommand);
			commandMap.mapEvent(SystemModelEvent.LOGIN_SUCCESS,LoginSuccessCommand);
			commandMap.mapEvent(SystemModelEvent.LOGOUT_SUCCESS,LogoutSuccessCommand);
			commandMap.mapEvent(UIEvent.SAVE_USER_PREFERENCES,SaveUserPreferencesCommand);
			commandMap.mapEvent(UIEvent.BROWSE_USER,BrowseUserCommand);
			initializeTwitterCommands();
			initializeSNSCommands();
		}
		/**
		 * initialize view
		 * map View and Mediator
		 */ 
		protected function initializeView():void{
	
			mediatorMap.mapView(ApplicationView,ApplicationViewMediator);
			mediatorMap.mapView(LoginView,LoginViewMediator);
			mediatorMap.mapView(MainView,MainViewMediator);
			
			mediatorMap.mapView(HomeView,HomeViewMediator);
			mediatorMap.mapView(UserProfileView,UserProfileViewMediator);
			mediatorMap.mapView(UserPreferencesView,UserPreferencesViewMediator);
			mediatorMap.mapView(TwitterStatusList,TwitterStatusListMediator);
			mediatorMap.mapView(TwitterUserList,TwitterUserListMediator);
			mediatorMap.mapView(ApplicationTitleBar,ApplicationTitleBarMediator);
			mediatorMap.mapView(UpdateTwitterView,UpdateTwitterViewMediator);
			mediatorMap.mapView(PublicView,PublicViewMediator);
			mediatorMap.mapView(SearchUserView,SearchUserViewMediator);
			mediatorMap.mapView(FriendsView,FriendsViewMediator);
			mediatorMap.mapView(FollowersView,FollowersViewMediator);

		}
		/**
		 * initialize twitter service commands
		 * If I want to get a user data or publish a tweet to twitter.com, All I need to do is dispatch a 
		 * TwitterServiceEvent on a Meditor
		 * @see TwitterServiceEvent
		 * @see TwitterCommand
		 */ 
		protected function initializeTwitterCommands():void{
			commandMap.mapEvent(TwitterServiceEvent.GET_PUBLIC_TIME_LINE,GetPublicTimeLineCommand);
			commandMap.mapEvent(TwitterServiceEvent.GET_HOME_TIME_LINE,GetHomeTimeLineCommand);
			commandMap.mapEvent(TwitterServiceEvent.REFRESH_HOME_TIME_LINE,RefreshHomeTimeLineCommand);
			commandMap.mapEvent(TwitterServiceEvent.REFRESH_PUBLIC_TIME_LINE,RefreshPublicTimeLineCommand);
			commandMap.mapEvent(TwitterServiceEvent.REFRESH_USER_TIME_LINE,RefreshUserTimeLineCommand);
			commandMap.mapEvent(TwitterServiceEvent.GET_USER_TIME_LINE,GetUserTimeLineCommand);
			commandMap.mapEvent(TwitterServiceEvent.GET_USER_DETAIL,GetUserDetailCommand);
			commandMap.mapEvent(TwitterServiceEvent.GET_SELF_DETAIL,GetSelfDetailCommand);
			
			commandMap.mapEvent(TwitterServiceEvent.UPDATE_STATUS,UpdateStatusCommand);
			commandMap.mapEvent(TwitterServiceEvent.DELETE_STATUS,DeleteStatusCommand);
			commandMap.mapEvent(TwitterServiceEvent.RETWEET,RetweetCommand);
			commandMap.mapEvent(TwitterServiceEvent.FAVORITE,FavoriteCommand);
			commandMap.mapEvent(TwitterServiceEvent.FOLLOW_USER,FollowUserCommand);
			commandMap.mapEvent(TwitterServiceEvent.UNFOLLOW_USER,UnfollowUserCommand);
			commandMap.mapEvent(TwitterServiceEvent.BLOCK_USER,BlockUserCommand);
			commandMap.mapEvent(TwitterServiceEvent.UNBLOCK_USER,UnblockUserCommand);
			commandMap.mapEvent(TwitterServiceEvent.UPDATE_PROFILE_IMAGE,UpdateProfileImageCommand);
			commandMap.mapEvent(TwitterServiceEvent.GET_FRIENDS,GetFriendsCommand);
			commandMap.mapEvent(TwitterServiceEvent.GET_FOLLOWERS,GetFollowersCommand);
			commandMap.mapEvent(TwitterServiceEvent.SEARCH_USER,SearchUserCommand);
		}
		
		protected function initializeSNSCommands():void{
			commandMap.mapEvent(SNSEvent.RENREN,UpdateRenrenCommand);
		}
		
		
	}
}