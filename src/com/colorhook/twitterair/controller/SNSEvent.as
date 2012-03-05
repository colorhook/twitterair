package com.colorhook.twitterair.controller
{
	import flash.events.Event;

	public class SNSEvent extends Event
	{
		
		public var text:String="";
		
		public static const RENREN:String="SNSEvent_renren";
		
		public function SNSEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}