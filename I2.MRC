menu query,nicklist,@scan {
  $ø(opping)
  .$Ÿ(op):œ $õ o $· a o
  .$Ÿ(deop):œ $õ -o $· o -
  .-
  .$Ÿ($Ó(halfop)):œ $õ h $· a oh
  .$Ÿ($Ó(dehalfop)):œ $õ -h $· h -
  .-
  .voice:œ $õ v $· r -
  .devoice:œ $õ -v $· v -
  -
  $ø(kick):k $· $õ
  $ø(tempban):k $· 2.30 $õ
  $iif($æ(3),$ø(bankick))
  .$submenu($ô($1,k $!·,$!õ))
  -
  whois:w $õ
  $iif(!$chan,extended):e $õ
  $iif(!$chan,dns):dns $õ
  $iif(!$chan,-)
  $€(ping):p $õ
  -
  $iif(!$query($1),query):q $õ
  $€(chat):d $õ
  send:f $õ
  -
  $€(lists)
  .add immune:Û ±i 1
  .rem immune:Û ±i 0
  .-
  .add exile:Û ±b 1 | if ($Ò($·)) k $· 3 $õ exiled
  .rem exile:Û ±b 0
  .-
  .$iif($æ(3),protect)
  ..$submenu($ô($1,—,protect))
  .$iif($æ(3),auto op)
  ..$submenu($ô($1,—,aop))
  .$iif($æ(3),auto voice)
  ..$submenu($ô($1,—,avoice))
  $€(ignore)
  .$¤(2):i $õ 2
  .$¤(3):i $õ 3
  .$¤(4):i $õ 4
  .-
  .$1!*@*:i $õ
  .-
  .temp:i -u180 $õ 2
}
menu channel,menubar {
  config
  .protection:cfg p
  .away:cfg a
  .other:cfg
  .-
  .display:cfg d
  .ctcps:cfg c
  .-
  .mp3:cfg m
  .-
  .sys sounds:cfg s
  .user sounds:cfg s u
  -
  $iif($Ù > z,channels)
  .$submenu($ë($1))
  .-
  .$iif($Ú isin $ú,join all):cf10
  .$iif($ú,$style($y(j,$Ù)) auto join):„ j $+ $Ù auto-join
  .-
  .$iif(!$istok($ú,#,44),add #):set %± $+ $Ù $addtok($ú,$u(channel to add?,1,1,#),44)
  .$iif(($istok($ú,#,44)) || (# $ú == $null $ú),remove #):set %± $+ $Ù $remtok($ú,$u(channel to remove?,1,1,#),44)
  .$iif($ú,clear):û $Ù
  -
  mp3
  .select:m
  .random:r
  .find:m ?
  .-
  .$iif(%±mi,$iif(%±c2,resume,pause)):cf2
  wav
  .select:wav
  .random:wav *
  .find:wav ?
  .-
  .stop:cf2
  midi
  .select:mid
  .random:mid *
  .find:mid ?
  .-
  .stop:cf2
  -
  clones:scan
  scan:scan $$u(mask to scan for?,1)
  userlist:user
  -
  away
  .$iif(%±aw,back,away):$iif(%±aw,b,a)
  .quiet $iif(%±aw,back,away):$iif(%±aw,.b,.a)
  .-
  .$style(%±pg) pager:„ pg pager
  .$style(%±ml) msglog:„ ml msglog
}
menu status {
  connect:server $$u(server to connect to?,1) $u(port?,2)
  $iif($server,ports):ports
  -
  $submenu($Í($1))
  -
  $iif($server,quit):quit $$u(quit reason?,1)
}
menu @  {
  mouse:if ((%±^o) && ($mouse.key & 1) && ($Á != %±^h)) { À o | å }
  sclick:å | %±^o = 1
  dclick:å | %±^o = 1
  uclick:if (%±^o) À r | û ^o
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
  	add:aline -s @users $$u(user mask?,1) 	- 	-
  	remove:”
}
ctcp me:*:¶:set %±ma $+ $z $address | halt
ctcp &*:sound:Ž $2
ctcp *:dcc:¬ $mid(fh,$findtok(sendchat,$1,2),1)
ctcp &*:*:{ Œ c | if ($result == 2) ù ctcp flood (repeat offense) | elseif ($result) k 2.60 $wildsite ctcp flood (tempban) | inc -u10 %±rc | if (%±rc > 3) û r | elseif ($1 == ping) %±r = $2- | elseif (($1 == page) && (%±pg) && (%±aw)) { if ($¬(p)) beep | … pager 1 | dqwindow show | è c -d *** $g(pager) Paged by $nick ( $+ $address $+ ) $2- | .ctcpreply $nick $1 Page was received | halt } | elseif ($1- == version) %±r = $g(i²) 1.08 by pai | elseif ($1- == time) %±r = $fulldate
elseif ($1- == finger) { saveini | %±r = idle $duration($idle) $readini $mircini text finger } | else û r | if (%±cw > 1) if (# !ischan) ¡ | $iif((#) || (%±cw < 2),echo,aline -h) $color(c) $iif(#,-ti2 #,$iif(%±cw > 1,@ctcp,$iif(%±cw,-ati2,-sti2))) $iif(#,$g(#)) $Ã $iif(%±r,) $+ $1 $iif(!$istok(pingecho,$1,2),$2-) | if (((%±rc > 3) && ($1- == version)) || (%±rc > 8)) { è c -a *** $g(flood) All CTCPs ignored for 60 seconds | .i -tu60 * } | if (%±r) .ctcpreply $nick $1 %±r | halt }
on me:*:join:#:.ial on | if (!$chan(#).inwho) { who # | ü } | ü | set %±cr $+ $z $remtok($y(cr,$z),#,44) | ¬ j
on ^*:join:#:%±> = $ialchan($wildsite,#,0) | if (%±> > 1) { if (%±mc isnum) if (%±> >= %±mc) if ($¼) ù clones | è j # *** $nick ( $+ $address $+ ) has joined # - %±> Clones - $¿($wildsite,#,a,-) (F7 for details) | %±f7 = scan # | halt }
on ±b:join:#:if ($Ò(#)) x $maddress exiled
on *:rawmode:#:var %n = $mode(0),%c | while (%n) { %c = 1 | while (%c < 7) { if ($($!mode(%n). $+ $gettok(ophelpvoicedeopdehelpdevoice,%c,2),2) == $me) { ¬ $iif(%c < 4,o,d) | if (%c < 2) Ü } | inc %c } | dec %n }
on *:connect:Ô | set %±ct $+ $z $ctime | .c $me ¶ | set %±ma $+ $z ? | resetidle | if ($y(j,$Ù)) cf10 | » | %±rs = $server $port $+ , $+ $gettok($remtok(%±rs,$server $port,44),1-8,44) | ¬ c
on *:disconnect:if ($y(ct,$z)) { è o -s *** $g(i²) You were connected $duration($calc($ctime -$y(ct,$z))) | … disconnected } | û ct $+ $z | « | ¬ t
on *:start:.timer±t -io 0 1 ¶ | if ($server) Ô | Ê i² Welcome to i² 1.08 - Ctrl F1 for docs | « | É | unset %±aw %±? %±lm %±lf %±f7 %±ln %±^* %±ct* %±f3
on *:load:%±n = 1 | :± | set %± $+ $$mid(fqp<p-p>pwcwrwnmwwckcsromcpgaaaqmlcnnccc,%±n,2) $mid(1 2 6 4 2 1 1 0 1 7 10905 1 301 1 1 : 1,%±n,2) | inc %±n 2 | goto ±
on *:action:*:*:™ | ¹ $1-
on *:text:*:*:if (# !ischan) if (%±fp) … msg | ™ | ¹ $1- | if (($1) && ($1 == %±mg) && (%±lm)) { var %n = $send(0) | while (%n) { if ($send(%n).file == $nopath(%±lm)) if ($send(%n) == $nick) if (n !isin $send(%n).status) ý | dec %n } | f $nick %±lm }
on &^*:notice:*:?:if ($1 == dcc) ý | %±ln = $nick | if ((%±pn) || ((%±aw) && (%±ml))) { ð n $nick | è not -dmr $+(-,$nick,-) $1- | halt }
on &^*:notice:*:#:™ | %±ln = $target | if (%±cn) { ð n %±ln | è not -dmr $+(-,$nick,:,$target,-) $1- | halt }
on *:input:?:if (* * iswm $active) .timer 1 0 editbox -ap $1 $iif($istok(@nmsg,$mid($1,2),2),$2)
on &*:input:#:if ($regex($1,/^\ $+ $© $+ [-+]/)) { %±m = $mid($1,2) | %±t = $findtokcs(-o+o-h+h-v+v-b+b-e+e-I+I,%±m,2) | $iif((%±t) && ($2),ï $÷($2-) œ %±m # $gettok(o -a oh -a hov -r -,%±t,2),mode # %±m $2-) | halt } | if ($mid($1,-1) isin %±nc) { %±n = $left($1,-1) | if ($Ñ(%±n,#) !=== %±n) { say $ifmatch $+ $mid($1,-1) $2- | halt } }
on me:*:part:#:¬ l
on *:kick:#:¬ k
on *:filercvd:*:%±lf = $filename | ¬ r
on *:getfail:*:¬ e
on *:filesent:*:¬ s
on *:sendfail:*:¬ e
on *:chat:*:if (%±fd) … msg | if (ping == $1) if ($2- isnum) msg =$nick PONG $2 | if ($1 == SOUND) Ž $2
on *:open:?:*:if (%±fq) … query | var %n = $comchan($nick,0),%c | if (%n) { while (%n) { %c = $comchan($nick,%n) %c | dec %n } | è o $nick *** $nick is on: %c } | ¬ q
on *:ban:#:if ($banmask iswm $+($me,!,$y(ma,$z))) { è o # *** You were banned by $nick | if ($Ò(#)) { œ $banmask -b # | if ($nick != $me) k $nick don't ban me } }
on &*:dns:if (!$address) Ê dns No such user $nick | elseif (!$raddress) Ê dns Failed to resolve $address | var %d = 1 | while ($dns(%d)) { Ê dns Resolved $ifmatch to $iif($dns(%d).addr != $ifmatch,$ifmatch,$dns(%d).ip) $iif(%d < 2,(F7 to copy)) | %±f7 = clipboard $raddress | inc %d } | linesep -a | halt
on &^*:quit:if ((*.* *.* iswm $1-) && (!$3)) { %±n = 1 | while ($comchan($nick,%±n)) { set $+(%,±ns,$z,$ifmatch) $y(ns,$z,$ifmatch) $nick | set %±ns $+ $z $addtok($y(ns,$z),$ifmatch,44) | inc %±n } | .timer±n $+ $z 1 5 § $1- | halt }
on &^*:notify:if (%±no) { .timer±u $+ $z 1 1 ¨ | set %±nq $+ $z $y(nq,$z) $nick | halt } | else ¬ n
on &^*:unotify:if ($y(un,$z,$nick)) { è notif $iif(%±na,-a,-s) *** $g(unnotify) $y(un,$z,$nick) | û $+(un,$z,$nick) | halt }
on *:ctcpreply:ping *:var %t = $ticks - $2 | $iif((0* !iswm $2) || (%t !isnum 0-),• $1 "reply": $2-,$iif(%±pw > 1,þ %t,è c $iif(%±pw,-a,-s) $Ã PING reply: $+ $ˆ(%t) $Ð(%t))) | halt
on *:ctcpreply:*:• $1 reply: $2- | halt
on *:close:@:if ($istok(@ctcp@ports@scan@whois@users,$target,2)) Þ $target
raw &433:*in u*:Ê nick Nickname $2 in use (F7 to auto retry) $iif($y(ct,$z),Performing whois...) | %±f7 = retry $2 | if ($y(ct,$z)) whois $2 | elseif ($2 != $mnick) editbox -sp $© $+ nick | halt
raw &211:*:if ($istok($2,$server,91)) { if (!$window(@ports)) { window -lskvz @ports $iif(%±@ports,%±@ports,@ports courier new 12) | titlebar @ports $server } | if ($remove($gettok($2,2,91),])) { var %p = $gettok($ifmatch,-1,46) | if (($remove($ifmatch,%p,.,*,0)) || (%p < 999)) halt } | else %p = 6667 | aline @ports  $mid($+($str( ,9),$round($calc(($5 +$7)/1024),1),k),-10) on port $g(%p) $iif(%p == $port,(current / last)) | halt }
raw &307:& & is a *:Ý $2- | halt
raw 302:*:haltdef | inc %±uu $+ $z | var %x = $y(uq,$z,$y(uu,$z)),%y,%z = 2 | û $+(uq,$z,$y(uu,$z)) | if ($2) { :± | %y = $$($ $+ %z,2) | $gettok(%x,1,32) $gettok(%y,1,61) $mid($gettok(%y,2,61),2) $left($gettok(%y,2,61),1) | inc %z | goto ± } | else $gettok(%x,2,32)
raw 315:*:é $2
raw 352:*:× $2
raw 401:*t l*:;
raw 421:& *§ *:set %±lg $+ $z $round($calc(($ticks -$calc($2))/1000),1) | halt
raw &*:*:{ var %z = $iif($Ç($3),%±nm,0),%r = $$mid(iiii $+ $str(.,195) $+ IIIIIII.I..-SSSSSSSS.nSSS................SiSS..SSsiiIIIiiiii.Iic.ii....Ii.......Ii........Sssssc.....n-..nhiwwwNnwn-.nWnw...n...tn.tnn.......nI........i-n........ii..nIIW.s..s......iI............c.....nCCtCOC.c.ccCC.C....Occc......cCC..CtCO.NtnCcc....C...c.....Ccccc.tc..1C234.tt..ctc.......c.........cc........CCi,$numeric,1) | if (%r == .) ý | haltdef | goto %r | :o | :s | :c | :i | è %r $iif(%r == o,-a,-s) *** $iif($asc(%r) < 91,$g($2),$2) $3- | ý | :t | Ë o $2- | ý | :w | Ý $2- | if (%r === W) Ý | ý | :n | goto $numeric | :221 | è m -s *** Your usermode is $2 | ý | :301 | if ($y(mw,$z)) Ý $2 away: $3- | else { if (!$y(!,$2)) Ë o $2 away: $3- | inc -u45 %±! $+ $2 } | ý | :305 | if (%±aw) $iif(%±aq,.b,b) | ý | :311 | :314 | %z = Ý $2 $iif(%r === N,is,was) | Ý | %z $+($3,@,$4) | %z " $+ $6-" | ý | :312 | Ý $2 on $3 ( $+ $4-) | ý | :317
Ý $2 idle $duration($3) | Ý $2 on since $asctime($4) | ý | :319 | Ý $2 on $replace($3-,@,@,+,+,%,%) | ý | :324 | × $2 | Ë m $2 Channel mode is $3- | ý | :329 | é $2 | Ë m $2 Channel created $asctime($3) | ý | :332 | Ë t $2 Topic is ' $+ $3-' | ý | :333 | Ë t $2 Topic by $3 on $asctime($4) | ý | :341 | Ë o $3 Inviting $2 to channel | ý | :353 | if (%z < 2) è o $iif(%z,$3,-s) *** $g($3) $replace($4-,@,@,+,+,%,%) | ý | :366 | × $2 | è o -s *** $g($2) End of /names | ý | :401 | if (!$y(&,$2)) Ë c $2 No such user | inc -u45 %±& $+ $2 | ý | :441 | :443 | Ë c $3 $2 is $iif(%r === N,not,already) not on channel | :h | ý | :%r | if ($istok($y(cr,$z),$2,44)) ý | è c -sm *** $g($2) Cannot join- $gettok(Channel is full (+l)Channel is invite-only (+i)You're banned (+b)You need the correct key (+k),%r,2) (F7 to auto retry) | %±f7 = retry $2 }
alias -l Ú return ,
alias -l ú return $y($Ù)
alias -l Ù return z $+ $network
alias -l é if ($Ç($1)) { set %±jw $+ $z $remtok($y(jw,$z),$1,32) | halt }
alias -l ü set %±jw $+ $z $y(jw,$z) #
alias -l Ü if ($regex(a $chan(#).mode,/^a( \S*k\S*)?$/)) ü
alias -l Ò if ($nick($1,$me,oh)) return 1
alias -l Ó if (% isin $prefix) return $1
alias -l z return $cid $+ .
alias -l Í if ($1 < 10) return $!µ( $1):server $!µ( $1)
alias -l ë if ($1 isnum) if ($£($1)) return $!£( $1):j $!£( $1)
alias -l u %±Î = $iif($4,$4,$input($1 $gettok((esc to cancel)(esc for default)(esc for none),$2,2),1)) | if ($3) if ($$left(%±Î,1) !isin $chantypes $+ !+) return $chr(35) $+ %±Î | return %±Î
alias -l û unset %± $+ $1
alias -l ý $$$
alias -l € if (=* !iswm $active) return $1
alias -l ¤ if ($query($õ).address) return $mask($+($õ,!,$ifmatch),$1) | return $æ($1)
alias -l µ return $gettok(%±rs,$1,44)
alias -l £ return $gettok($ú,$1,44)
alias -l „ ½ $1 $2 $iif($y($1),off,on)
alias -l Ï %±ï = %±ï $+ $1,
alias -l ï û ï | ˜ $ó $$1 Ï ˜ | $2 $deltok(%±ï,0,44) $3-
alias -l ˜ %±˜ = 1 | :± | if ($gettok($2,%±˜,44)) { $reptok($3-,˜,$ñ($ifmatch,$1),32) | inc %±˜ | goto ± }
alias -l Û ˜ x $õ ” $1 0 $2 ˜
alias -l — ˜ x $õ $2 ˜ $· $1
alias -l ô if ($1 isin 48beginend) return - | %±ý = $gettok(3 13 1 0 8 18 6 0 4 2,$1,32) | if (%±ý) return $¤(%±ý) : $2 %±ý $3
alias -l ê editbox -ap $© $+ $1-
alias -l ø if ($Ò($·)) return $1
alias -l Ÿ if ($me isop $·) return $1
alias -l · return $iif(#,#,$gettok($window(@scan).title,1,32))
alias -l Ã return $g($nick,( $+ $address $+ ))
alias -l æ return $address($gettok($õ,1,44),$1)
alias -l õ if (#) return $$snicks | if ($query($active)) return $active | if (* * iswm $active) return $$snotify | var %n = 1,%r | while ($sline(@scan,%n)) { %r = %r $gettok($sline(@scan,%n),5,32) | inc %n } | return $÷(%r)
alias -l y return $($remove(% ± $1-,$chr(32)),2)
alias -l _ $1-
alias -l g return [ $+ $1-]
alias -l Ê è o -a *** $g($1) $2-
alias -l Ë è $1-2 *** $g($2) $3-
alias -l © return $readini $mircini text commandchar
alias -l ð %±x = $line(message window,0) | if (!%±x) dqwindow show | if ($1) if (*ge w* iswm $active) if ($numtok($editbox($active),32) < 3) ê $1- | if ((%±aw) || (%±dm)) if (!%±x) dqwindow min
alias -l … if ((!%±aw) || ($3)) flash [ $+ $1] $nick
alias -l ÷ return $$replace($1,$chr(32),$Ú)
alias -l è echo $color($1) -ti2 $+ $iif(-* iswm $2,$2,$iif(($2 ischan) || ($query($2)),- $2,a)) $3-
alias -l œ if (* isin $1) if ($mid($2,-1) isincs ovh) tokenize 32 $¿($1,$3,$4,$5) $2-3 | if ($3) { %±n = 1 | :± | %±r = %±n $+ $calc(-$modespl +1-%±n) | if ($gettok($1,%±r,44)) { mode $3 $str($2,$numtok($ifmatch,44)) $replace($ifmatch,$Ú,$chr(32)) | inc %±n $modespl | goto ± } }
alias -l Ö %±b = $addtok(%±b,$address($1,$3),44) | if ($1 isop $2) %±o = %±o $+ $1,
alias -l ä whois $1 $1
alias -l í ignore $1- | close -m $1-2
alias -l ö onotice $1 $+([@,$nick($1,0,o),/,$1/i²]) $2-
alias -l Ç return $istok($y(jw,$z),$1,32)
alias -l ¿ var %v,%f,%x = 1 | :± | %v = $ialchan($1,$2,%x).nick | if (%v) { if ($nick($2,%v,$3,$4)) %f = $addtok(%f,%v,44) | inc %x | goto ± } | return %f
alias -l ù x $site $1- | if ($ialchan($mask($fulladdress,3),#,0) <= %±>) œ $mask($fulladdress,3) b #
alias -l Ô .timer±s $+ $z 0 30 $!ticks $!+ § | set %±lg $+ $z ? | unset %±!* %±&* $+(%,±??,$z,*) %±rc
alias -l ¶ ¯ $iif($server,$y(lg,$z) $+ s $¥($active),offline) | if ((%±aa) && (!%±aw)) { û s | scid -at1 if ($idle < $calc(60*%±aa) ) $!$$ $chr(124) inc % $+ ±s | if (%±s) $iif(%±aq,.a,a) auto-away (idle %±aa min) }
alias -l ¯ titlebar - $g($1) $iif(%±aw,- $g(%±aw)) $2- - [i²]
alias -l ¥ if ($1 ischan) return - [ $+ $1] $ç($nick($1,0,o),op) $Ó($ç($nick($1,0,h),half)) $ç($nick($1,0,v),voice) - total $nick($1,0) | return - $me ( $+ $y(ma,$z) $+ )
alias -l ç if ($1) return - $2 $1 ( $+ $round($calc($1 /$nick($active,0)*100),0) $+ % $+ )
alias -l ¹ if ((%±aw) && (%±ml) && (#)) ² -dm $1- | elseif (%±hl) if ($target != $active) if ((* * !iswm $active) || (#)) ² -a $1- | if (($¼) && (%±wk)) { %±t = $replace($strip($1-),.,-,$chr(40),-,$chr(41),-,',-,",-,:,-,;,-,?,-,!,-,$Ú,-,-,$chr(32)) | %±n = $numtok(%±wk,44) | while (%±n) { %±m = $wildtok(%±t,$gettok(%±wk,%±n,44),1,32) | if (%±m) { Õ $¾ word kick on %±m | break } | dec %±n } }
alias -l Õ k $iif($1 == 2,3) $nick $2- $iif($1 == 2,(repeat offense))
alias -l ² var %o,%h = $me,%n = $highlight(0) | while (%n) { %h = %h $+ , $+ $highlight(%n) | dec %n } | %n = 1 | :± | %o = $gettok(%h,%n,44) | if (%o isin $2-) { è h $1 *** $g(note) $+(<,$nick,$iif(#,: $+ #),>) $replace($2-,%o,$+(,%o,)) | return } | inc %n | if (%o) goto ±
alias -l ™ if ($Œ(t)) Õ $ifmatch text flood
alias -l ¼ if ((($me isop #) || (($Ò(#)) && ($nick !ishop #))) && ($nick !isop #)  && (±i !isin $level($fulladdress)) && ((!%±pc) || ($istok(%±pc,#,44)))) return 1
alias -l Œ if (($¼) && ($y($1s) isnum) && ($y($1k) isnum)) { inc -u $+ [ $y($1s) ] %±: $+ $+($1,$z,$site,#) | if ($y(:,$1,$z,$site,#) >= $y($1k)) { û $+(:?,$z,$site,#) | return $¾ } }
alias -l ¾ if ($y(ro,$z,$site)) return 2 | if (%±ro isnum) inc -u $+ [ %±ro ] $+(%,±ro,$z,$site) | return 1
alias -l ® var %n = 1 | while (($show) && ($chat(%n))) { if (a* iswm $chat(%n).status) describe = $+ $chat(%n) $1- | inc %n } | %n = $1- | scid -a if (( $show ) && ($chan(0)) && ($server)) ame % $+ n $chr(124) else Ê away $!me % $+ n
alias -l » if (%±aw) { « | if ($server) { .raw away : $+ %±aw $iif(%±pg,- pager on) $iif(%±ml,- messages logged) - $g(i²) | if (%±ml) { saveini | %±od = $readini $mircini options n0 | .dqwindow on | .timestamp on omessage } } }
alias -l « if ($gettok(%±od,22,44) < 1) .dqwindow off | û od
alias -l ñ if (%±cc) return $Ñ($1,$2) | if ($1) return $1
alias -l Ñ if ($1 ison $2) return $nick($2,$nick($2,$1)) | if (* !isin $1) if ($ialchan($1*,$2,1).nick) return $ifmatch | if ($1) return $1
alias -l ¬ $iif($isfile($y(s,$1)),.splay $+(",$y(s,$1),"),return 1)
alias -l § ˜ x $y(ns,$z) ò ˜ $1- | û $+(ns,$z,*)
alias -l ò è q $ifmatch *** Netsplit - $y(ns,$z,$1) - $numtok($y(ns,$z,$1),32) user(s) - ( $+ $2 // $3)
alias -l à á - $1 hilight frame $2-5 | á -f $1 shadow face $2-3 $calc($4 -1) $calc($5 -1) | á - $1 frame hilight $calc(1+$2) $calc(1+$3) $calc($4 -2) $calc($5 -2) | drawline -nr @  $rgb($iif($1 == c,face,shadow)) 1 $calc(1+$2) $calc($3 +$5 -2) $calc($2 +$4 -2) $calc($3 +$5 -2) $calc($2 +$4 -2) $3 | if ($6) drawtext -nro @  $rgb(text) arial 18 $calc(2+$2) $calc($3 -4) ×
alias -l â drawtext -nr @  $rgb(text) arial 11 $1-2 $3-
alias -l á drawrect $1nr @  $rgb($iif($2 == c,$3,$4)) 1 $5-
alias -l ã $1 n $2- | %±^e = %±^e $÷(%±q) | %±^t = %±^t $1 | set %±^ $+ $numtok(%±^e,32) $2-
alias -l ‹ Å $1 $6 | if ($1 == r) { if ($5 == !) { set -u %±sz $y(^,$6) | ¬ z } | elseif ($5 == +) set %±^ $+ $6 $calc(($y(^,$6)+1)% 16) | elseif ($6) set %±^ $+ $6 $($ $+ $8- $7,2) | else { if ($5 == ok) { %±n = $numtok(%±^t,32) | while (%±n) { _ $gettok(%±^t,%±n,32) s $y(^,%±n) | dec %±n } } | Ä } } | à $1-4 24 | var %t = $iif($5 == !,!,$iif($6,$y(^,$6),$5)) | if (\ isin %t) if (*\ !iswm %t) %t = $nopath(%t) | if (%t != $null) $iif($5 == +,drawrect -fn @  %t 1 $calc(3+$2) $calc(3+$3) $calc($4 -6) 18,â $calc(($4 -$width(%t,arial,14,0,0))/2+$2+ $iif($1 == c,1)) $calc(5+$3 +$iif($1 == c,1)) %t) | %±q = $2-4 23
alias -l › Å $1 $4 | if ($1 == r) Æ $4 $iif($5 == +,$iif($y(^,$4),0,1),$5) $y(^,$4) | à $1-3 14 14 $iif($5 == +,$y(^,$4),$iif($y(^,$4) == $5,1)) | â $calc(19+$2) $3 $6- | %±q = $2-3 $calc(19+$width($6-,arial,14,0,0)) 17
alias -l Ä window -c @  | .timer±^ off | ý
alias -l Å if ($1 == n) set %±^ $+ $2 $y($2) | if ($1 == s) set %± $+ $2 $y(^,$2)
alias -l Æ set %±^ $+ $1-2 | var %n,%e = 1 | while (%e) { if (* $1 $3 * iswm %e) › o %e | inc %n | %e = $y(^,%n) }
alias -l å %±^h = $Á | À c
alias -l Á var %f = $numtok(%±^e,32) | while (%f) { if ($inrect($mouse.x,$mouse.y, [ $gettok(%±^e,%f,32) ] )) return %f | dec %f }
alias -l À if (%±^h) $gettok(%±^t,%±^h,32) $1 $y(^,%±^h) | drawdot @ 
alias -l Â ã › 20 $1-
alias -l š inc %±uq $+ $z | set $+(%,±uq,$z,$y(uq,$z)) $1- | .raw userhost $3-7 | if ($8) _ š $1-2 $8-
alias -l ƒ Ê host User not found
alias -l Š Ê host $1 is $2 $iif($3 == +,(here),(away))
alias -l ¨ š ª halt $y(nq,$z) | û nq $+ $z
alias -l ª û $+(un,$z,$1) | var %u = $2,%n = $notify($1).note,%a = $gettok(%n,1,32) | if (* isin %a) { %n = $gettok(%n,2-,32) | $iif(%a iswm $2,%u = %a,$iif(%±nh,return,%u = failed check - %u)) } | è notif $iif(%±na,-a,-s) *** $g(notify)  $+ $1 on IRC - %u $g($iif($3 == +,here,away)) %n | set $+(%,±un,$z,$1)  $+ $1 left IRC ( $+ %u $+ ) | ¬ n
alias -l • if (%±rw > 1) ¡ | $iif(%±rw > 1,aline -h,echo) $color(c) $iif(#,-ti2 #,$iif(%±rw > 1,@ctcp,$iif(%±rw,-ati2,-sti2))) $iif(#,$g(#)) $Ã $1-
alias -l ¡ if (!$window(@ctcp)) window -lkz -t14,20,26 @ctcp %±@ctcp | .timer 1 0 window -b @ctcp
alias -l þ ¡ | aline -h @ctcp $+(,$color(c),$g($nick)) PING:	 $Ð($1,	) 	 $+(,$ˆ($1),$Ú,$ˆ($1),$str(,$int($calc($log($calc($1 /200+1))*2.5+1))))
alias -l Ð return $iif($1 > 59999,$int($calc($1 /60000)) min) $2 $round($calc($1 /1000% 60),1) $+ s
alias -l ˆ if ($iif($1 < 5000,%±p<,$iif($1 < 20000,%±p-,%±p>)) isnum) return $ifmatch | return $color(c)
alias -l ‰ Ê retry Nickname %±nr no longer in use, grabbing... | .timer±r $+ $z off | nick %±nr
alias -l ‡ $iif($y(cr,$z),j $ifmatch,.timer±c $+ $z off)
alias -l Ý set %±mw $+ $z $1 | if (%±ww > 1) if (!$window(@whois)) window -ekzi @whois %±@whois | $iif($1,echo $color(wh) -ti $+ $iif(%±ww > 1,2 @whois,$iif(%±ww,a2,s2)) $g($1) $2-,linesep $iif(%±ww > 1,@whois,$iif((%±ww) && (* * !iswm $active),$active,-s)))
alias -l ½ $iif($3,set %± $+ $1 $iif($3 == on,1,0)) | Ê i² $2 is $iif($y($1),on,off) | »
alias -l Þ set %± $+ $1 $window($1).x $window($1).y $window($1).w $window($1).h $1 $window($1).font $iif($window($1).fontbold,bold) $window($1).fontsize
alias -l × if ($Ç($1)) halt
alias -l ” var %l = $address($4,3) | :± | if (!$4) { %l = $$sline(@users,1) | $iif($1,rline,dline) @users $sline(@users,1).ln $puttok(%l,$iif($3,$3,-),$2,9) | %l = $gettok(%l,1,9) } | $iif($3,.) $+ ruser $1 %l | if ($level(%l) == $dlevel) { .ruser %l | if ($3) .auser $dlevel %l } | if ($3) auser -a $1 %l | if (!$4) goto ±
alias -l “ return 	 $+ $iif($1 isin $level(%±l),$2,-)
alias -l ó return $iif(#,#,x)
alias -l É if (%±on) nick %±on | û on
alias -l Ž if ((*.mp? iswm $1) && (%±mp) && (%±md)) { var %m = $findfile(%±md,$1,1) | if (%m) { è o $target *** $g(mp) $g($nick) Playing $nopath(%m) | $iif(%±mi,splay,run -n %±mm) $iif(%±mm,$+(",%m,"),%m) } }
alias -l † { if ($1) %±f2 = $1- | if ($3 == ?) tokenize 32 $1-2 $$u(word(s) or mask to find?,1) | if ($isfile($3-)) %±lm = $3- | elseif (($3) && (%±ld)) { if ((* !isin $3-) && (($findfile(%±ld,$3-,1)) || ($findfile(%±ld,$3- $+ $1,1)))) %±lm = $ifmatch | else { %±m = $+(*,$replace($3-,$chr(32),*),*,$1) | %±r = $findfile(%±ld,%±m,0) | %±lm = $$findfile(%±ld,%±m,$calc(($r(1,%±r)+$ticks)% %±r +1)) } } | else %±lm = $$sfile($+(%±ld,*,$1),$2 to play?) | %±f3 = $2 | $iif(($2 == mp) && (!%±mi),run -n %±mm,splay) $iif(%±mm,$+(",%±lm,"),%±lm) | û c2 | %±x = $replace(%±lm,_,$chr(32))
if (((%±mq) && ($2 == mp)) || ($regex($active,/^@| /))) Ê $2 Playing $nopath(%±x) | else { var %a = $iif(($2 != mp) && ($1),$u(action for $nopath(%±x) $+ ?,2)) | if (!%a) %a = plays $g($nopath(%±x)) - $int($calc($lof(%±lm)/1024)) $+ k - $iif(%±mg,type %±mg to get this file -) $g(i²) | $iif(=* iswm $active,.msg $active SOUND,.c $active SOUND) $replace($nopath(%±lm),$chr(32),?) %a $iif(=* iswm $active,) | è a -a * $me %a } }
alias a away $$u(away reason?,1,0,$1-)
alias b away
alias c ï $1 ctcp $2-
alias d ˜ $ó $÷($1-) dcc chat ˜
alias e ˜ $ó $÷($1-) ä ˜
alias f ˜ $ó $$1 dcc send ˜ $2-
alias h ï $÷($1-) œ h # a ho
alias i ˜ $ó $iif(-* iswm $1,$$2 í $1 ˜ $3,$$1 í ˜ $2)
alias j join $u(channel to join?,1,1,$1) $2-
alias k if ($1 != #$1) tokenize 32 $$chan $1- | if ($2 !isnum) tokenize 32 $1 0 $2- | if (* isin $3) { if ($¿($3,$1,a,-)) _ k $1-2 $ifmatch $4- | return } | if ($4) { if ($2) { û b | û d | ˜ $1 $3 Ö ˜ $1- | œ %±o -o $1 | œ %±b b $1 | if (. isin $2) .timer 1 $gettok($2,2,46) if ($Ò( $1)) œ %±b -b $1 } | ˜ $1 $3 kick $1 ˜ $4- $g(i²) } | else { _ k $1-2 $$3 $iif($mouse.key & 4,$me,$$u(reason?,1)) }
alias l part # $1-
alias m %±ld = %±md | † .mp? mp $1-
alias n $iif(@?* iswm $$1,ö $mid($1,2),ï $1 notice $g($iif($1 == #$1,$1,private))) $$2-
alias o ï $÷($1-) œ o # a o
alias p ping $iif($1,$÷($1-),$active)
alias q ˜ $ó $1 query ˜ $2-
alias r m $iif($1,$1-,*)
alias s sound $iif($1,$1-,$$dir="sound file?" $wavedir*.wav;*.mid $u(action?,3))
alias t topic # $1-
alias v ï $÷($1-) œ v # r -
alias w ï $÷($1-) whois
alias x if ($1 != #$1) tokenize 32 $$chan $1- | if ($2 !isnum) tokenize 32 $1 -1 $2- | var %a = $3 | if (* !isin $3) { if ($address($ñ($3,$1),$iif($2 < 0,3,$2))) %a = $ifmatch | elseif (*!*@* iswm $3) %a = $mask($3,$iif($2 < 0,3,$2)) | elseif (! isin $3) %a = $mask($3@*,$iif($2 < 0,6,$2)) | elseif (@ isin $3) %a = $mask(! $+ $3,$iif($2 < 0,3,$2)) | elseif (. isin $3) %a = $mask(!@ $+ $3,$iif($2 < 0,2,$2)) | else { ban -u $+ $gettok($2,2,46) $1 $3 $iif($2 < 0,3,$2) | return } } | œ %a -o $1 o - | œ %a b $1 | k $1 %a $iif($4,$4-,banned) | if (. isin $2) .timer 1 $gettok($2,2,46) if ($Ò( $1)) œ %a -b $1
alias @ ö $iif($$1 != #$1,#) $1-
alias cf1 run $scriptdiri2.txt
alias f2 if (%±ld) † %±f2
alias cf2 if (%±c2) { splay $+(",%±lm,") %±c2 | û c2 } | else { %±c2 = $insong.pos | splay stop }
alias f3 if ($isfile(%±lm)) † 0 %±f3 %±lm
alias cf3 if ($isfile(%±lm)) if ($input(Kill $nopath(%±lm) $+ ?)) $iif($isdir(kill),rename $+(",%±lm," "kill\,$nopath(%±lm),"),remove -b $+(",%±lm,"))
alias f4 ê n %±ln
alias f5 p
alias f6 d $1- | close -m $1
alias f7 %±f7
alias f8 ê run %±lf
alias cf8 ê run $nofile(%±lf)
alias f9 ê t $chan(#).topic
alias f10 ê server $µ(1)
alias cf10 if ($ú) j $ú
alias f11 a
alias cf11 .a
alias f12 b
alias cf12 .b
alias ctcp if ($$2 == ping) { .msg $1 PING $+(0,$ticks,) | è c -aq -> [ $+ $1] PING } | else ctcp $1-
alias ping c $1 ping
alias wav %±ld = $wavedir | † .wav wav $1-
alias mid %±ld = $mididir | † .mid midi $1-
alias scan window -c @scan | if ($1 !ischan) tokenize 32 $$chan $1 | var %f = 0,%t = 0,%n = 1,%a,%c,%k | :± | %a = $iif($2,$2,$mask($ialchan(*,$1,%n),2)) | if (%a) { if (($2) || (($ialchan(%a,$1,0) > 1) && ($ialchan(*,$1,%n).nick == $ialchan(%a,$1,1).nick))) { if ($line(@scan,0)) aline @scan 	 | %c = 1 | inc %f | :2 | %k = $ialchan(%a,$1,%c).nick | if (%k) { if (!$window(@scan)) window -lkvz -t17,24,35 @scan $iif(%±@scan,%±@scan,@scan) | aline @scan %a 	 %c 	 %k 	 $ialchan(%a,$1,%c).addr | inc %c | inc %t | goto 2 } } | inc %n | if (%a != $2) goto ± } | $iif(%t,titlebar @scan $1 - %t $iif($2,user(s),clones) found $iif(!$2,at %f site(s)),Ê scan No $iif($2,user(s),clones) detected on $1)
alias dns if (($regex($1,/^[^-]/)) && ($show)) { linesep -a | Ê dns Looking up $iif(. !isin $1,address of) $1 | .dns $1 } | else dns $1-
alias userhost if ($show) { Ê host Looking up $1- | š Š ƒ $1- } | else š return return $1-
alias retry if ($1) { if ($server) { if (#$1 == $1) { set %±cr $+ $z $addtok($y(cr,$z),$1,44) | .timer±c $+ $z 0 30 ‡ | Ê retry Channel $1 being retried. } | else { set %±nr $+ $z $1 | .timer±r $+ $z 0 30 š halt ‰ $1 | Ê retry Nickname $1 being retried. } } } | else { .timer±r $+ $z off | û cr $+ $z | Ê retry All nickname/channel retries halted. }
alias away if ($1) { ® is now away - $1- $iif(%±pg,- pager on) $iif(%±ml,- messages logged) - $g(i²) | if (%±an) { %±on = $me | nick %±an } | %±at = $ctime | %±aw = $1- | » } | elseif (%±aw) { dqwindow $iif($line(message window,0),show,hide) | %±g = $duration($calc($ctime -%±at)) | ® is back from - %±aw - gone %±g - $g(i²) | É | if ($server) away | û aw | « | resetidle }
alias pager ½ pg pager $1
alias mlog ½ ml msglog $1
alias ports window -c @ports | stats l
alias user window -c @users | window -slkz -t25,35 @users $iif(%±@users,%±@users,@users) | %±n = 1 | :± | %±l = $$ulist(*,%±n) | aline @users %±l $“(±i,immune) $“(±b,exiled) | inc %±n | goto ±
alias cfg { û ^* | window -fpkBdw0 +fLt @  $int($calc($window(-3).w /2-160)) $int($calc($window(-3).h /2-123)) 320 245 @  | á -f c face - 0 0 320 245 | .timer±^ -mio 0 99 if ($active != @ ) Ä | %±> = $1 $+ ~ | goto %±> | :p~ | â 10 5 Channel protection- | â 20 35 Tempban on | â 145 35 CTCPs in | â 260 35 seconds | â 20 65 Kick on | â 145 65 text lines in | â 260 65 seconds | â 20 185 Ban repeat offender within these seconds | â 20 95 Bankick on | â 145 95 clones total | ã ‹ 85 30 55 - ck ctcps?,3) u(number of | ã ‹ 200 30 55 - cs seconds,3) u(number of | ã ‹ 85 60 55 - tk lines?,3) u(number of text | ã ‹ 200 60 55 - ts seconds?,3) u(number of | ã ‹ 85 90 55 - mc clones,3) u(number of
  ã ‹ 230 180 55 - ro seconds?,3) u(number of | â 20 125 Word kicks | ã ‹ 85 120 225 - wk words/patterns?,3) u(kick on what | â 20 155 Channels | ã ‹ 85 150 225 - pc channels?,3) u(protect which | goto ± | :m~ | â 10 5 MP2 and MP3- | â 20 40 MP player | â 20 70 MP directory | â 20 100 Leech command | ã ‹ 99 35 192 - mm *.exe dir="mp player?" | ã ‹ 99 65 192 - md directory?" sdir="mp | ã ‹ 220 95 71 - mg command?,3) u(leech | Â 130 mq + Only play locally | Â 150 mp + Play MPs from others | Â 170 mi + Use mIRC internal player | goto ± | :a~ | â 10 5 Away system- | â 39 30 Autoaway after this many minutes | ã ‹ 230 25 75 - aa minutes?,3) u(number of | Â 50 aq + Quiet autoaway / back on keypress | Â 70 pg + Pager on | Â 90 ml + Message log | â 39 115 Pager sound | ã ‹ 126 110 165 - sp *.wav dir="pager sound?" | ã ‹ 293 110 16 ! sp | â 39 150 Away nickname | ã ‹ 126 145 165 - an nickname?,3) u(away | goto ± | :s~
  â 10 5 $iif($2,User,System) sounds- | var %p = 175,%n = 7 | while (%n) { ã ‹ 99 %p 192 - s $+ $mid($iif($2,nqhfrse,ctjlodk),%n,1) *.wav dir="sound?" | ã ‹ 293 %p 16 ! s $+ $mid($iif($2,nqhfrse,ctjlodk),%n,1) | â 20 $calc(5+%p) $gettok($iif($2,NotifyNew queryDCC chatIncoming fileFile receivedFile sentFile error,ConnectDisconnectYou joinYou partYou oppedYou deoppedUser kicked),%n,2) | dec %n | dec %p 25 } | goto ± | :c~ | â 200 25 Low lag color | ã ‹ 200 48 80 + p< | â 200 85 Medium lag color | ã ‹ 200 108 80 + p- | â 200 145 High lag color | ã ‹ 200 168 80 + p> | :d~ | â 10 5 $iif($1 == c,CTCP,Display) config- | Â 25 $iif($1 == c,cw 0 CTCPs,ww 0 Whois) in status | Â 42 $iif($1 == c,cw 1 CTCPs,ww 1 Whois) in active | Â 59 $iif($1 == c,cw 2 Separate CTCP,ww 2 Separate Whois) window | Â 85 $iif($1 == c,pw 0 Pings,nm 0 Names on join) in status
Â 102 $iif($1 == c,pw 1 Pings in active,nm 1 Names on join in channel) | Â 119 $iif($1 == c,pw 2 Separate ping window,nm 2 Hide names on join) | Â 145 $iif($1 == c,rw 0 CTCP replies in status,no + Perform notify address checks) | Â 162 $iif($1 == c,rw 1 CTCP replies in active,na + Notify in active) | Â 179 $iif($1 == c,rw 2 Separate CTCP reply window,nh + Hide if failed address check) | goto ± | :%±> | â 10 5 Misc. config- | â 39 30 Nick completion on these characters | ã ‹ 230 25 55 - nc characters?,3) u(nick completion | Â 50 cc + Use nick completion in commands | Â 70 hl + Show highlighted lines in active | Â 92 cn + Show channel/op notices in dqwindow | Â 109 pn + Show private notices in dqwindow | Â 126 dm + Minimize dqwindow when opened | Â 150 fq + Flash on new query | Â 167 fp + Flash on private message | Â 184 fd + Flash on DCC message | :± | ã ‹ 20 210 90 OK | ã ‹ 185 210 90 Cancel | À }
