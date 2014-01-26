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
	import org.apache.flex.core.IBeadModel;
	import org.apache.flex.core.IDataGridModel;
	import org.apache.flex.core.ISelectionModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.UIBase;
	import org.apache.flex.core.ValuesManager;
	import org.apache.flex.events.Event;
	import org.apache.flex.events.IEventDispatcher;
	import org.apache.flex.html.staticControls.Button;
	import org.apache.flex.html.staticControls.ButtonBar;
	import org.apache.flex.html.staticControls.Container;
	import org.apache.flex.html.staticControls.List;
	import org.apache.flex.html.staticControls.beads.layouts.ButtonBarLayout;
	import org.apache.flex.html.staticControls.beads.layouts.NonVirtualHorizontalLayout;
	import org.apache.flex.html.staticControls.beads.models.ArraySelectionModel;
	import org.apache.flex.html.staticControls.supportClasses.DataGridColumn;
	
	public class DataGridView implements IDataGridView
	{
		public function DataGridView()
		{
		}
		
		//private var background:Shape;
		private var buttonBar:ButtonBar;
		private var buttonBarModel:ArraySelectionModel;
		private var columnContainer:Container;
		private var columns:Array;
		
		public function getColumnLists():Array
		{
			return columns;
		}
		
		private var _strand:IStrand;
		public function set strand(value:IStrand):void
		{
			_strand = value;
			
			var sharedModel:IDataGridModel = _strand.getBeadByType(IBeadModel) as IDataGridModel;
			
			//background = new Shape();
			//DisplayObjectContainer(_strand).addChild(background);
			
			// create an array of columnLabels for use by the ButtonBar/DataGrid header.
			var columnLabels:Array = new Array();
			var buttonWidths:Array = new Array();
			for(var i:int=0; i < sharedModel.columns.length; i++) {
				columnLabels.push(sharedModel.columns[i].label);
				buttonWidths.push(sharedModel.columns[i].columnWidth);
			}
			var bblayout:ButtonBarLayout = new ButtonBarLayout();
			bblayout.buttonWidths = buttonWidths;
			
			buttonBarModel = new ArraySelectionModel();
			buttonBarModel.dataProvider = columnLabels;
			
			buttonBar = new ButtonBar();
			buttonBar.addBead(buttonBarModel);
			buttonBar.addBead(bblayout);
			UIBase(_strand).addElement(buttonBar);
			
			columnContainer = new Container();
			var layout:NonVirtualHorizontalLayout = new NonVirtualHorizontalLayout();
			columnContainer.addBead(layout);
			UIBase(_strand).addElement(columnContainer);
			
			columns = new Array();
			for(i=0; i < sharedModel.columns.length; i++) {
				var listModel:ISelectionModel = new ArraySelectionModel();
				listModel.dataProvider = sharedModel.dataProvider;
				
				var dataGridColumn:DataGridColumn = sharedModel.columns[i] as DataGridColumn;
				
				var list:List = new List();
				list.addBead(listModel);
				list.itemRenderer = dataGridColumn.itemRenderer;
				list.labelField = dataGridColumn.dataField;
				
				var colWidth:Number = dataGridColumn.columnWidth;
				if (!isNaN(colWidth)) list.width = colWidth;

				columnContainer.addElement(list);
				columns.push(list);
				list.addEventListener('change',columnListChangeHandler);
				list.addEventListener('rollover',columnListRollOverHandler);
			}
			
			IEventDispatcher(_strand).addEventListener("widthChanged",handleSizeChange);
			IEventDispatcher(_strand).addEventListener("heightChanged",handleSizeChange);
			
			handleSizeChange(null); // initial sizing
		}
		
		private function handleSizeChange(event:Event):void
		{
			var sw:Number = UIBase(_strand).width;
			var sh:Number = UIBase(_strand).height;
			
			var backgroundColor:Number = 0xDDDDDD;
			var value:Object = ValuesManager.valuesImpl.getValue(_strand, "background-color");
			if (value != null) backgroundColor = Number(value);
			
			//background.graphics.clear();
			//background.graphics.beginFill(backgroundColor);
			//background.graphics.drawRect(0,0,sw,sh);
			//background.graphics.endFill();
			
			buttonBar.x = 0;
			buttonBar.y = 0;
			buttonBar.width = sw;
			buttonBar.height = 25;
			
			columnContainer.x = 0;
			columnContainer.y = 30;
			columnContainer.width = sw;
			columnContainer.height = sh - 25;
			
			for(var i:int=0; i < columns.length; i++) {
				var column:List = columns[i];
			
				var cw:Number = sw/(columns.length);
				column.y = 0;
				column.height = columnContainer.height; // this will actually be Nitem*rowHeight
			}
			
			IEventDispatcher(_strand).dispatchEvent(new Event("layoutComplete"));
		}
		
		private function columnListChangeHandler(event:Event):void
		{
			var sharedModel:IDataGridModel = _strand.getBeadByType(IBeadModel) as IDataGridModel;
			var list:List = event.target as List;
			sharedModel.selectedIndex = list.selectedIndex;
			
			for(var i:int=0; i < columns.length; i++) {
				if (list != columns[i]) {
					columns[i].selectedIndex = list.selectedIndex;
				}
			}
			
			IEventDispatcher(_strand).dispatchEvent(new Event('change'));
		}
		
		private function columnListRollOverHandler(event:Event):void
		{
			var list:List = event.target as List;
			for(var i:int=0; i < columns.length; i++) {
				if (list != columns[i]) {
					columns[i].rollOverIndex = list.rollOverIndex;
				}
			}
			
			IEventDispatcher(_strand).dispatchEvent(new Event('rollOver'));
		}
	}
}