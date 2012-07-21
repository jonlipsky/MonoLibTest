using System;
using System.Runtime.InteropServices;
using MonoMac.ObjCRuntime;

namespace MonoMacLoadLib
{
	class MainClass
	{
		[DllImport ("EchoTest", EntryPoint="EchoInteger")]
 		public static extern int EchoInteger (int arg);
 			
		static void Main (string[] args)
		{
			// The current directly is expected to be passed in as arg[0] for this sample to work
			string path = args[0] + "/bin/libEchoTest.dylib";
			System.Console.WriteLine("Dylib Path:{0}", path);	
					
			IntPtr libPtr = Dlfcn.dlopen(path, 1);
			System.Console.WriteLine("Pointer:{0}",libPtr);
			
			int echoResults = EchoInteger(11);
			System.Console.WriteLine("Echo Results:{0}",echoResults);
		}
	}
}	

