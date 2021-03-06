////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.html.beads
{
	import flash.display.DisplayObject;
	
    import org.apache.flex.core.BeadViewBase;
	import org.apache.flex.core.IBeadModel;
	import org.apache.flex.core.IBeadView;
	import org.apache.flex.core.IRangeModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.events.Event;
	import org.apache.flex.events.IEventDispatcher;
	import org.apache.flex.html.Button;
	import org.apache.flex.html.beads.controllers.ButtonAutoRepeatController;
	
	/**
	 *  The SpinnerView class creates the visual elements of the org.apache.flex.html.Spinner 
	 *  component.
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 */
	public class SpinnerView extends BeadViewBase implements ISpinnerView, IBeadView
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function SpinnerView()
		{
		}
		
		private var rangeModel:IRangeModel;
		
		/**
		 *  @copy org.apache.flex.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		override public function set strand(value:IStrand):void
		{
			super.strand = value;
            
			_increment = new Button();
			Button(_increment).addBead(new UpArrowButtonView());
			Button(_increment).addBead(new ButtonAutoRepeatController());
			_decrement = new Button();
			Button(_decrement).addBead(new DownArrowButtonView());
			Button(_decrement).addBead(new ButtonAutoRepeatController());
						
			Button(_increment).x = 0;
			Button(_increment).y = 0;
			Button(_decrement).x = 0;
			Button(_decrement).y = Button(_increment).height;
			
			UIBase(_strand).addChild(_decrement);
			UIBase(_strand).addChild(_increment);
			rangeModel = _strand.getBeadByType(IBeadModel) as IRangeModel;
			
			IEventDispatcher(value).addEventListener("widthChanged",sizeChangeHandler);
			IEventDispatcher(value).addEventListener("heightChanged",sizeChangeHandler);
		}
		
		private var _decrement:DisplayObject;
		private var _increment:DisplayObject;
		
		/**
		 *  The component for decrementing the org.apache.flex.html.Spinner value.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function get decrement():DisplayObject
		{
			return _decrement;
		}
		
		/**
		 *  The component for incrementing the org.apache.flex.html.Spinner value.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function get increment():DisplayObject
		{
			return _increment;
		}
		
		/**
		 * @private
		 */
		private function sizeChangeHandler( event:Event ) : void
		{
            var w:Number = UIBase(_strand).width;
            var h:Number =  UIBase(_strand).height / 2;
			_increment.width = w;
			_increment.height = h;
			_increment.y      = 0;
			_decrement.width = w;
			_decrement.height = h;
			_decrement.y      = h;
		}
	}
}
