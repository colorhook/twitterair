/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.vo{
	
    public class UserPreferences{  
        public var username:String="";
        public var password:String="";
        public var autoLogin:Boolean=false;
        public var useProxy:Boolean=true;
        public var updateDuration:Number = 5;
        public var defaultTwitterAPIProxy:String = "http://colorhook.com/services/twitter";
        public var twitterAPIProxy:String="";
        public var AIRUpdateAddress:String="http://colorhook.com/portfolio/twitterair/update.xml";
        
        public var renrenID:String="";
        public var renrenPassword:String="";
    }
}

