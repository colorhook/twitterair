/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.style{
	import flash.display.Graphics;
	import mx.skins.Border;
	import mx.utils.GraphicsUtil;
	
	public class SolidBorder extends Border{
		
		public function SolidBorder(){
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, 
													  unscaledHeight:Number):void{
			var g:Graphics=graphics;
			g.clear();
			
			var radius:Number=this.getStyle("cornerRadius") as Number;
			if(isNaN(radius)) radius=0;
			//fill style
			var bgColor:uint=this.getStyle("backgroundColor") as uint;
			if(isNaN(bgColor)) bgColor=0x333333;
			var bgAlpha:Number=this.getStyle("backgroundAlpha") as Number;
			if(isNaN(bgAlpha)) bgAlpha=1;
			g.beginFill(bgColor,bgAlpha);
			GraphicsUtil.drawRoundRectComplex(g,0,0,
											unscaledWidth,
											unscaledHeight,
											radius,radius,radius,radius);				
		}
		
	}
}