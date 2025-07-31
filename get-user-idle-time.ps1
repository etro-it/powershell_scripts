# Add .NET type to access user32.dll for idle time
Add-Type @"
using System;
using System.Runtime.InteropServices;

public static class IdleTimeHelper
{
    [StructLayout(LayoutKind.Sequential)]
    public struct LASTINPUTINFO
    {
        public uint cbSize;
        public uint dwTime;
    }

    [DllImport("user32.dll")]
    public static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);

    public static uint GetIdleTime()
    {
        LASTINPUTINFO lii = new LASTINPUTINFO();
        lii.cbSize = (uint)Marshal.SizeOf(lii);
        GetLastInputInfo(ref lii);
        return ((uint)Environment.TickCount - lii.dwTime) / 1000;
    }
}
"@

# Call the method and print idle time
$idleTime = [IdleTimeHelper]::GetIdleTime()

# Get currently logged-in user
$username = [System.Environment]::UserName

# Output
Write-Output "Logged in user: $username"
Write-Output "User idle time: $idleTime seconds"
