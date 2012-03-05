/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller{
	
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;
    
    import mx.controls.Image;
	
	/**
	 * ProfileImagePool is a singleton to load and cache user profile image
	 */ 
    public class ProfileImagePool{
    	
        protected var bitmapDict:Dictionary;
        protected var imageInLoading:Dictionary;
        protected var loaderDict:Dictionary;
        protected var waitingImage:Dictionary;
        
        protected static var _instance:ProfileImagePool;
        
        public var defaultErrorImageURL:String="assets/images/errorHead.png";
        
        public static function getInstance():ProfileImagePool{
            if(_instance==null) _instance=new ProfileImagePool();
            return _instance;
        }
        
        public function ProfileImagePool(){
            if(_instance){
            	throw new Error("ProfileImagePool is a Singleton.");
            }
            bitmapDict=new Dictionary(true);
            loaderDict=new Dictionary(true);
            waitingImage=new Dictionary(true);
            imageInLoading=new Dictionary(true);
        }
        
        public function registerImage(url:String,image:Image):void{
        	if(this.get(url)==null){
        		this.add(url);
        		var array:Array=waitingImage[url];
        		if(array.indexOf(image)==-1){
        			array.push(image);
        		}
        	}
        }
        /**
         * add a image to the pool by name
         * @param image <String>
         */ 
        public function add(url:String):void{
        	if(url==null||bitmapDict[url]){
        		return;
        	}
        	if(imageInLoading[url]){
        		return;
        	}
        	imageInLoading[url]=true;
        	waitingImage[url]=[];
            var loader:Loader=new Loader;
            addLoaderListeners(loader.contentLoaderInfo);
            loaderDict[loader.contentLoaderInfo]=url;
            loader.load(new URLRequest(url));
        }
        /**
         * get a image from the pool by name
         * @param image <String>
         * @return BitmapData
         */
        public function get(url:String):BitmapData{
        	return bitmapDict[url] as BitmapData;
        }
        //////////////////////////////////////////////
        ///////////PRIVATE METHODS
        //////////////////////////////////////////////
        private function onIOError(event:IOErrorEvent):void{
        	var loaderInfo:LoaderInfo=event.target as LoaderInfo;
        	removeLoaderListeners(loaderInfo);
        	var url:String=loaderDict[loaderInfo];
        	imageInLoading[url]=false;
        	
        	var waitingImages:Array=this.waitingImage[url];
        	if(this.defaultErrorImageURL){
        		add(this.defaultErrorImageURL);
	            for(var i:int=0;i<waitingImages.length;i++){
	            	waitingImages[i].source=this.defaultErrorImageURL;
	            	this.waitingImage[url]=[];
	            }
        	}
        }
        private function onLoaderComplete(event:Event):void{           
			var loaderInfo:LoaderInfo=event.target as LoaderInfo;
            removeLoaderListeners(loaderInfo);
            var url:String=loaderDict[loaderInfo];
            var loader:Loader=loaderInfo.loader;
            var bitmapData:BitmapData=new BitmapData(loader.content.width,loader.content.height);
            bitmapData.draw(loader.content);
            bitmapDict[url]=bitmapData;
            imageInLoading[url]=false;
            var waitingImages:Array=this.waitingImage[url];
            for(var i:int=0;i<waitingImages.length;i++){
            	waitingImages[i].source=new Bitmap(bitmapData);
            	this.waitingImage[url]=[];
            }
        }
        private function addLoaderListeners(loaderInfo:LoaderInfo):void{
        	loaderInfo.addEventListener(Event.INIT,onLoaderComplete);
        	loaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
        }
        private function removeLoaderListeners(loaderInfo:LoaderInfo):void{
        	loaderInfo.removeEventListener(Event.INIT,onLoaderComplete);
        	loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
        }

    }
}
