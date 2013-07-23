package  
{
	
	import by.blooddy.crypto.Base64;
	import by.blooddy.crypto.image.JPEGEncoder;
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	import com.hurlant.util.Base64;
	import com.sociodox.utils.Base64;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	import jp.ferv.fileformats.png.PNG;
	import jp.mztm.umhr.logging.Log;
	import org.bytearray.JPEGEncoder;
	import ru.inspirit.encoders.png.PNGEncoder;
	/**
	 * ...
	 * @author umhr
	 */
	public class Canvas extends Sprite 
	{
		private var _bitmapData:BitmapData = new BitmapData(465, 465);
		private var _byteArray:ByteArray;
		private var _zipper:Zipper = new Zipper();
		
		public function Canvas() 
		{
			init();
		}
		private function init():void 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			setImage();
			
			addChild(new Log(0, 0, 465, 465, 0x000000));
			Log.clear();
			
			base64Encode();
			Log.trace("============================================");
			JPGEncode();
			Log.trace("============================================");
			PNGEncode();
			
		}
		
		private function base64Encode():void {
			
			Log.trace("W:465 x H:465の画像を Base64 にエンコードする時間(msec)");
			
			// as3crypto - Cryptography library for ActionScript 3, including partial TLS 1.0 support - Google Project Hosting
			// https://code.google.com/p/as3crypto/
			Log.timeStart();
			com.hurlant.util.Base64.encodeByteArray(_byteArray);
			Log.traceTime("com.hurlant.util.Base64");
			Log.timeReset();
			
			// BlooDHounD's workspace - blooddy_crypto.swc library
			// http://www.blooddy.by/en/crypto/
			Log.timeStart();
			by.blooddy.crypto.Base64.encode(_byteArray);
			Log.traceTime("by.blooddy.crypto.Base64");
			Log.timeReset();
			
			// TheMiner tutorials
			// http://www.sociodox.com/base64.html
			Log.timeStart();
			com.sociodox.utils.Base64.encode(_byteArray);
			Log.traceTime("com.sociodox.utils.Base64");
			Log.timeReset();
			
		}
		
		private function JPGEncode():void 
		{
			var quality:int = 90;
			
			Log.trace("W:465 x H:465の画像を JPEG Quality 90 にエンコードする時間(msec)");
			
			// mikechambers/as3corelib · GitHub
			// https://github.com/mikechambers/as3corelib
			Log.timeStart();
			_zipper.add(new com.adobe.images.JPGEncoder(quality).encode(_bitmapData), "as3corelib.jpg");
			Log.traceTime("com.adobe.images.JPGEncoder");
			Log.timeReset();
			
			// BlooDHounD's workspace - blooddy_crypto.swc library
			// http://www.blooddy.by/en/crypto/
			Log.timeStart();
			_zipper.add(by.blooddy.crypto.image.JPEGEncoder.encode(_bitmapData, quality), "blooddy_crypto.jpg");
			Log.traceTime("by.blooddy.crypto.image.JPEGEncoder");
			Log.timeReset();
			
			// Faster JPEG Encoding with Flash Player 10 - ByteArray.org
			// http://www.bytearray.org/?p=775
			Log.timeStart();
			_zipper.add(new org.bytearray.JPEGEncoder(quality).encode(_bitmapData), "ByteArray.jpg");
			Log.traceTime("org.bytearray.JPEGEncoder");
			Log.timeReset();
			
		}
		
		private function PNGEncode():void 
		{
			Log.trace("W:465 x H:465の画像を PNG にエンコードする時間(msec)");
			
			// mikechambers/as3corelib · GitHub
			// https://github.com/mikechambers/as3corelib
			Log.timeStart();
			_zipper.add(com.adobe.images.PNGEncoder.encode(_bitmapData), "as3corelib.png");
			Log.traceTime("com.adobe.images.PNGEncoder");
			Log.timeReset();
			
			// BlooDHounD's workspace - blooddy_crypto.swc library
			// http://www.blooddy.by/en/crypto/
			Log.timeStart();
			_zipper.add(by.blooddy.crypto.image.PNGEncoder.encode(_bitmapData), "blooddy_crypto.png");
			Log.traceTime("by.blooddy.crypto.image.PNGEncoder");
			Log.timeReset();
			
			// PNGEncoder - in-spirit - Extended PNG Encoder for Adobe Flash. - Eugene Zatepyakin open source stuff - Google Project Hosting
			// https://code.google.com/p/in-spirit/wiki/PNGEncoder
			Log.timeStart();
			_zipper.add(ru.inspirit.encoders.png.PNGEncoder.encode(_bitmapData), "inspirit.png");
			Log.traceTime("ru.inspirit.encoders.png.PNGEncoder");
			Log.timeReset();
			
			// dsk/PNG - Spark project
			// http://www.libspark.org/wiki/dsk/PNG
			Log.timeStart();
			var png_encodeSync:jp.ferv.fileformats.png.PNG = new jp.ferv.fileformats.png.PNG();
			png_encodeSync.encodeSync(_bitmapData);
			_zipper.add(png_encodeSync.data, "dsk_encodeSync.png");
			Log.traceTime("jp.ferv.fileformats.png.PNG(同期)");
			Log.timeReset();
			
			Log.timeStart();
			var png_encodeAsync:jp.ferv.fileformats.png.PNG = new jp.ferv.fileformats.png.PNG();
			png_encodeAsync.addEventListener(Event.COMPLETE, png_complete);
			png_encodeAsync.encodeAsync(_bitmapData);
			
		}
		
		private function png_complete(event:Event):void 
		{
			var png_encodeAsync:jp.ferv.fileformats.png.PNG = event.target as jp.ferv.fileformats.png.PNG;
			_zipper.add(png_encodeAsync.data, "dsk_encodeAsync.png");
			Log.traceTime("jp.ferv.fileformats.png.PNG(非同期)");
			Log.timeReset();
			
			_zipper.excute();
			
			addEventListener(MouseEvent.CLICK, click);
		}
		
		private function click(e:MouseEvent):void 
		{
			_zipper.onSave();
		}
		
		private function setImage():void 
		{
			var w:int = _bitmapData.width;
			var h:int = _bitmapData.height;
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(w, h);
			
			var shape:Shape = new Shape();
			for (var i:int = 0; i < 50; i++) 
			{
				shape.graphics.beginGradientFill(GradientType.LINEAR, [0xFFFFFF * Math.random(), 0xFFFFFF * Math.random()], [0.5, 0.5], [0, 255], matrix);
				shape.graphics.drawCircle(Math.random() * w, Math.random() * h, Math.random() * 200);
				shape.graphics.endFill();
			}
			
			_bitmapData.draw(shape);
			
			_byteArray = _bitmapData.getPixels(_bitmapData.rect);
			
			addChild(new Bitmap(_bitmapData));
		}
		
	}
	
}