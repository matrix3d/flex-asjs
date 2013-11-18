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
package org.apache.flex.html.staticControls.beads
{
	import org.apache.flex.core.IMeasurementBead;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.ValuesManager;
	import org.apache.flex.html.staticControls.TitleBar;
	
	public class TitleBarMeasurementBead implements IMeasurementBead
	{
		public function TitleBarMeasurementBead()
		{
		}
		
		public function get measuredWidth():Number
		{
			var mwidth:Number = 0;
			var titleBar:TitleBar = _strand as TitleBar;
			var labelMeasure:IMeasurementBead = titleBar.titleLabel.measurementBead;
			mwidth = labelMeasure.measuredWidth;
			if( titleBar.showCloseButton ) {
				var buttonMeasure:IMeasurementBead = titleBar.closeButton.measurementBead;
				mwidth += buttonMeasure.measuredWidth;
			}
			return mwidth;
		}
		
		public function get measuredHeight():Number
		{
			var mheight:Number = 0;
			var titleBar:TitleBar = _strand as TitleBar;
			var labelMeasure:IMeasurementBead = titleBar.titleLabel.measurementBead;
			mheight = labelMeasure.measuredHeight;
			if( titleBar.showCloseButton ) {
				var buttonMeasure:IMeasurementBead = titleBar.closeButton.measurementBead;
				mheight = Math.max(mheight,buttonMeasure.measuredHeight);
			}
			return mheight;
		}
		
		private var _strand:IStrand;
		public function set strand(value:IStrand):void
		{
			_strand = value;
		}
	}
}