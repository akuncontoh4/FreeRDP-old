#!/usr/bin/perl

# rdesktop: A Remote Desktop Protocol client.
# User interface services - XKB Configuration Files Exporter

# Copyright (C) Marc-Andre Moreau <marcandre.moreau@gmail.com> 2009

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

# Description:
# Script to export XKB configuration files to keycode -> virtual key code keymaps that are
# easy to use in rdesktop. This makes keymap maintenance easier to make as all bugs can
# simply be reported to the XKB Configuration Database project, and then this script can
# be used to export newer (and fixed) version of the XKB Configuration Database.

use Cwd;

my %sym2virt = (
	"AE00" => "VK_TILDE",
	"AE01" => "VK_KEY_1",
        "AE02" => "VK_KEY_2",
        "AE03" => "VK_KEY_3",
        "AE04" => "VK_KEY_4",
        "AE05" => "VK_KEY_5",
        "AE06" => "VK_KEY_6",
        "AE07" => "VK_KEY_7",
        "AE08" => "VK_KEY_8",
        "AE09" => "VK_KEY_9",
        "AE10" => "VK_KEY_0",
        "AE11" => "VK_OEM_MINUS",
        "AE12" => "VK_OEM_PLUS",

        "AD01" => "VK_KEY_Q",
        "AD02" => "VK_KEY_W",
        "AD03" => "VK_KEY_E",
        "AD04" => "VK_KEY_R",
        "AD05" => "VK_KEY_T",
        "AD06" => "VK_KEY_Y",
        "AD07" => "VK_KEY_U",
        "AD08" => "VK_KEY_I",
        "AD09" => "VK_KEY_O",
        "AD10" => "VK_KEY_P",
        "AD11" => "VK_OEM_4",
        "AD12" => "VK_OEM_6",

        "AC01" => "VK_KEY_A",
        "AC02" => "VK_KEY_S",
        "AC03" => "VK_KEY_D",
        "AC04" => "VK_KEY_F",
        "AC05" => "VK_KEY_G",
        "AC06" => "VK_KEY_H",
        "AC07" => "VK_KEY_J",
        "AC08" => "VK_KEY_K",
        "AC09" => "VK_KEY_L",
        "AC10" => "VK_OEM_1",
        "AC11" => "VK_OEM_7",
        "AC12" => "VK_OEM_5",

        "AB00" => "VK_LSHIFT",
        "AB01" => "VK_KEY_Z",
        "AB02" => "VK_KEY_X",
        "AB03" => "VK_KEY_C",
        "AB04" => "VK_KEY_V",
        "AB05" => "VK_KEY_B",
        "AB06" => "VK_KEY_N",
        "AB07" => "VK_KEY_M",
        "AB08" => "VK_OEM_COMMA",
        "AB09" => "VK_OEM_PERIOD",
        "AB10" => "VK_OEM_2",
        "AB11" => "VK_RSHIFT",

        "FK01" => "VK_F1",
        "FK02" => "VK_F2",
        "FK03" => "VK_F3",
        "FK04" => "VK_F4",
        "FK05" => "VK_F5",
        "FK06" => "VK_F6",
        "FK07" => "VK_F7",
        "FK08" => "VK_F8",
        "FK09" => "VK_F9",
        "FK10" => "VK_F10",
        "FK11" => "VK_F11",
        "FK12" => "VK_F12",
        "FK13" => "VK_F13",
        "FK14" => "VK_F14",
        "FK15" => "VK_F15",
        "FK16" => "VK_F16",
        "FK17" => "VK_F17",
        "FK18" => "VK_F18",
        "FK19" => "VK_F19",
        "FK20" => "VK_F20",
        "FK21" => "VK_F21",
        "FK22" => "VK_F22",
        "FK23" => "VK_F23",
        "FK24" => "VK_F24",

        "KP0" => "VK_NUMPAD0",
        "KP1" => "VK_NUMPAD1",
        "KP2" => "VK_NUMPAD2",
        "KP3" => "VK_NUMPAD3",
        "KP4" => "VK_NUMPAD4",
        "KP5" => "VK_NUMPAD5",
        "KP6" => "VK_NUMPAD6",
        "KP7" => "VK_NUMPAD7",
        "KP8" => "VK_NUMPAD8",
        "KP9" => "VK_NUMPAD9",

        "KPDV" => "VK_DIVIDE",
        "KPMU" => "VK_MULTIPLY",
        "KPSU" => "VK_SUBTRACT",
        "KPAD" => "VK_ADD",
        "KPDL" => "VK_DECIMAL",
        "KPEN" => "VK_RETURN",

        "RTRN" => "VK_RETURN",
        "SPCE" => "VK_SPACE",
        "BKSP" => "VK_BACK",
        "BKSL" => "VK_OEM_5",
	"LSGT" => "VK_OEM_5",
        "ESC" => "VK_ESCAPE",
        "TLDE" => "VK_OEM_3",
        "CAPS" => "VK_CAPITAL",
        "TAB" => "VK_TAB",
        "LFSH" => "VK_LSHIFT",
        "RTSH" => "VK_RSHIFT",
        "LCTL" => "VK_LCONTROL",
        "RCTL" => "VK_RCONTROL",
        "LWIN" => "VK_LWIN",
        "RWIN" => "VK_RWIN",
        "LALT" => "VK_MENU",
        "RALT" => "VK_MENU",
        "MENU" => "VK_APPS",
        "UP" => "VK_UP",
        "DOWN" => "VK_DOWN",
        "LEFT" => "VK_LEFT",
        "RGHT" => "VK_RIGHT",
        "INS" => "VK_INSERT",
        "DELE" => "VK_DELETE",
        "PGUP" => "VK_PRIOR",
        "PGDN" => "VK_NEXT",
        "HOME" => "VK_HOME",
        "END" => "VK_END",
        "PAUS" => "VK_PAUSE",
        "NMLK" => "VK_NUMLOCK",
        "SCLK" => "VK_SCROLL",

	# This page helps understanding the keys that follow:
	# http://www.stanford.edu/class/cs140/projects/pintos/specs/kbd/scancodes-7.html
 
	"KANJ" => "VK_KANJI",
	"HANJ" => "VK_HANJA",
	"MUHE" => "VK_NONCONVERT",
	"HIRA" => "VK_KANA",
	"PRSC" => "VK_SNAPSHOT",

	"KPF1" => "VK_NUMLOCK",
	"KPF2" => "VK_DIVIDE",
	"KPF3" => "VK_MULTIPLY",
	"KPF4" => "VK_SUBTRACT",
	"KPCO" => "VK_ADD",

        "HELP" => "VK_HELP",
        "SELE" => "VK_SELECT",

	# We can ignore LDM (Lock Down Modifier)
	# What are LCMP/RCMP?
	# DO, FIND?

);

