#!/bin/sh

#  keyMapping.sh
#  Box42
#
#  Created by Chanhee Kim on 8/13/23.
#

mac_old=(0 0xff00000005 0xff00000004 0xff0100000010 0xff010004 0xff00000009 0xff00000008 0xc000000b4 0xc000000cd 0xc000000b3 0xc000000e2 0xc000000ea 0xc000000e9)
mac_new=(0 0xff00000005 0xff00000004 0xff0100000010 0xc00000221 0xc000000cf 0x10000009b 0xc000000b4 0xc000000cd 0xc000000b3 0xc000000e2 0xc000000ea 0xc000000e9)

this_mac=(${mac_new[@]})  # change based on "old" or "new" mac / magic keyboard layout

fn_keys=(0 0x70000003a 0x70000003b 0x70000003c 0x70000003d 0x70000003e 0x70000003f 0x700000040 0x700000041 0x700000042 0x700000043 0x700000044 0x700000045 0x700000068 0x700000069 0x70000006a 0x70000006b 0x70000006c 0x70000006d 0x70000006e)
fn_bri_dec=0xff0100000021 # or 0xc00000070
fn_bri_inc=0xff0100000020 # or 0xc0000006f
fn_missionc=0xff0100000010
fn_spotl=0xff0100000001   # or 0xc00000221
fn_dict=0xc000000cf
fn_dnd=0x10000009b
fn_rew=0xc000000b4
fn_play=0xc000000cd
fn_fwd=0xc000000b3
fn_mute=0xc000000e2
fn_vol_inc=0xc000000ea
fn_vol_dec=0xc000000e9
fn_kbd_inc=0xff00000008
fn_kbd_dec=0xff00000009
fn_launchp=0xff0100000004
fn_globe=0xff0100000030
fn_desktop=0x700000044 # or f11
fn_num_div=0x700000054
fn_num_mul=0x700000055
fn_num_sub=0x700000056
fn_num_add=0x700000057
fn_num_enter=0x700000058
fn_num1=0x700000059
fn_num2=0x70000005a
fn_num3=0x70000005b
fn_num4=0x70000005c
fn_num5=0x70000005d
fn_num6=0x70000005e
fn_num7=0x70000005f
fn_num8=0x700000060
fn_num9=0x700000061
fn_num0=0x700000062
fn_num_dot=0x700000063
fn_num_equ=0x700000067

function help() {
  echo "$LESS_TERMCAP_mb$0 $LESS_TERMCAP_md[command]$LESS_TERMCAP_me
  where $LESS_TERMCAP_md[command]$LESS_TERMCAP_me is one of:
    show      display the current user key map
    export    output the current user key map for creating a LaunchAgent
    reset     reset user key map to default
    default   display the default key map (from ioreg)
$LESS_TERMCAP_mb$0 $LESS_TERMCAP_md[n=keycode ...]$LESS_TERMCAP_me
  where ${LESS_TERMCAP_us}n$LESS_TERMCAP_ue is 1 to 12 for thefunction key, and
    ${LESS_TERMCAP_us}keycode$LESS_TERMCAP_ue is a hex key code starting with 0x
$LESS_TERMCAP_mb$0 $LESS_TERMCAP_md[n=function ...]$LESS_TERMCAP_me
  where ${LESS_TERMCAP_us}n$LESS_TERMCAP_ue is 1 to 12 for the function key, and
    ${LESS_TERMCAP_us}function$LESS_TERMCAP_ue is one of:
      bri_dec | bri_inc   decrease / increase display brightness
      kbd_dec | kbd_inc   decrease / increase keyboard backlight brightness
      missionc | launchp  show mission control / launchpad
      spotl | dict        spotlight search / dictation (hold for Siri)
      dnd | mute          toggle do not disturb / mute
      rew | play | fwd    rewind / play or pause / fast-forward media
      vol_dec | vol_inc   decrease / increase volume
      globe | desktop     show emoji / desktop (same as F11)
      num0 to num9        number pad keys, along with:
      num_add | num_sub | num_mul | num_div | num_dot | num_equ | num_enter
"
}
function show() {
  echo Current user key map
  hidutil property -g UserKeyMapping
}
function reset() {
  echo Reset user key map
  hidutil property -s "{\"UserKeyMapping\":[]}" >/dev/null
}
function default() {
  echo Show default key map
  ioreg -l | grep -o "\"FnFunctionUsageMap\" = .*"
}
function export() {
  x=$(hidutil property -g UserKeyMapping | sed -E "s/(HIDKeyboardModifierMappingDst) = (.*);/\"\1\": \2,/g;s/(HIDKeyboardModifierMappingSrc) = (.*);/\"\1\": \2/g;s/\(/[/;s/\)/]/")
  echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.local.KeyRemapping</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/hidutil</string>
        <string>property</string>
        <string>--set</string>
        <string>{"UserKeyMapping":'"$x"'
        }</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>'
}
function map() {
  y=""
  for x in "$@"; do
    x=(${x//=/ })
    x0=${x[0]}
    x1=${x[1]}
    if [[ ${#x[@]} -eq 2 && ( $x0 == [1-9] ||  $x0 == 1[012]) ]]; then
      fn=${this_mac[$x0]}
      [[ "$fn" == "" ]] && echo "Error no such key F$x0" && exit -1
      if [[ "$x1" == f[1-9] || "$x1" == f1[0-9] ]]; then
        kc=${x1:1}
        kc=${fn_keys[$kc]}
        [[ "$kc" == "" ]] && echo "Error mapping F$x0 [$fn] to unknown $x1" && exit -1
        echo "Mapping F$x0 [$fn] to HID $x1 [$kc]"
        y="{\"HIDKeyboardModifierMappingSrc\":$fn,\"HIDKeyboardModifierMappingDst\":$kc},$y"
      elif [[ "$kc" == 0x[0-9A-Fa-f]* && ( ${#kc} -ge 11 && ${#kc} -le 14 ) ]]; then
        echo "Mapping F$x0 [$fn] to HID hex code [$kc]"
        y="{\"HIDKeyboardModifierMappingSrc\":$fn,\"HIDKeyboardModifierMappingDst\":$kc},$y"
      else
        kc=fn_$x1
        kc=${!kc}
        [[ "$kc" == "" ]] && echo "Error mapping F$x0 [$fn] to unknown $x1" && exit -1
        echo "Mapping F$x0 [$fn] to HID $x1 [$kc]"
        y="{\"HIDKeyboardModifierMappingSrc\":$fn,\"HIDKeyboardModifierMappingDst\":$kc},$y"
      fi
    fi
    hidutil property -s "{\"UserKeyMapping\":[${y%?}]}" >/dev/null
  done
}
function kbd() {
  map 4=kbd_dec 5=kbd_inc
}
if [[ ${#@} -eq 1 && "$1" != *=* ]]; then
  [[ $(LC_ALL=C type -t "$1") == "function" && "$1" != "map" ]] && $1 && exit $?
elif [[ ${#@} -ge 1 ]]; then
  map "$@"
  exit $?
fi
help
