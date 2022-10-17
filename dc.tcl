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