my $inDir;
my $outDir;

if(@ARGV < 1) {
	$inDir = getcwd() . "/";
	$outDir = $inDir . "xkb/";
} elsif(@ARGV == 1) {
	$inDir = $ARGV[0];
	$outDir = $inDir . "xkb/";
} elsif(@ARGV == 2) {
	$inDir = $ARGV[0];
	$outDir = $ARGV[1] . "xkb/";
} else {
	print 	"Error: Too many arguments\n" .
		"Usage:\n" .
		"perl xkb.pl <XKB Directory>\n" .
		"perl xkb.pl <XKB Directory> <Output Directory>\n\n" .
		"In Linux, the XKB directory usually is /usr/share/X11/xkb/\n" .
		"The latest version of XKB can always be downloaded at:\n" .
		"http://freedesktop.org/wiki/Software/XKeyboardConfig\n";
		exit 0;
}



open("SPEC", $inDir . "xkeyboard-config.spec");

$xkbVersion = "";
while($line = <SPEC>) {
	if($line =~ m/Version:\s+(.\..)/) {
		$xkbVersion = "version $1";
	}
}

# Create directory if it does not exists
if(not -e $outDir) {
	mkdir $outDir or die("Error: Can't create directory $outDir\n");
}

open("KCD", $inDir . "keycodes/keycodes.dir") or die("Error: Can't open $inDir" . "keycodes/keycodes.dir\n");

$previousFile = "";
while($line = <KCD>) {
	if($line =~ m/........ -------- (.+)\((.+)\)/) {
		if($1 ne $previousFile) {
			push(@keymapFiles, $1);
			$previousFile = $1;
		}
	}	
}
close("KCD");

foreach $keymapFile (@keymapFiles) {

		print "File $keymapFile:\n";

		@directories = split(/\//, $keymapFile);
		splice(@directories, @directories - 1, 1); 

		if(@directories > 0) {
			$directory = $outDir;		
			for($i = 0; $i < @directories; $i++) {
				$directory .= $directories[$i] . "/";
				if(not -e $directory) {
					mkdir $directory or die("Can't create directory $directory\n");				
				}			
			}
		}

		open("IN", $inDir . "keycodes/" . $keymapFile);
		open("OUT", ">" . "$outDir" . $keymapFile);

		$time = localtime();
		print OUT "# This file was generated with xkb.pl ($time)\n";
		print OUT "# and is based on the X Keyboard Configuration Database $xkbVersion\n";
		print OUT "# Please use xkb.pl to re-export newer versions of XKB\n";
		print OUT "\n\n";

		while($line = <IN>) {
			if($line =~ m/xkb_keycodes \"(\w+)\"/) {

				print "Exporting \"$1\"\n";
				print OUT "keyboard \"$1\"";


				while($line = <IN>) {
					if($line =~ m/include\W+\"(.+)\"/) {
						print OUT "\n: extends \"$1\"";
						last;
					} else {
						last;
					}
				}
				print OUT "\n{\n";		

				while($line = <IN>) {
					if($line =~ m/<(\w{1,4})>\W+=\W+(\w+);/) {
						if($sym2virt{$1} ne undef) {
							$vkcode = $sym2virt{$1};
							print OUT "\t$vkcode";

							if(length($vkcode) < 8) {
								print OUT "\t";
							}
							print OUT "\t<$2>\n";
						} else {
							# If undef, then this symbolic key code is
							# missing from the sym2virt hash table
							# print "\t$1\t$2\n";
						}
					} elsif($line =~ m/};/) {
						print OUT "};\n\n";
						last;
					}
				}
			}
		}

		close("IN");
		close("OUT");
}

