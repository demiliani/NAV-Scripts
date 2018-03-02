$Assem = (
    "EID.NavTools, Version=2.0.0.0, Culture=neutral, PublicKeyToken=73e9bde131e8729c"
    ) 

$code = @" 
using System;


namespace EID 
{    
    public class MyNAVSuperClass    
    {        
        public static void MyStaticMethod()            
        {            
            Console.WriteLine("Working with NAV");        
        }
        
        public void MyMethod()        
        {            
            Console.WriteLine("Working with NAV 2");        
        }    
    } 
} 
"@

Add-Type -ReferencedAssemblies $Assem -TypeDefinition $Source -Language CSharp 


# Check the type has not been previously added within the session, otherwise an exception is raised 
if (-not ([System.Management.Automation.PSTypeName]'EID.MyNAVSuperClass').Type) 
{    
    Add-Type -TypeDefinition $code -Language CSharp; 
}

[EID.MyNAVSuperClass]::MyStaticMethod();

$instance = New-Object EID.MyNAVSuperClass; 
$instance.MyMethod(); 