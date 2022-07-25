package
{
	import starling.filters.ColorMatrixFilter;
	
	public class ColorFilter extends ColorMatrixFilter
	{
		private var __currentMatrix:Vector.<Number> = new Vector.<Number>();
		private var __rr:Number = 1000;		
		private var __rg:Number = 0;		
		private var __rb:Number = 0;	
		
		private var __gr:Number = 0;		
		private var __gg:Number = 1000;		
		private var __gb:Number = 0;
		
		private var __br:Number = 0;		
		private var __bg:Number = 0;		
		private var __bb:Number = 1000;	
		
		private var __update:int = 1;
		
		
		public function ColorFilter(matrix:Vector.<Number>=null)
		{
			super(matrix);
			__currentMatrix.push(	1,		0,		0,		0,	0,
									0,		1,		0,		0,	0,
									0,		0,		1,		0,	0,
									0,		0,		0,		1,	0)
		}
		
		//BLUE

		public function get update():int
		{
			return __update;
		}

		public function set update(value:int):void
		{
			this.matrix = __currentMatrix;
		}

		public function get bb():Number
		{
			return __bb;
		}

		public function set bb(value:Number):void
		{
			__bb = value;
			__currentMatrix[12] = __bb/1000;
		}

		public function get bg():Number
		{
			return __bg;
		}

		public function set bg(value:Number):void
		{
			__bg = value;
			__currentMatrix[11] = __bg/1000;
		}

		public function get br():Number
		{
			return __br;
		}

		public function set br(value:Number):void
		{
			__br = value;
			__currentMatrix[10] = __br/1000;
		}

		//GREEN
		
		public function get gb():Number
		{
			return __gb;
		}

		public function set gb(value:Number):void
		{
			__gb = value;
			__currentMatrix[7] = __gb/1000;
		}
		
		public function get gg():Number
		{
			return __gg;
		}
		
		public function set gg(value:Number):void
		{
			__gg = value;
			__currentMatrix[6] = __gg/1000;
		}

		public function get gr():Number
		{
			return __gr;
		}

		public function set gr(value:Number):void
		{
			__gr = value;
			__currentMatrix[5] = __gr/1000;
		}

		//RED
		public function get rb():Number
		{
			return __rb;
		}

		public function set rb(value:Number):void
		{
			__rb = value;
			__currentMatrix[2] = __rb/1000;
		}
		
		public function get rg():Number
		{
			return __rg;
		}
		
		public function set rg(value:Number):void
		{
			__rg = value;
			__currentMatrix[1] = __rg/1000;
		}

		public function get rr():Number
		{
			return __rr;
		}

		public function set rr(value:Number):void
		{
			__rr = value;
			__currentMatrix[0] = __rr/1000;
		}	
	}
}