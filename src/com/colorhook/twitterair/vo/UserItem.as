package com.colorhook.twitterair.vo{
	

	import com.swfjunkie.tweetr.data.objects.StatusData;
	
	[Bindable]
	public class UserItem{
		
		public var id:Number;
		public var name:String;
		public var description:String;
		public var url:String;
		public var location:String;
		public var lastStatus:StatusData;
		public var following:Boolean;
		public var screenName:String;
		public var profileProtected:Boolean;
		public var friendsCount:Number;
		public var followersCount:Number;
		public var statusesCount:Number;
		public var profileImageUrl:String

	}
}