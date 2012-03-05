/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.model{
	import com.colorhook.twitterair.vo.StatusItem;
	import com.colorhook.twitterair.vo.UserItem;
	import com.swfjunkie.tweetr.data.objects.StatusData;
	import com.swfjunkie.tweetr.data.objects.UserData;
	import com.swfjunkie.tweetr.utils.TweetUtil;
	
	
	/**
	 * TwitterServiceUtils is a static class to process data or response from Twitter 3rd API.
	 */
	public class TwitterServiceHelper{
		
		/**
		 * merge two array which is StatusData
		 * @see StatusData
		 */
		public function mergeResponseArray(old:Array,response:Array):Array{
			if(old.length==0){
				return response;
			}
			var oldLen:int=old.length;
			var newLen:int=response.length;
			var minOldId:Number=old[oldLen-1].id;
			var maxOldId:Number=old[0].id;
			var minNewId:Number=response[newLen-1].id;
			var maxNewId:Number=response[0].id;
			var result:Array=[];
			if(minNewId>maxOldId){
				result=response.concat(old);
			}else if(maxNewId<minOldId){
				result=old.concat(response);
			}else if(maxNewId>maxOldId){
				for(var i:int=0;i<response.length;i++){
					if(response[i].id<=maxOldId){
						break;
					}
					result.push(response[i]);
				}
				result=result.concat(old);
			}else if(maxNewId>=minOldId){
				response.shift();
				result=mergeResponseArray(old, response);
			}
			return result;
		}
				
		public function statusDataToStatusItem(statusData:StatusData):StatusItem{
			var statusItem:StatusItem=new StatusItem;
			statusItem.text=formatTweet(statusData.text);
			statusItem.userId=statusData.user.id;
			statusItem.name=statusData.user.name;
			statusItem.screenName=statusData.user.screenName;
			statusItem.createAt=TweetUtil.returnTweetAge(statusData.createdAt);
			statusItem.tweetId=statusData.id;
			statusItem.source=statusData.source;
			statusItem.favorited=statusData.favorited;
			statusItem.profileImageUrl=statusData.user.profileImageUrl;
			return statusItem;
		}
		
		public function userDataToUserItem(userData:UserData):UserItem{
			var userItem:UserItem=new UserItem;
			userItem.id=userData.id;
			userItem.name=userData.name;
			userItem.url=userData.url;
			userItem.screenName=userData.screenName;
			userItem.profileImageUrl=userData.profileImageUrl;
			userItem.following=userData.extended.following;
			userItem.lastStatus=userData.lastStatus;
			userItem.description=userData.description;
			userItem.followersCount=userData.followersCount;
			userItem.location=userData.location;
			userItem.profileProtected=userData.profileProtected;
			userItem.friendsCount=userData.extended.friendsCount;
			userItem.statusesCount=userData.extended.statusesCount;
			return userItem;
		}
		/**
		 * @description replace '&lt' to '<', '&gl' to '>', '&amp;' to '&' 
		 */
		public function formatTweet(str:String):String{
			var result:String=str?str:"";
			result=result.replace(new RegExp('&lt;','g'),'<');
			result=result.replace(new RegExp('&gt;','g'),'>');
			result=result.replace(new RegExp('&amp;','g'),'&');
			return result;
		}
	}
}