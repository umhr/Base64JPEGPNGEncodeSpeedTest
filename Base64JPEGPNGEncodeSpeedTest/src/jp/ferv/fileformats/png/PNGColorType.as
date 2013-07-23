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
	
	/**
	 * PNG フォーマットに定義されているカラータイプです.
	 * jp.ferv.fileformats.png パッケージでは、 BitmapData をグレースケールで定義するフローが無いことや、
	 * 色数を限定するフローが無いことから、 PNG フォーマットの特徴の一つである「可逆処理」を維持することができない可能性が
	 * 高いため、いくつかのカラータイプの使用を制限しています。
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0
	 * 
	 * @author dsk
	 * @since 2010/01/29
	 */
	public class PNGColorType
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		//private static const _MASK_PALETTE:int = 1;
		private static const _MASK_COLOR:int   = 2;
		private static const _MASK_ALPHA:int   = 4;
		
		/**
		 * それぞれのピクセルを、グレースケールとしてサンプルします.
		 */
		//public static const GRAY:int       = 0;
		
		/**
		 * それぞれのピクセルを、 R,G,B としてサンプルします.
		 */
		public static const RGB:int        = _MASK_COLOR;
		
		/**
		 * それぞれのピクセルを、パレットインデックスとしてサンプルします.
		 * このカラータイプ選択時には、 PNG フォーマットデータに PLTE チャンクが含まれます。
		 */
		//public static const PALETTE:int    = _MASK_COLOR | _MASK_PALETTE;
		
		/**
		 * それぞれのピクセルを、グレイスケールと不透明度としてサンプルします.
		 */
		//public static const GRAY_ALPHA:int = _MASK_ALPHA;
		
		/**
		 * それぞれのピクセルを R,G,B と不透明度としてサンプルします.
		 */
		public static const RGB_ALPHA:int  = _MASK_COLOR | _MASK_ALPHA;
		
		
		//--------------------------------------
		// PRIVATE VARIABLES
		//--------------------------------------
		
		
		//--------------------------------------
		// GETTER/SETTERS
		//--------------------------------------
		
		
		//--------------------------------------
		// PUBLIC METHODS
		//--------------------------------------
		
		
		//--------------------------------------
		// PRIVATE METHODS
		//--------------------------------------
		
		
	}
	
	
}









