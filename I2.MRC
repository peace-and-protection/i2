menu query {
  whois:w $1
  extended:e $1
  dns:dns $1
  -
  ping:p $1
  -
  chat:d $1
  send:f $1
  -
  $iif($query($active),ignore)
  .$¤(2):³ $1 2
  .$¤(3):³ $1 3
  .$¤(4):³ $1 4
  .-
  .$active $+ !*@*:i $1
  .-
  .temp:i -u180 $1 2
}
menu status {
  connect:server $$?="server to connect to? (esc to cancel)" $?="port? (esc for default)"
  $iif($server,ports):ports
  -
  $µ(1):server $µ(1)
  $µ(2):server $µ(2)
  $µ(3):server $µ(3)
  $µ(4):server $µ(4)
  $µ(5):server $µ(5)
  $µ(6):server $µ(6)
  $µ(7):server $µ(7)
  $µ(8):server $µ(8)
  $µ(9):server $µ(9)
  -
  $iif($server,quit):quit $$?="quit reason? (esc to cancel)"
}
menu nicklist,@scan {
  $ø(opping)
  .op:œ $õ o $· !isop
  .deop:œ $õ -o $· isop
  .-
  .voice:œ $õ v $· isreg
  .devoice:œ $õ -v $· isvo
  -
  $ø(kick):k $· $õ
  $ø(tempban):k $· 2.30 $õ
  $ø(bankick)
  .$æ(3):k $· 3 $õ
  .$æ(13):k $· 13 $õ
  .$æ(1):k $· 1 $õ
  .-
  .$æ(4):k $· 4 $õ
  .$æ(14):k $· 14 $õ
  .$æ(2):k $· 2 $õ
  -
  whois:w $õ
  ping:p $õ
  -
  query:q $õ
  chat:d $õ
  send:f $õ
  -
  lists
  .add immune:Û ±i 1
  .rem immune:Û ±i 0
  .-
  .add exile:Û ±b 1 | if ($me isop $·) k $· 3 $õ exiled
  .rem exile:Û ±b 0
  .-
  .add protect:˜ x $õ protect ˜ $·
  .rem protect:˜ x $õ protect -r ˜ $·
  .-
  .auto op
  ..$æ(3):— 3
  ..$æ(13):— 13
  ..$æ(1):— 1
  ..-
  ..$æ(8):— 8
  ..$æ(18):— 18
  ..$æ(6):— 6
  .-
  .temp ignore:˜ x $õ i -u180 ˜ 2
  .perm ignore:˜ x $õ i ˜ 3
}
menu channel,menubar {
  config
  .protection:cfg p
  .away:cfg a
  .other:cfg
  .-
  .display:cfg d
  .ctcps:cfg c
  .nicklist:cfg n
  .-
  .mp2 / mp3:cfg m
  .-
  .sys sounds:cfg s
  .user sounds:cfg s u
  -
  channels
  .$£(1):j $£(1)
  .$£(2):j $£(2)
  .$£(3):j $£(3)
  .$£(4):j $£(4)
  .$£(5):j $£(5)
  .$£(6):j $£(6)
  .$£(7):j $£(7)
  .$£(8):j $£(8)
  .$£(9):j $£(9)
  .-
  .$iif($chr(44) isin %±aj,join all):cf10
  .$iif(%±aj,auto join [ $°(%±jc) ] ):„ jc auto-join
  .-
  .add:%±aj = $addtok(%±aj,#$$?#="channel to add?",44)
  .$iif(%±aj,remove):%±aj = $remtok(%±aj,#$$?#="channel to remove?",44)
  .$iif(%±aj,clear):û ±aj
  -
  mp2 / mp3
  .select:m
  .random:r
  .find:m ?
  wav
  .select:wav
  .random:wav *
  .find:wav ?
  midi
  .select:mid
  .random:mid *
  .find:mid ?
  -
  clones:scan
  scan:scan $$?="mask to scan for?"
  userlist:user
  -
  away
  .$iif(%±aw,back,away):if (%±aw) b | else a
  .quiet $iif(%±aw,back,away):if (%±aw) .b | else .a
  .-
  .pager $°(%±pg):„ pg pager
  .msg log $°(%±ml):„ ml msg log
}
menu @ports {
  dclick:server $window(@ports).title $gettok($line(@ports,$1),4,2)
}
menu @users {
  +	immune:” ±i 2 immune
  -	immune:” ±i 2
  -
  +	exile:” ±b 3 exiled
  -	exile:” ±b 3
  -
  	add:aline -s @users $$?="user mask?" 	- 	-
  	remove:”
}
menu @  {
  mouse:if ((%±^o) && ($mouse.key & 1) && ($Á != %±^h)) { À o | å }
  sclick:å | %±^o = 1
  dclick:å | %±^o = 1
  uclick:if (%±^o) À r | û ±^o
}
alias -l û [ unset % $+ [ $1 ] ]
alias -l ¤ if ($query($active).address != $active) return $mask( [ [ $active ] $+ ! $+ [ $ifmatch ] ] ,$1)
alias -l ³ i $mask(! [ $+ [ $query($1).address ] ] ,$2) | close -m $1
alias -l µ return $gettok(%±rs,$1,44)
alias -l £ return $gettok(%±aj,$1,44)
alias -l ° return $iif($1,	[on],	[off])
alias -l „ if ($~($1)) { û ± $+ $1 | Ê i² $2- is now off } | else { set %± $+ $1 1 | Ê i² $2- is now on } | »
alias -l Ï %±ï = %±ï $+ $1,
alias -l ï û ±ï | ˜ $ó $$1 Ï ˜ | $2 $deltok(%±ï,0,44) $3-
alias -l ˜ %±˜ = 1 | :± | if ($gettok($2,%±˜,44)) { $reptok($3-,˜,$ñ($ifmatch,$1),32) | inc %±˜ | goto ± }
alias -l Û ˜ x $õ ” $1 0 $2 ˜
alias -l — ˜ x $õ auto ˜ $· $1
alias -l ê editbox -ap $© $+ $1-
alias -l ø if ($me isop $·) return $1
alias -l · return $iif(#,#,$gettok($window(@scan).title,1,32))
alias -l æ return $address($gettok($õ,1,44),$1)
alias -l õ if (#) return $$snicks | %±n = 1 | û ±r | :± | if ($gettok($sline(@scan,%±n),3,9)) { %±r = %±r $ifmatch | inc %±n | goto ± } | return $÷(%±r)
alias -l ~ return %± [ $+ [ $remove($1-,$chr(32)) ] ]
alias -l _ $1-
alias -l ß return [ $+ $1]
alias -l Ê è o -a *** $ß($1) $2-
alias -l Ë è $1-2 *** $ß($2) $3-
alias -l è if (-* iswm $2) echo $colour($1) -ti2 $+ $2- | elseif (($2 ischan) || ($query($2))) echo $colour($1) -ti2 $2- | else echo $colour($1) -ati2 $3-
alias -l © return $readini $mircini text commandchar
alias -l ð %±x = $line(message window,0) | if (%±x < 1) dqwindow show | if (($1) && (*ge w* iswm $active) && ($numtok($editbox($active),32) < 3)) ê $1- | if ((%±x < 1) && ((%±aw) || (%±dm))) dqwindow min
alias -l … if (%±aw == $null) flash $nick [ $+ $1]
alias -l ÷ return $$replace($1,$chr(32),$chr(44))
alias -l œ if ((* isin $1) && ($right($2,1) isin ovh)) { _ œ $¿($1,$3,$4) $2-3 | return } | if ($3) { %±n = 1 | :± | %±r = %±n $+ $calc(-3-%±n) | if ($gettok($1,%±r,44)) { mode $3 $str($2,$numtok($ifmatch,44)) $replace($ifmatch,$chr(44),$chr(32)) | inc %±n 4 | goto ± } }
alias -l Ö %±b = $addtok(%±b,$address($1,$3),44) | if ($1 isop $2) %±d = %±d $+ $1,
alias -l ä whois $1 $1
alias -l í ignore $1- | close -m $1-2
alias -l ö onotice $1 [@ $+ $nick($1,0,o) $+ / $+ $1/i²] $2-
alias -l Ç return $istok(%±jw,$1,32)
alias -l ÿ ¢ # $vnick | if ($vnick == $me) ¬ $1
alias -l ¢ î $1-2 $~(n,$iif($2 == $me,y,$iif($2 isop $1,@,$iif($2 isvo $1,+,-))))
alias -l î if ($1 ischan) cline $round($3,0) $1-2
alias -l ¿ û ±f | %±x = 1 | :± | if ($ialchan($1,$2,%±x).nick) { if ($ifmatch $3 $2) %±f = $addtok(%±f,$ifmatch,44) | inc %±x | goto ± } | return %±f
alias -l ù x $site $1- | if ($ialchan($mask($fulladdress,3),#,0) <= %±>) œ $mask($fulladdress,3) b #
alias -l Ø if ($~($1) == $null) set %± $+ $1-
alias -l Ô .timer±t 0 1 ¶ | .timer±s 0 30 $!ticks $!+ § | %±lg = ? | unset %±uu %±uq* %±!* %±&* %±ns %±??.* %±jw %±rc %±cr %±mw %±nq
alias -l ¶ ¯ %±lg $+ s $¥($active) | if ((%±aa) && (%±aw == $null) && ($idle > $calc(60*%±aa))) { %±w = auto-away (idle %±aa min) | if (%±aq) .a %±w | else a %±w }
alias -l ¯ titlebar - $ß($1) $iif(%±aw,-) $iif(%±aw,$ß(%±aw)) $2- - [i²]
alias -l ¥ if ($1 ischan) return - [ $+ $1] $ç($nick($1,0,o),op) $ç($nick($1,0,v),voice) - total $nick($1,0) | return - $me ( $+ %±ma $+ )
alias -l ç if ($1) return - $2 $1 ( $+ $round($calc($1 /$nick($active,0)*100),0) $+ % $+ )
alias -l ¹ if ((%±aw) && (%±ml) && (#)) ² -d $1- | elseif ((%±hl) && ($target != $active) && ((* * !iswm $active) || (#))) ² -a $1- | if (($¼) && (%±wk)) { %±t = $replace($strip($1-),.,-,$chr(40),-,$chr(41),-,',-,",-,:,-,;,-,?,-,!,-,$chr(44),-,-,$chr(32)) | %±n = $numtok(%±wk,44) | :± | %±m = $wildtok(%±t,$gettok(%±wk,%±n,44),1,32) | if (%±m) Õ $¾ word kick on %±m | else { dec %±n | if (%±n) goto ± } }
alias -l Õ k $iif($1 == 2,3) $nick $2- $iif($1 == 2,(repeat offense))
alias -l ² %±h = $addtok($highlight,$me,44) | %±n = 1 | :± | %±o = $gettok(%±h,%±n,44) | if (%±o isin $2-) { %±b =  $+ $ifmatch $+  | if ($1 == d) ð | è h $1 *** $ß(note) < $+ $nick $+ $iif(#,:,>) $+ $chan> $replace($2-,%±o,%±b) | return } | inc %±n | if (%±o) goto ±
alias -l ™ if ($Œ(t)) Õ $ifmatch text flood
alias -l ¼ return $iif(($me isop #) && ($nick !isop #) && (±i !isin $level($fulladdress)) && ((%±pc == $null) || ($istok(%±pc,#,44))),1)
alias -l ¾ if ($~(ro.,$site)) return 2 | if (%±ro isnum) inc -u $+ [ %±ro ] %±ro. $+ $site | return 1
alias -l Œ if (($¼) && ($~($1s) isnum) && ($~($1k) isnum)) { inc -u $+ [ $~($1s) ] %± $+ $1. $+ $site $+ # | if ($~($1.,$site,#) >= $~($1k)) { û ±?. $+ $site $+ # | return $¾ } }
alias -l ® û ±: | :± | inc %±: | if ($chat(%±:).status == active) describe = $+ $chat(%±:) $1- | if ($chat(%±:)) goto ± | if (($show) && ($chan(0)) && ($server)) ame $1- | else Ê away $me $1-
alias -l » if (%±aw) { « | if ($server) { .raw away : $+ %±aw $iif(%±pg,- pager on) $iif(%±ml,- messages logged) - $ß(i²) | if (%±ml) { saveini | %±od = $readini $mircini options n0 | .dqwindow on | .timestamp on omessage } } }
alias -l « if ($gettok(%±od,22,44) < 1) .dqwindow off | û ±od
alias -l Ñ if ($1 ison $2) return $nick($2,$nick($2,$1)) | if ((* !isin $1) && ($ialchan($1*,$2,1).nick)) return $ifmatch | if ($1) return $1
alias -l ñ if (%±cc) return $Ñ($1,$2) | if ($1) return $1
alias -l ¬ if ($isfile($~(s,$1))) .splay " $+ $~(s,$1) $+ " | else return 1
alias -l § ˜ x %±ns ò ˜ $1- | û ±ns*
alias -l ò è q $ifmatch *** Netsplit - $~(ns.,$1) - $numtok($~(ns.,$1),32) user(s) - ( $+ $2 // $3)
alias -l à á - $1 hilight frame $2-5 | á -f $1 shadow face $2-3 $calc($4 -1) $calc($5 -1) | á - $1 frame hilight $calc(1+$2) $calc(1+$3) $calc($4 -2) $calc($5 -2) | drawline -nr @  $rgb($iif($1 == c,face,shadow)) 1 $calc(1+$2) $calc($3 +$5 -1) $calc($2 +$4 -1) $calc($3 +$5 -1) $calc($2 +$4 -1) $3 | if ($6) drawtext -nro @  $rgb(text) arial 21 $calc(2+$2) $calc($3 -4) ×
alias -l â drawtext -nr @  $rgb(text) arial 14 $1-2 $3-
alias -l á drawrect $1nr @  $rgb($iif($2 == c,$3,$4)) 1 $5-
alias -l ã $1 n $2- | %±^e = %±^e $÷(%±q) | %±^t = %±^t $1 | set %±^ $+ $numtok(%±^e,32) $2-
alias -l ‹ Å $1 $6 | if ($1 == r) { if ($5 == !) { set -u %±sz $~(^,$6) | ¬ z } | elseif ($5 == +) set %±^ $+ $6 $calc(($~(^,$6)+1)% 16) | elseif ($6) set %±^ $+ $6 $ [ $+ [ $8- ] ] $7 | else { if ($5 == ok) { %±n = 1 | :± | if ($gettok(%±^t,%±n,32)) { _ $ifmatch s $~(^,%±n) | inc %±n | goto ± } } | Ä } } | à $1-4 23 | %±t = $iif($5 == !,!,$iif($6,$~(^,$6),$5)) | if ((\ isin %±t) && (*\ !iswm %±t)) %±t = $nopath(%±t) | if (%±t != $null) { if ($5 == +) drawrect -fn @  %±t 1 $calc(3+$2) $calc(3+$3) $calc($4 -6) 17 | else â $calc(($4 -$width(%±t,arial,14,0,0))/2+$iif($1 == c,1,0)+$2) $calc(5+$iif($1 == c,1,0)+$3) %±t } | %±q = $2-4 23
alias -l › Å $1 $4 | if ($1 == r) Æ $4 $iif($5 == +,$iif($~(^,$4),0,1),$5) $~(^,$4) | à $1-3 13 13 $iif($5 == +,$~(^,$4),$iif($~(^,$4) == $5,1)) | â $calc(19+$2) $3 $6- | %±q = $2-3 $calc(19+$width($6-,arial,14,0,0)) 17
alias -l Ä window -c @  | .timer±^ off | $$0
alias -l Å if ($1 == n) set %±^ $+ $2 $~($2) | if ($1 == s) set %± $+ $2 $~(^,$2)
alias -l Æ set %±^ $+ $1-2 | %±n = 1 | :± | %±e = $~(^,%±n) | if (%±e) { if (* $1 $3 * iswm %±e) › o %±e | inc %±n | goto ± }
alias -l † { if ($1) %±f2 = $1- | if ($3 == ?) { _ † $1-2 $$?="word(s) or mask to find?" | return } | if ($isfile($3-)) %±lm = $3- | elseif (($3) && (%±d)) { if ((* !isin $3-) && (($findfile(%±d,$3-,1)) || ($findfile(%±d,$3- [ $+ [ $1 ] ] ,1)))) %±lm = $ifmatch | else { %±m = * $+ $replace($3-,$chr(32),*) $+ * $+ $1 | %±r = $findfile(%±d,%±m,0) | %±lm = $$findfile(%±d,%±m,$calc(($r(1,%±r)+$ticks)% %±r +1)) } } | else %±lm = $$dir=" [ $+ [ $2 ] ] to play?" [ %±d $+ * $+ [ $1 ] ] | %±f3 = $2 | if ($2 == mp) run -n %±mm $iif(%±mm,") $+ %±lm $+ $iif(%±mm,") | else splay " $+ %±lm $+ " | %±x = $replace(%±lm,_,$chr(32)) | if (((%±mq) && ($2 == mp)) || (* * iswm $active) || (@* iswm $active)) Ê $2 Playing %±x
else { if (($2 != mp) && ($1)) %±a = $?="action for $nopath(%±x) $+ ? (esc for default)" | else û ±a | if (%±a == $null) %±a = plays $ß($nopath(%±x)) - $int($calc($lof(%±lm)/1024)) $+ k - $iif(%±mg,type [ %±mg ] to get this file -) $ß(i²) | .c $active SOUND $replace($nopath(%±lm),$chr(32),?) %±a | è a -a * $me %±a } }
alias -l å %±^h = $Á | À c
alias -l Á %±f = 1 | :± | if ($gettok(%±^e,%±f,32)) { if ($inrect($mouse.x,$mouse.y, [ $ifmatch ] )) return %±f | inc %±f | goto ± }
alias -l À if (%±^h) $gettok(%±^t,%±^h,32) $1 $~(^,%±^h) | drawdot @ 
alias -l Â ã › 20 $1-
alias -l š inc %±uq | set %±uq $+ %±uq $1- | .raw userhost $3-7 | if ($8) _ š $1-2 $8-
alias -l Š Ê host $1 is $2 $iif($3 == +,(here),(away))
alias -l ƒ Ê host User not found
alias -l ¨ š ª halt %±nq | û ±nq
alias -l ª û ±un. $+ $1 | %±n = $notify($1).note | %±a = $gettok(%±n,1,32) | %±u = $2 | if (* isin %±a) { %±n = $gettok(%±n,2-,32) | if (%±a iswm $2) %±u = %±a | elseif (%±nh) return | else %±u = failed check - %±u } | è notif $iif(%±na,-a,-s) *** $ß(notify)  $+ $1 on IRC - %±u $ß($iif($3 == +,here,away)) %±n | set %±un. $+ $1  $+ $1 left IRC ( $+ %±u $+ ) | ¬ n
alias -l • if (%±rw > 1) ¡ | $iif(%±rw > 1,aline -h,echo) $colour(c) $iif(%±rw > 1,@ctcp,$iif(%±rw,-ati2,-sti2)) $ß($nick ( [ $+ [ $address) ] ] ) $1-
alias -l ¡ if ($window(@ctcp) == $null) window -lk -t14,20,26 @ctcp %±@ctcp | .timer 1 0 window -b @ctcp
alias -l þ ¡ | aline -h @ctcp  $+ $colour(c) $+ $ß($nick) PING:	 $Ð($1,	) 	 $+ $ˆ($1) $+ , $+ $ˆ($1) $+ $str(,$int($calc($log($calc($1 /200+1))*2.5+1)))
alias -l ˆ if ($iif($1 < 5000,%±p<,$iif($1 < 20000,%±p-,%±p>)) isnum) return $ifmatch | return $colour(c)
alias -l Ð return $iif($1 > 59999, [ $int($calc($1 /60000)) ] min) $2 $round($calc($1 /1000% 60),1) $+ s
alias -l ‰ Ê retry Nickname %±nr no longer in use, grabbing... | .timer±r off | nick %±nr
alias -l ‡ if (%±cr) j %±cr | else .timer±c off
alias -l Ý %±mw = $1 | if ((%±ww > 1) && ($window(@whois) == $null)) window -ek @whois %±@whois | if ($1) echo $colour(wh) $iif(%±ww > 1,-i2 @whois,$iif(%±ww,-ati2,-sti2)) $ß($1) $2- | else linesep $iif(%±ww > 1,@whois,$iif((%±ww) && (* * !iswm $active),$active,-s))
alias -l ½ if ($3 == on) set %± $+ $1 1 | if ($3 == off) set %± $+ $1 0 | Ê away $2 is $iif($~($1),on,off) | »
alias -l Þ set %± $+ $1 $window($1).x $window($1).y $window($1).w $window($1).h $1 $window($1).font $iif($window($1).fontbold,bold) $window($1).fontsize
alias -l × if ($Ç($1)) $$0
alias -l “ return 	 $+ $iif($1 isin $level(%±l),$2,-)
alias -l ” :± | if ($4) %±l = $address($4,3) | else { %±l = $$sline(@users,1) | $iif($1,rline,dline) @users $sline(@users,1).ln $puttok(%±l,$iif($3,$3,-),$2,9) | %±l = $gettok(%±l,1,9) } | $iif($3,.) $+ ruser $1 %±l | if ($level(%±l) == $dlevel) { .ruser %±l | if ($3) .auser $dlevel %±l } | if ($3) auser -a $1 %±l | if ($4 < 1) goto ±
alias -l ó return $iif(#,#,x)
alias -l É if (%±on) nick %±on | û ±on
alias a if ($1) away $1- | else away $$?="away reason? (esc to cancel)"
alias b away
alias c ï $1 ctcp $2-
alias d ˜ $ó $÷($1-) dcc chat ˜
alias e ˜ $ó $÷($1-) ä ˜
alias f ˜ $ó $$1 dcc send ˜ $2-
alias i if (-* iswm $1) ˜ $ó $$2 í $1 ˜ $3 | else ˜ $ó $$1 í ˜ $2
alias j join #$$?1="channel to join? (esc to cancel)" $2-
alias k if ($1 != #$1) { if (#) _ k # $1- | return } | if ($2 !isnum) { _ k $1 0 $2- | return } | if (* isin $3) { if ($¿($3,$1,ison)) _ k $1-2 $ifmatch $4- | return } | if ($4) { if ($2) { û ±b | û ±d | ˜ $1 $3 Ö ˜ $1- | œ %±d -o $1 | œ %±b b $1 | if (. isin $2) .timer 1 $gettok($2,2,46) if ($me isop $1) œ %±b -b $1 } | ˜ $1 $3 kick $1 ˜ $4- $ß(i²) } | else { if ($mouse.key & 4) _ k $1-2 $$3 $me | else _ k $1-2 $$3 $$?="reason? (esc to cancel)" }
alias l part # $1-
alias m %±d = %±md | † .mp? mp $1-
alias n if (@?* iswm $$1) ö $right($1,-1) $$2- | else ï $1 notice $ß($iif($1 == #$1,$1,private)) $$2-
alias o ï $÷($1-) œ o # !isop
alias p ping $iif($1,$÷($1-),$active)
alias q ˜ $ó $1 query ˜ $2-
alias r m $iif($1,$1-,*)
alias s if ($1) sound $1- | else sound $$dir="sound file?" $wavedir*.wav;*.mid $?="action? (esc for none)"
alias t topic # $1-
alias v ï $÷($1-) œ v # isreg
alias w ï $÷($1-) whois
alias x if ($1 != #$1) { if (#) _ x # $1- | return } | if ($2 !isnum) { _ x $1 -1 $2- | return } | if (* isin $3) %±a = $3 | else { if ($address($ñ($3,$1),$iif($2 < 0,3,$2))) %±a = $ifmatch | elseif (*!*@* iswm $3) %±a = $mask($3,$iif($2 < 0,3,$2)) | elseif (! isin $3) %±a = $mask($3@*,$iif($2 < 0,6,$2)) | elseif (@ isin $3) %±a = $mask(! [ $+ [ $3 ] ] ,$iif($2 < 0,3,$2)) | elseif (. isin $3) %±a = $mask(!@ [ $+ [ $3 ] ] ,$iif($2 < 0,2,$2)) | else { ban -u $+ [ $gettok($2,2,46) ] $1 $3 $iif($2 < 0,3,$2) | return } } | œ %±a -o $1 isop | œ %±a b $1 | k $1 %±a $iif($4,$4-,banned) | if (. isin $2) .timer 1 $gettok($2,2,46) if ($me isop $1) œ %±a -b $1
alias @ ö $iif($$1 != #$1,#) $1-
alias cf1 run $scriptdiri2.txt
alias f2 if (%±f2) † %±f2
alias f3 if ($isfile(%±lm)) † 0 %±f3 %±lm
alias f4 ê n %±ln
alias f5 p $1
alias f6 close -m $1 | d $query($1)
alias f7 %±f7
alias f8 ê run %±lf
alias cf8 ê run $nofile(%±lf)
alias f9 ê t $chan(#).topic
alias f10 ê server $µ(1)
alias cf10 if (%±aj) j %±aj
alias f11 a
alias cf11 .a
alias f12 b
alias cf12 .b
alias ctcp if ($$2 == ping) { .msg $1 PING 0 $+ $ticks $+  | è c -a -> [ $+ $1] PING } | else ctcp $1-
alias ping c $1 ping
alias wav %±d = $wavedir | † .wav wav $1-
alias mid %±d = $mididir | † .mid midi $1-
alias scan window -c @scan | if ($1 !ischan) { if (#) _ scan # $1 | return } | %±f = 0 | %±t = 0 | %±n = 1 | :± | %±a = $iif($2,$2,$mask($ialchan(*,$1,%±n),2)) | if (%±a) { if (($2) || (($ialchan(%±a,$1,0) > 1) && ($ialchan(*,$1,%±n).nick == $ialchan(%±a,$1,1).nick))) { %±c = 1 | inc %±f | :2 | %±k = $ialchan(%±a,$1,%±c).nick | if (%±k) { if ($window(@scan) == $null) window -lk -t17,24,35 @scan $iif(%±@scan,%±@scan,@scan) | aline @scan %±a 	 %±c 	 %±k 	 $ialchan(%±a,$1,%±c).addr | inc %±c | inc %±t | goto 2 } } | inc %±n | if (%±a != $2) goto ± } | if (%±t) titlebar @scan $1 - %±t $iif($2,user(s),clones) found $iif($2,,at [ %±f ] site(s)) | else Ê scan No clones/users detected on $1
alias dns if ((-* !iswm $1) && ($1) && ($show)) { linesep -a | Ê dns Looking up $iif(. !isin $1,address of) $1 | .dns $1 } | else dns $1-
alias userhost if ($show) { Ê host Looking up $1- | š Š ƒ $1- } | else š return return $1-
alias retry if ($1) { if ($server) { if (#$1 == $1) { %±cr = $addtok(%±cr,$1,44) | .timer±c 0 30 ‡ | Ê retry Channel $1 being retried. } | else { %±nr = $1 | .timer±r 0 30 š halt ‰ $1 | Ê retry Nickname $1 being retried. } } } | else { .timer±r off | û ±cr | Ê retry All nickname/channel retries halted. }
alias away if ($1) { ® is now away - $1- $iif(%±pg,- pager on) $iif(%±ml,- messages logged) - $ß(i²) | if (%±an) { %±on = $me | nick %±an } | %±at = $ctime | %±aw = $1- | » } | elseif (%±aw) { dqwindow $iif($line(message window,0),show,hide) | %±g = $duration($calc($ctime-%±at)) | ® is back from - %±aw - gone %±g - $ß(i²) | É | if ($server) away | û ±aw | « | resetidle }
alias pager ½ pg pager $1
alias mlog ½ ml logging $1
alias ports window -c @ports | stats l
alias user window -c @users | window -slk -t25,35 @users $iif(%±@users,%±@users,@users) | %±n = 1 | :± | %±l = $$ulist(*,%±n) | aline @users %±l $“(±i,immune) $“(±b,exiled) | inc %±n | goto ±
alias cfg { û ±^* | window -fpk +fLt @  $int($calc($window(-3).w /2-160)) $int($calc($window(-3).h /2-123)) 320 245 @  | á -f c face - 0 0 320 245 | .timer±^ -om 0 99 if ($active != @ ) Ä | %±> = $1 $+ ~ | goto %±> | :n~ | â 15 5 Nicklist colors- | %±p = 150 | %±n = 4 | %±h = OpVoicedRegularYour | :1 | ã ‹ 140 %±p 80 + n $+ $mid(@+-y,%±n,1) | â 60 $calc(5+%±p) $gettok(%±h,%±n,2) color | dec %±n | dec %±p 35 | if (%±n) goto 1 | goto ± | :p~ | â 10 5 Channel protection- | â 20 35 Tempban on | â 145 35 CTCPs in | â 260 35 seconds | â 20 65 Kick on | â 145 65 text lines in | â 260 65 seconds | â 20 185 Ban repeat offender within these seconds | â 20 95 Bankick on | â 145 95 clones total | ã ‹ 85 30 55 - ck ctcps?" ?="number of | ã ‹ 200 30 55 - cs seconds?" ?="number of | ã ‹ 85 60 55 - tk lines?" ?="number of text | ã ‹ 200 60 55 - ts seconds?" ?="number of | ã ‹ 85 90 55 - mc clones?" ?="number of
  ã ‹ 230 180 55 - ro seconds?" ?="number of | â 20 125 Word kicks | ã ‹ 85 120 225 - wk words/patterns?" ?="kick on what | â 20 155 Channels | ã ‹ 85 150 225 - pc channels?" ?="protect which | goto ± | :m~ | â 10 5 MP2 and MP3- | â 20 40 MP player | â 20 70 MP directory | â 20 100 Leech command | ã ‹ 99 35 192 - mm *.exe dir="mp player?" | ã ‹ 99 65 192 - md directory?" sdir="mp | ã ‹ 220 95 71 - mg command?" ?="leech | Â 130 mq + Only play locally | Â 150 mp + Play MPs from others | goto ± | :a~ | â 10 5 Away system- | â 39 30 Autoaway after this many minutes | ã ‹ 230 25 75 - aa minutes?" ?="number of | Â 50 aq + Quiet autoaway / back on keypress | Â 70 pg + Pager on | Â 90 ml + Message logging | â 39 115 Pager sound | ã ‹ 126 110 165 - sp *.wav dir="pager sound?" | ã ‹ 294 110 16 ! sp | â 39 150 Away nickname | ã ‹ 126 145 165 - an nickname?" ?="away | goto ± | :s~
  â 10 5 $iif($2,User,System) sounds- | %±p = 175 | %±n = 7 | %±h = $iif($2,NotifyNew queryDCC chatIncoming fileFile receivedFile sentFile error,ConnectDisconnectYou joinYou partYou oppedYou deoppedUser kicked) | :2 | ã ‹ 99 %±p 192 - s $+ $mid($iif($2,nqhfrse,ctjlodk),%±n,1) *.wav dir="sound?" | ã ‹ 294 %±p 16 ! s $+ $mid($iif($2,nqhfrse,ctjlodk),%±n,1) | â 20 $calc(5+%±p) $gettok(%±h,%±n,2) | dec %±n | dec %±p 25 | if (%±n) goto 2 | goto ± | :c~ | â 200 25 Low lag color | ã ‹ 200 48 80 + p< | â 200 85 Medium lag color | ã ‹ 200 108 80 + p- | â 200 145 High lag color | ã ‹ 200 168 80 + p> | :d~ | â 10 5 $iif($1 == c,CTCP,Display) config- | Â 25 $iif($1 == c,cw 0 CTCPs,ww 0 Whois) in status | Â 42 $iif($1 == c,cw 1 CTCPs,ww 1 Whois) in active | Â 59 $iif($1 == c,cw 2 Seperate CTCP,ww 2 Seperate Whois) window | Â 85 $iif($1 == c,pw 0 Pings,nm 0 Names (on join)) in status
Â 102 $iif($1 == c,pw 1 Pings in active,nm 1 Names (on join) in channel) | Â 119 $iif($1 == c,pw 2 Seperate ping window,nm 2 Hide names (on join)) | Â 145 $iif($1 == c,rw 0 CTCP replies in status,no + Perform notify address checks) | Â 162 $iif($1 == c,rw 1 CTCP replies in active,na + Notify in active) | Â 179 $iif($1 == c,rw 2 Seperate CTCP reply window,nh + Hide if failed address check) | goto ± | :%±> | â 10 5 Misc. config- | â 39 30 Nick completion on these characters | ã ‹ 230 25 55 - nc characters?" ?="nick completion | Â 50 cc + Use nick completion in commands | Â 70 hl + Show highlighted lines in active | Â 92 cn + Show channel/op notices in dqwindow | Â 109 pn + Show private notices in dqwindow | Â 126 dm + Minimize dqwindow when opened | Â 150 fq + Flash on new query | Â 167 fp + Flash on private message | Â 184 fd + Flash on DCC message | :± | ã ‹ 20 210 90 OK | ã ‹ 185 210 90 Cancel | À }
ctcp me:*:¶:%±ma = $address | halt
ctcp &*:sound:if ((*.mp? iswm $1) && (%±mp) && (%±md)) { %±m = $findfile(%±md,$1,1) | if (%±m) { è o $target *** $ß(mp) $ß($nick) Playing %±m | run -n %±mm $iif(%±mm,") $+ %±m $+ $iif(%±mm,") } }
ctcp *:dcc:¬ $mid(fh,$findtok(sendchat,$1,2),1)
ctcp &*:*:{ Œ c | if ($result == 2) ù ctcp flood (repeat offense) | elseif ($result) k 2.60 $wildsite ctcp flood (tempban) | inc -u10 %±rc | if (%±rc > 3) û ±r | elseif ($1 == ping) %±r = $2- | elseif (($1 == page) && (%±pg) && (%±aw)) { if ($¬(p)) beep | flash $nick [pager] | dqwindow show | è c -d *** $ß(pager) Paged by $nick ( $+ $address) $iif($2,$2-) | .ctcpreply $nick $1 Page was received | halt } | elseif ($1- == version) %±r = $ß(i²) by pai | elseif ($1- == time) %±r = $fulldate
elseif ($1- == finger) { saveini | %±r = idle $duration($idle) $readini $mircini text finger } | else û ±r | if (%±cw > 1) if (# !ischan) ¡ | $iif((#) || (%±cw < 2),echo,aline -h) $colour(c) $iif(#,-ti2,$iif(%±cw > 1,@ctcp,$iif(%±cw,-ati2,-sti2))) # $iif(#,$ß(#)) $ß($nick ( [ $+ [ $address) ] ] ) $iif(%±r,) $+ $1 $iif(($1 != ping) && ($1 != echo) && ($2),$2-) | if (((%±rc > 3) && ($1- == version)) || (%±rc > 8)) { è c -a *** $ß(flood) All CTCPs ignored for 60 seconds | .i -tu60 * } | if (%±r) .ctcpreply $nick $1 %±r | halt }
on me:*:join:#:.ial on | if ($chan(#).ial != $inwho) { who # | %±jw = %±jw # } | %±cr = $remtok(%±cr,#,44) | ¬ j
on ^*:join:#:¢ # $nick | %±> = $ialchan($wildsite,#,0) | if (%±> > 1) { if ((%±mc isnum) && (%±> >= %±mc) && ($¼)) ù clones | è j # *** $nick ( $+ $address) has joined # - %±> Clones - $¿($wildsite,#,ison) (F7 for details) | %±f7 = scan # | halt }
on @±b:join:#:x $maddress exiled
on *:op:#:ÿ o
on *:deop:#:ÿ d
on *:serverop:#:ÿ o
on *:voice:#:ÿ o
on *:devoice:#:ÿ d
on *:connect:Ô | %±ct = $ctime | .c $me ¶ | %±ma = ? | resetidle | if (%±jc) cf10 | » | %±rs = $server $port $+ , $+ $gettok($remtok(%±rs,$server [ $port ] ,44),1-8,44) | ¬ c
on *:disconnect:¯ offline | if (%±ct) è o -s *** $ß(i²) You were connected $duration($calc($ctime-%±ct)) | « | … disconnected | ¬ t
on *:start:¯ by pai | if ($server) Ô | Ê i² Welcome to i² 1.04 - CtrlF1 for docs | « | É | unset %±aw %±? %±lm %±lf %±f7 %±ln %±^* %±ct %±f3 | %±n = 47 | :± | Ø $$mid(fqp<p-p>pwcwrwnmwwckcsromcpgaaaqmlcnn@n+n-nynccc,%±n,2) $mid(1 2 6 4 2 1 1 0 1 7 10995 1 301 1 1 10141 4 : 1,%±n,2) | dec %±n 2 | goto ±
on *:text:*:*:if (# !ischan) if (%±fp) … msg | ™ | ¹ $1- | if (($1) && ($1 == %±mg) && (%±lm)) { %±n = $send(0) | :± | if (($send(%±n).file == $nopath(%±lm)) && ($send(%±n) == $nick) && (n !isin $send(%±n).status)) $$0 | dec %±n | if (%±n > 0) goto ± | f $nick %±lm }
on *:action:*:*:™ | ¹ $1-
on &^*:notice:*:#:™ | %±ln = $target | if (%±cn) { ð n %±ln | è not -d - $+ $nick: $+ $target- $1- | halt }
on ^*:notice:dcc *:?:;
on &^*:notice:*:?:%±ln = $nick | if ((%±pn) || ((%±aw) && (%±ml))) { ð n $nick | è not -d - $+ $nick- $1- | halt }
on *:input:?:if (* * iswm $active) .timer 1 0 editbox -ap $1 $iif($istok(@nmsg,$remove($1,$©),2),$2)
on &*:input:#:if (($left($1,1) == $©) && ($mid($1,2,1) isin -+)) { %±m = $right($1,-1) | %±t = $findtok(-o+o-v+v-b+b-e+e-i+i,%±m,2) | if ((%±t) && ($2)) ï $÷($2-) œ %±m # $gettok(isop!isopisvoisreg,%±t,2) | else mode # %±m $2- | halt } | if ($right($1,1) isin %±nc) { %±n = $left($1,-1) | if ($Ñ(%±n,#) !== %±n) { say $ifmatch $+ $right($1,1) $2- | halt } }
on *:kick:#:¬ k
on me:*:part:#:¬ l
on *:filercvd:*:%±lf = $filename | ¬ r
on *:filesent:*:¬ s
on *:getfail:*:¬ e
on *:sendfail:*:¬ e
on *:open:?:if (%±fq) … query | %±n = $comchan($nick,0) | if (%±n) { û ±c | :± | %±c = $comchan($nick,%±n) %±c | dec %±n | if (%±n) goto ± | è o $nick *** $nick is on: %±c } | ¬ q
on *:chat:*:if (%±fd) … msg | if (ping & iswm $1-) msg =$nick PONG $2
on *:ban:#:if ($banmask iswm $me! [ $+ [ %±ma ] ]) { è o # *** You were banned by $nick | if ($me isop #) { œ $banmask -b # | if ($nick != $me) k $nick don't ban me } }
on &*:dns:if ($naddress == $iaddress) Ê dns No such user $nick | elseif ($raddress) { Ê dns Resolved $iif($raddress == $iaddress,$naddress,$iaddress) to $raddress (F7 to copy) | %±f7 = clipboard $raddress } | else Ê dns Failed to resolve $iif($iaddress,$iaddress,$naddress) | halt
on &^*:quit:if (($count($1,.) > 1) && ($count($2,.) > 1) && ($3 == $null)) { %±n = 1 | :± | if ($comchan($nick,%±n)) { set %±ns. $+ $ifmatch $~(ns.,$ifmatch) $nick | %±ns = $addtok(%±ns,$ifmatch,44) | inc %±n | goto ± } | .timer±n 1 3 § $1- | halt }
on &^*:notify:if (%±no) { .timer±u 1 1 ¨ | %±nq = %±nq $nick | halt } | else ¬ n
on &^*:unotify:if ($~(un.,$nick)) { è notif $iif(%±na,-a,-s) *** $ß(unnotify) $~(un.,$nick) | û ±un. $+ $nick | halt }
on *:ctcpreply:ping *:if (($2 !isnum) || (0* !iswm $2)) • $1 "reply": $2- | else { %±t = $ticks - $2 | if (%±t < 0) • $1 "reply": $2- | elseif (%±pw > 1) þ %±t | else è c $iif(%±pw,-a,-s) *** $ß($nick ( [ $+ [ $address) ] ] ) PING reply: $+ $ˆ(%±t) $Ð(%±t) } | halt
on *:ctcpreply:*:• $1 reply: $2- | halt
on *:close:@:if ($istok(@ctcp@ports@scan@whois@users,$target,2)) Þ $target
raw &211:*:if ($istok($2,$server,91)) { if ($window(@ports) == $null) { window -lsk @ports $iif(%±@ports,%±@ports,@ports courier new 12) | titlebar @ports $server } | if ($remove($gettok($2,2,91),])) { %±p = $gettok($ifmatch,$numtok($ifmatch,46),46) | if (($remove($ifmatch,%±p,.,*,0)) || (%±p < 999)) halt } | else %±p = 6667 | %±s = $str( ,9) $+ $round($calc(($5 +$7)/1024),1) $+ k | aline @ports  $right(%±s,10) on port $ß(%±p) $iif(%±p == $port,(current / last)) } | halt
raw 302:*:haltdef | inc %±uu | %±x = $~(uq,%±uu) | û ±uq $+ %±uu | if ($2) { %±z = 2 | :± | %±y = $$ [ $+ [ %±z ] ] | $gettok(%±x,1,32) $gettok(%±y,1,61) $right($gettok(%±y,2,61),-1) $left($gettok(%±y,2,61),1) | inc %±z | goto ± } | else $gettok(%±x,2,32)
raw &307:& & is a *:Ý $2- | halt
raw 315:*:if ($Ç($2)) { %±jw = $remtok(%±jw,$2,32) | halt }
raw 352:*:if ($Ç($2)) { ¢ $2 $6 | halt }
raw 401:*t l*:;
raw 421:& *§ *:%±lg = $round($calc(($ticks -$calc($2))/1000),1) | halt
raw &433:*in u*:Ê nick Nickname $2 in use (F7 to auto retry) Performing whois... | %±f7 = retry $2 | whois $2 | halt
raw &*:*:{ %±r = $$mid(IIIIIII.I..-SSSSSSSS.*SSS................SiSS..SSsiiIIIiiiii.Iic.ii....Ii.......Ii........Sssssc.....*-..*hiwww**w*-.***w...*...t*.t**.......*I........i-*........ii..*II*.s..s......iI............c.....*CCtCAC.c.ccCC.C....Accc......cCC..CtCA.*t*Ccc....C...c.....Ccccc.tc..jCjjj.tt..ctc.......c.........cc........CCi,$calc($numeric-199),1) | if (%±r == .) $$0 | haltdef | goto %±r | :a | è o -a *** $iif(%±r !== a,$ß($2),$2) $3- | $$0 | :s | :c | :i | è %±r -s *** $iif($asc(%±r) < 91,$ß($2),$2) $3- | $$0 | :t | Ë o $2- | $$0 | :w | Ý $2- | $$0 | :* | goto $numeric | :221 | è m -s *** Your usermode is $2 | :301 | if (%±mw) Ý $2 away: $3- | else { inc -u45 %±! $+ $2 | if ($~(!,$2) < 2) Ë o $2 away: $3- } | $$0 | :305 | if (%±aw) { if (%±aq) .b | else b } | $$0 | :311 | :314 | %±w = Ý $2 $iif($numeric < 314,is,was) | Ý | %±w $3 $+ @ $+ $4 | %±w " $+ $6-" | $$0 | :312 | Ý $2 on $3 ( $+ $4-) | $$0 | :317
  Ý $2 idle $duration($3) | Ý $2 on since $asctime($4) | $$0 | :318 | :369 | Ý $2- | Ý | $$0 | :319 | Ý $2 on $replace($3-,@,@,+,+,%,%) | $$0 | :324 | × $2 | Ë m $2 Channel mode is $3- | $$0 | :329 | × $2 | Ë m $2 Channel created $asctime($3) | $$0 | :332 | Ë t $2 Topic is ' $+ $3-' | $$0 | :333 | Ë t $2 Topic by $3 on $asctime($4) | $$0 | :341 | Ë o $3 Inviting $2 to channel | $$0 | :353 | %±n = $iif($Ç($3),%±nm,0) | if (%±n < 2) è o $iif(%±n,$3,-s) *** $ß($3) $replace($4-,@,@,+,+,%,%) | $$0 | :366 | × $2 | è o -s *** $ß($2) End of /names | $$0 | :401 | inc -u45 %±& $+ $2 | if ($~(&,$2) < 2) Ë c $2 No such user | $$0 | :441 | :443 | Ë c $3 $2 is $iif($numeric < 443,not,already) not on channel | $$0 | :j | if ($istok(%±cr,$2,44)) $$0 | è c -s *** $ß($2) Cannot join- $gettok(Channel is full (+l).Channel is invite-only (+i)You're banned (+b)You need the correct key (+k),$calc($numeric-470),2) (F7 to auto retry)
%±f7 = retry $2 | :h }
