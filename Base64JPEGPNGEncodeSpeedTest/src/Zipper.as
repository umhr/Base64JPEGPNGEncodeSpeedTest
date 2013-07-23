package  
{
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipOutput;
	/**
	 * ...
	 * @author umhr
	 */
	public class Zipper 
	{
		public var _zipOutput:ZipOutput = new ZipOutput();
		private var _byteArrayList:Vector.<ByteArray> = new Vector.<ByteArray>();
		private var _nameList:Vector.<String> = new Vector.<String>();
		public function Zipper() 
		{
			
		}
		
		public function add(byteArray:ByteArray, name:String):void {
			_byteArrayList.push(byteArray);
			_nameList.push(name);
		}
		
		public function excute():void {
			var n:int = _byteArrayList.length;
			for (var i:int = 0; i < n; i++) 
			{
				_zipOutput.putNextEntry(new ZipEntry(_nameList[i]));
				_zipOutput.write(_byteArrayList[i]);
				_zipOutput.closeEntry();
			}
			_zipOutput.finish();
		}
		
        public function onSave():void {
            //ファイルリファレンスで保存
            var fr:FileReference = new FileReference();
            fr.save(_zipOutput.byteArray, "files.zip"); // ダイアログを表示する
        }
		
	}

}