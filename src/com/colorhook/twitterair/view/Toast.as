/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.view
{
	import caurina.transitions.Tweener;
	
	import flash.display.BlendMode;
	import flash.display.Sprite;
	
	import mx.containers.Panel;
	import mx.controls.Label;
	import mx.core.Application;
	import mx.core.ScrollPolicy;
	import mx.core.UITextField;
	import mx.managers.ISystemManager;
	import mx.managers.PopUpManager;

	public class Toast extends Panel
	{
		protected var content:UITextField;
		private var _text:String;
		
		override protected function createChildren():void{
			super.createChildren();
			content=new UITextField;
			content.wordWrap=true;
			this.blendMode=BlendMode.LAYER;
			this.verticalScrollPolicy=this.horizontalScrollPolicy=ScrollPolicy.OFF;
			this.mouseChildren=false;
			addChild(content);
		}
		
		public function destroy():void{
			if(this.stage){
				PopUpManager.removePopUp(this);	
			}
		}
		
		public function set text(value:String):void{
			this._text=value;
			this.invalidateProperties();
			this.invalidateSize();
			this.invalidateDisplayList();
		}
		
		override protected function commitProperties():void{
			super.commitProperties();
			content.text=this._text;
		}
		override protected function measure():void{
			this.measuredWidth=200;
			this.measuredHeight=120;
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			content.x=10;
			content.width=180;
			content.height=80;
			content.y=20;
		}
		
		
		public static var SHOW_DURATION:Number=0.5;
		public static var HOLD_DURATION:Number=2;
		public static var HIDE_DURATION:Number=0.5;
		
		public static function makeText(text:String = "", 
								title:String="Info",
                                parent:Sprite = null):Toast{
			if (!parent)
	        {
	            var sm:ISystemManager = ISystemManager(Application.application.systemManager);
	            if (sm.useSWFBridge())
	                parent = Sprite(sm.getSandboxRoot());
	            else
	                parent = Sprite(Application.application);
	        }
			
			var toast:Toast=new Toast();
			toast.text=text;
			toast.title=title;
			toast.y=-200;
			PopUpManager.addPopUp(toast,parent);
			toast.x=(toast.stage.stageWidth-toast.width)*0.5;
			
			var py1:Number=toast.y=toast.stage.stageHeight+20;
			var py2:Number=toast.stage.stageHeight-toast.height-50;
			var holdFun:Function=function():void{
				Tweener.addTween(toast,{time:HOLD_DURATION,onComplete:hideFun});
			}
			var hideFun:Function=function():void{
				Tweener.addTween(toast,{alpha:0,time:HIDE_DURATION,onComplete:toast.destroy});
			}
			Tweener.addTween(toast,{y:py2,time:SHOW_DURATION,onComplete:holdFun});
			return toast;
		}
		
	}
}