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
	 * PNG フォーマットに定義されているフィルタアルゴリズムを選択するためのフラグです.
	 * フィルタリングは可逆な処理で、 deflate 圧縮の効果を高めることができます。
	 * フィルタリングはバイト配列を冗長化する仕組みで、バイト列の長さを変える仕組みではありません。
	 * OR 論理演算子(|)を使用して、複数のフィルタタイプ値を選択肢として指定することができます。
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0
	 * 
	 * @author dsk
	 * @since 2010/01/07
	 */
	public class PNGFilterType
	{
		
		//--------------------------------------
		// CLASS CONSTANTS
		//--------------------------------------
		
		/**
		 * フィルタリングを行わず、バイト配列をそのまま転送します.
		 */
		public static const NONE:int  = 0x08;
		
		/**
		 * 左のピクセルの対応バイトとの差分を転送します.
		 */
		public static const SUB:int   = 0x10;
		
		/**
		 * 上のピクセルの対応バイトとの差分を転送します.
		 */
		public static const UP:int    = 0x20;
		
		/**
		 * 左と上のピクセルの対応バイトの平均値との差分を転送します.
		 */
		public static const AVG:int   = 0x40;
		
		/**
		 * 左・上・左上のピクセルの対応バイトから予測値を計算し、差分を転送します.
		 */
		public static const PAETH:int = 0x80;
		
		/**
		 * PNG フォーマットのフィルタアルゴリズムに定義されているすべてのフィルタを選択肢とします.
		 */
		public static const ALL:int   = NONE | SUB | UP | AVG | PAETH;
		
		
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









