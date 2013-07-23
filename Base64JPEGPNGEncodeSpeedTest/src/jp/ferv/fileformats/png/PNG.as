/**
 * The MIT License
 * 
 * Copyright (c) 2010 ferv.jp
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package jp.ferv.fileformats.png 
{
	import cmodule.png.CLibInit;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.utils.ByteArray;
	
	[Event(name = 'open', type = 'flash.events.Event')]
	[Event(name = 'complete', type = 'flash.events.Event')]
	[Event(name = 'progress', type = 'flash.events.ProgressEvent')]
	
	/**
	 * BitmapData から PNG フォーマットにエンコードされた ByteArray を作成するクラスです.
	 * 同期・非同期処理が可能です。
	 * libpng/zlib ライブラリの関数を呼び出す C のコードを Alchemy でコンパイルしています。
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0
	 * 
	 * @author dsk
	 * @since 2010/01/29
	 */
	public class PNG extends EventDispatcher 
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		private static const _ISO_8859_1:String = 'iso-8859-1';
		private static const _IHDR_TYPE:String  = 'IHDR';
		private static const _IDAT_TYPE:String  = 'IDAT';
		private static const _IEND_TYPE:String  = 'IEND';
		
		
		//--------------------------------------
		// PUBLIC VARIABLES
		//--------------------------------------
		
		private static var _lib:*;
		
		public var userData:Object;
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		private var _data:ByteArray;
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		/**
		 * PNG フォーマットにエンコードされたバイト配列です.
		 */
		public function get data():ByteArray { return _data; }
		public function set data(value:ByteArray):void 
		{
			_data = value;
		}
		
		
		//--------------------------------------
		// CONSTRUCTOR
		//--------------------------------------
		
		public function PNG(data:ByteArray = null) 
		{
			if (!_lib) 
			{
				_lib = (new CLibInit()).init();
			}
			
			_data = (data)? data: new ByteArray();
		}
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		/**
		 * 同期処理で、 BitmapData を PNG フォーマットにエンコードされたバイト配列にします.
		 * エンコード処理されたデータは data プロパティに書き込みます。
		 * 
		 * @param	source				エンコードする BitmapData です。
		 * @param	colorType			PNGColorType クラスに定義されてるカラータイプ値です。
		 * @param	filterType			PNGFilterType クラスに定義されている任意の 5 つのフィルタタイプ値 (NONE, SUB, UP, AVG, PAETH) の組み合わせである数値。
		 * OR 論理演算子(|)を使用して、複数のフィルタタイプ値を選択肢として指定することができます。
		 * @param	compressionLevel	zlib 圧縮レベルです。 0(高速無圧縮)～9(低速最大圧縮) で指定します。
		 */
		public function encodeSync(source:BitmapData, colorType:int = 6, filterType:int = 248, compressionLevel:int = 1):void 
		{
			_data.clear();
			_lib.encodeSync(_data, source.getPixels(source.rect), source.width, source.height, colorType, filterType, compressionLevel);
		}
		
		/**
		 * 非同期処理で、 BitmapData を PNG フォーマットにエンコードされたバイト配列にします.
		 * エンコード処理されたデータは data プロパティに書き込みます。
		 * 
		 * @param	source				エンコードする BitmapData です。
		 * @param	colorType			PNGColorType クラスに定義されてるカラータイプ値です。
		 * @param	filterType			PNGFilterType クラスに定義されている任意の 5 つのフィルタタイプ値 (NONE, SUB, UP, AVG, PAETH) の組み合わせである数値。
		 * OR 論理演算子(|)を使用して、複数のフィルタタイプ値を選択肢として指定することができます。
		 * @param	compressionLevel	zlib 圧縮レベルです。 0(高速無圧縮)～9(低速最大圧縮) で指定します。
		 * @param	rowSegments			分割処理の単位となる行数です。FPS を犠牲にして高速に処理したい場合は大きな値を指定します。
		 * 
		 * @eventType	flash.events.Event.OPEN				エンコード処理が開始したときに送出されます。
		 * @eventType	flash.events.ProgressEvent.PROGRESS	エンコード処理を実行中に rowSegments で指定された行数を処理する度に送出されます。
		 * @eventType	flash.events.Event.COMPLETE			エンコード処理が終了したときに送出されます。
		 */
		public function encodeAsync(source:BitmapData, colorType:int = 6, filterType:int = 248, compressionLevel:int = 1, rowSegments:int = 10):void 
		{
			_data.clear();
			_lib.encodeAsync(_handle, _open, _progress, _complete, rowSegments, _data, source.getPixels(source.rect), source.width, source.height, colorType, filterType, compressionLevel);
		}
		
		/**
		 * PNG フォーマットにエンコードされた ByteArray から主要なデータを XML に変換します.
		 * signature と IHDR チャンクの内容を XML に変換します。
		 * 各チャンクの length/type/CRC を chunk エレメントのアトリビュートに付加します。
		 * 
		 * @return						PNG の構成を表す XML です。
		 */
		public function toXML():XML 
		{
			var pngXML:XML = <png />;
			
			_data.position = 0;
			
			// Read signature.
			pngXML.appendChild(<signature>
				<signature0>{ _toHexString(_data.readUnsignedInt()) }</signature0>
				<signature1>{ _toHexString(_data.readUnsignedInt()) }</signature1>
			</signature>);
			
			// Read chunks.
			var length:uint, type:String, data:ByteArray, crc:uint, 
			    width:uint, height:uint, colorType:int;
			var imageData:ByteArray = new ByteArray();
			var chunksXML:XML = <chunks />;
			var chunkXML:XML;
			do 
			{
				chunkXML = <chunk />;
				
				length = _data.readUnsignedInt();
				type = _data.readMultiByte(4, _ISO_8859_1);
				if (length != 0) 
				{
					data = new ByteArray();
					_data.readBytes(data, 0, length);
					
					switch (type) 
					{
						case _IHDR_TYPE:
							data.position = 0;
							width = data.readUnsignedInt();
							chunkXML.appendChild(<width>{ width }</width>);
							height = data.readUnsignedInt();
							chunkXML.appendChild(<height>{ height }</height>);
							chunkXML.appendChild(<bitDepth>{ data.readByte() }</bitDepth>);
							colorType = data.readByte();
							chunkXML.appendChild(<colorType>{ colorType }</colorType>);
							chunkXML.appendChild(<compressionMethod>{ data.readByte() }</compressionMethod>);
							chunkXML.appendChild(<filterMethod>{ data.readByte() }</filterMethod>);
							chunkXML.appendChild(<interlaceMethod>{ data.readByte() }</interlaceMethod>);
							break;
						case _IDAT_TYPE:
							imageData.writeBytes(data);
							break;
					}
				}
				crc = _data.readUnsignedInt();
				
				chunkXML.@length = length;
				chunkXML.@type = type;
				chunkXML.@crc = _toHexString(crc);
				
				chunksXML.appendChild(chunkXML);
			}
			while (type != _IEND_TYPE)
			
			pngXML.appendChild(chunksXML);
			
			// Get filter types.
			var rowSize:uint;
			switch (colorType) 
			{
				case PNGColorType.RGB: rowSize = 3 * width; break;
				case PNGColorType.RGB_ALPHA: rowSize = 4 * width; break;
			}
			imageData.uncompress();
			var filters:Array = [false, false, false, false, false];
			var y:uint, filterType:int;
			for (y = 0; y < height; y ++) 
			{
				imageData.position = (1 + rowSize) * y;
				filters[imageData.readByte()] = true;
			}
			var filterTypes:Array = [];
			var i:int;
			for (i = 0; i < 5; i ++) 
			{
				if (filters[i]) 
				{
					filterTypes.push(i);
				}
			}
			pngXML.@filterTypes = filterTypes.join(',');
			
			return pngXML;
		}
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		private function _handle():void 
		{
			
		}
		
		private function _open():void 
		{
			dispatchEvent(new Event(Event.OPEN, false, false));
		}
		
		private function _progress(bytesLoaded:uint, bytesTotal:uint):void
		{
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, bytesLoaded, bytesTotal));
		}
		
		private function _complete():void
		{
			dispatchEvent(new Event(Event.COMPLETE, false, false));
		}
		
		static private function _toHexString(hex:uint, digit:int = 8):String
		{
			var str:String = hex.toString(16).toUpperCase();
			
			while (str.length < digit) 
			{
				str = '0' + str;
			}
			str = '0x' + str;
			
			return str;
		}
		
		
	}
	
	
}









