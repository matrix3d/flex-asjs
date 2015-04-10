package controller
{
	import models.ProductsModel;
	import models.Stock;
	
	import org.apache.flex.core.IBeadController;
	import org.apache.flex.core.IBeadModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.events.Event;
	import org.apache.flex.events.EventDispatcher;
	import org.apache.flex.utils.Timer;
	
	import views.StockView;
	import views.WatchListView;
	
	public class WatchListController extends EventDispatcher implements IBeadController
	{
		public function WatchListController()
		{
			super();
			
			timer = new Timer(updateInterval, 0);
			timer.addEventListener("timer", timerHandler);
		}
		
		public var updateInterval:Number = 5000;
		
		protected var timer:Timer;
		
		private var index:Number = 0;
		private var selectedStock:Stock;
		private var _strand:IStrand;
		
		public function set strand(value:IStrand):void
		{
			_strand = value;
			
			var view:WatchListView = value as WatchListView;
			view.addEventListener("addSymbol", handleAddSymbol);
			view.addEventListener("stockSelected", handleGridSelection);
		}
		
		private var _model:IBeadModel;
		public function set model(value:IBeadModel):void
		{
			_model = value;
		}
		public function get model():IBeadModel
		{
			return _model;
		}
		
		private function handleAddSymbol(event:Event):void
		{
			var view:WatchListView = _strand as WatchListView;
			var symbol:String = view.symbolName.text.toUpperCase();
			
			view.symbolName.text = "";
			
			(model as ProductsModel).addStock(symbol);
			
			subscribe();
		}
		
		private function handleGridSelection(event:Event):void
		{
			var view:WatchListView = _strand as WatchListView;
			selectedStock = (model as ProductsModel).watchList[view.selectedStockIndex] as Stock;
			trace("Selected stock "+selectedStock.symbol);
			
			var stockView:StockView = view.showStockDetails(selectedStock);
			stockView.addEventListener("removeFromList", handleRemoveFromList);
		}
		
		public function handleRemoveFromList(event:Event):void
		{
			(model as ProductsModel).removeStock(selectedStock);
			
			var view:WatchListView = _strand as WatchListView;
			view.popView();
		}
		
		public function subscribe():void
		{
			if (!timer.running) 
			{
				timer.start();
			}
		}
		
		public function unsubscribe():void
		{
			if (timer.running) 
			{
				timer.stop();
			}
		}
		
		/**
		 * Each time the handler goes off a different stock in the list
		 * is updated. This keeps the app from sending too many requests
		 * all at once.
		 */
		protected function timerHandler(event:*):void
		{
			var stockList:Array = (model as ProductsModel).watchList;
			
			if (stockList.length == 0) return;
			
			if (index >= stockList.length) index = 0;
			
			(model as ProductsModel).updateStockData(stockList[index] as Stock);
			index++;
			
			var newEvent:Event = new Event("update");
			model.dispatchEvent(newEvent);
		}
	}
}