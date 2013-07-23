package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author umhr
	 */
	[SWF(width = 465, height = 465, backgroundColor = 0x000000, frameRate = 30)]
	public class Main extends Sprite 
	{
		private var _textField:TextField = new TextField();
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			_textField.mouseEnabled = false;
			_textField.width = stage.stageWidth;
			_textField.height = 20;
			_textField.textColor = 0xFF0000;
			_textField.text = "画面をクリックするとエンコードを開始します。";
			_textField.y = stage.stageHeight - 20;
			addChild(_textField);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDown);
		}
		
		private function stage_mouseDown(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, stage_mouseDown);
			_textField.text = "エンコード中です。";
			
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUp);
		}
		
		private function stage_mouseUp(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUp);
			
			addChildAt(new Canvas(), 0);
			
			_textField.text = "画面をクリックすると画像ファイルを保存します。";
			
		}
		
		
	}
	
}