proc msg_dc {nick uhost hand rest} {
	global botnick notc ; set rest [lindex $rest 0]
	if {$rest == ""} {putquick "NOTICE $nick :$notc » Command: /msg $botnick dc <text>" ; return 0}
	putquick "PRIVMSG $nick :$notc » zip: [zip "$rest"]"
	putquick "PRIVMSG $nick :$notc » dezip: [dezip "$rest"]"
	putquick "PRIVMSG $nick :$notc » dcp: [dcp "$rest"]"
	putquick "PRIVMSG $nick :$notc » dezip+dcp: [dezip [dcp "$rest"]]"
	putquick "PRIVMSG $nick :$notc » decrypt: [decrypt 64 "$rest"]"
	putquick "PRIVMSG $nick :$notc » encrypt: [encrypt 64 "$rest"]"
	putquick "PRIVMSG $nick :$notc » unsix: [unsix "$rest"]"
	return 0
}
bind msg m dc msg_dc

proc unsix {txt} {
set retval $txt
regsub ~ $retval "" retval
return $retval
}
proc dezip {txt} {
return [decrypt 64 [unsix $txt]]
}
proc dcp {txt} {
return [decrypt 64 $txt]
}
proc zip {txt} {
return [encrypt 64 [unsix $txt]]
}
proc msg_encrypt {nick uhost hand rest} {
global own notc
if {$nick != $own || $rest == ""} { return 0 }
puthlp "NOTICE $nick :$notc [zip $rest]"
}
proc msg_decrypt {nick uhost hand rest} {
global own notc
if {$nick != $own || $rest == ""} { return 0 }
puthlp "NOTICE $nick :$notc [dezip $rest]"
}


###################
### HELP comand ###
###################

bind msg m help msg_help
proc msg_help {nick uhost hand rest} {
global version notb notc notd vern
if {[istimer "HELP STOPED"]} {
putsrv "NOTICE $nick :$notc Help on progress, try again later..!"
return 0
}
timer 5 { putlog "HELP STOPED" }
puthlp "PRIVMSG $nick :$notd BoT Command LIsT."
puthlp "PRIVMSG $nick :RuNNINg WiTH EggDrop v[lindex $version 0] PoWERED BY [lgrnd] $vern"
puthlp "PRIVMSG $nick :MSG/PV COMMAND..!"
puthlp "PRIVMSG $nick :auth <password>          authenticate user"
puthlp "PRIVMSG $nick :deauth <password>        deauthenticate user"
puthlp "PRIVMSG $nick :pass <password>          set password"
puthlp "PRIVMSG $nick :passwd <oldpass> <newpass>  change user password"
puthlp "PRIVMSG $nick :userlist                 userlist"
puthlp "PRIVMSG $nick :op <#> <nick>            op someone"
puthlp "PRIVMSG $nick :deop <#> <nick>          deop someone"
puthlp "PRIVMSG $nick :voice <#> <nick>         voice someone"
puthlp "PRIVMSG $nick :devoice <#> <nick>       devoice someone"
puthlp "PRIVMSG $nick :kick <#> <nick|host> <reason>  kick someone"
puthlp "PRIVMSG $nick :kickban <#> <nick|host> <reason>  kickban someone"
puthlp "PRIVMSG $nick :identify <nick> <passwd> identify to nickserv someone access"
puthlp "PRIVMSG $nick :join <#>                 joining #channel temporary"
puthlp "PRIVMSG $nick :part <#>                 part #channels"
