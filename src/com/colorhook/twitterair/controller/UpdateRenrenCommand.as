/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller
{
	import com.colorhook.twitterair.model.UserPrefModel;
	import com.colorhook.twitterair.services.ILogService;
	import com.colorhook.twitterair.view.Toast;
	import com.hurlant.crypto.tls.TLSConfig;
	import com.hurlant.crypto.tls.TLSEngine;
	import com.hurlant.crypto.tls.TLSEvent;
	import com.hurlant.crypto.tls.TLSSocket;
	import com.seesmic.as3.xmpp.XMPP;
	import com.seesmic.as3.xmpp.XMPPEvent;
	
	import org.robotlegs.mvcs.Command;

	
	public class UpdateRenrenCommand extends Command
	{
		
		private var xmpp:XMPP;
		
		[Inject]public var snsEvent:SNSEvent;
		[Inject]public var logService:ILogService;
		[Inject]public var userPref:UserPrefModel;
		
		override public function execute():void
		{
			logService.info("UpdateRenrenCommand execute");

			var renrenID:String=userPref.userPreferences.renrenID;
			var renrenPassword:String=userPref.userPreferences.renrenPassword;
			
			if(renrenID==""||renrenPassword==""){
				return;
			}
	
			xmpp=new XMPP(renrenID+"@talk.xiaonei.com",renrenPassword,"talk.xiaonei.com");
		    xmpp.addEventListener(XMPPEvent.SESSION, handleSession);
		    xmpp.setupTLS(TLSEvent,TLSConfig,TLSEngine,TLSSocket);
		    xmpp.connect();
		}

		private function handleSession(event:XMPPEvent):void {
			logService.info("UpdateRenrenCommand handleSession");
		    xmpp.removeEventListener(XMPPEvent.SESSION, handleSession);
		    var status:String=snsEvent.text;
		    xmpp.addEventListener(XMPPEvent.PRESENCE, onPrsence,false,0,true);
		    xmpp.sendPresence(status);
		}
		
		private function onPrsence(event:XMPPEvent):void{
			logService.info("UpdateRenrenCommand onPrsence");
			xmpp.removeEventListener(XMPPEvent.PRESENCE,onPrsence);
			xmpp.disconnect();
			Toast.makeText("Your status on renren.com updated");
		}
	}
}