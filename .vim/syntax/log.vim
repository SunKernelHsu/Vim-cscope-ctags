""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax file for *.log
" Language:         Generic log files for android (include kernel and logcat)
" Maintainer:       Wang Fair  hardmemory@gmail.com
" Latest Revision:  Version 1.3 @2017-07-28 
" Changes:          2017-07-27 Initial version
" Support:          syntax file for highlighting kernel,logcat,bugreport and so on
" reference:        vim-log-syntax Alex Dzyoba <avd@reduct.ru>
" reference:        vim-logcat thinca <thinca+vim@gmail.com>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("b:current_syntax")
  finish
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""The Error and Warning
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn match   log_error 	'\c.*\<\(FATAL\|ERROR\|ERRORS\|FAIL\|FAILED\|FAILURE\).*'                  contains=@logItem,log_string,log_number,log_date,log_time,log_process,log_tag,log_comment,log_label
syn match   log_warning '\c.*\<\(WARNING\|DELETE\|DELETING\|DELETED\|RETRY\|RETRYING\).*'          contains=@logItem,log_string,log_number,log_date,log_time,log_process,log_tag,log_comment,log_label

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""For logcat log
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:cpo_save = &cpo
set cpo&vim

let s:levels = [
\   'Verbose',
\   'Debug',
\   'Info',
\   'Warning',
\   'Error',
\   'Fatal',
\ ]

function! s:define_color()
  if &background is 'dark'
    highlight default logcatLevelVerbose guifg=Gray   ctermfg=Gray
    highlight default logcatLevelDebug   guifg=Cyan   ctermfg=Cyan
    highlight default logcatLevelInfo    guifg=Green  ctermfg=Green
    highlight default logcatLevelWarning guifg=Yellow ctermfg=Yellow
    highlight default logcatLevelError   guifg=Red    ctermfg=Red
  else
    highlight default logcatLevelVerbose guifg=DarkGray   ctermfg=DarkGray
    highlight default logcatLevelDebug   guifg=DarkCyan   ctermfg=DarkCyan
    highlight default logcatLevelInfo    guifg=DarkGreen  ctermfg=DarkGreen
    highlight default logcatLevelWarning guifg=DarkYellow ctermfg=DarkYellow
    highlight default logcatLevelError   guifg=DarkRed    ctermfg=DarkRed
  endif
  highlight default logcatLevelFatal guifg=White ctermfg=White guibg=Red ctermbg=Red
endfunction

call s:define_color()
"augroup syntax-logcat
"  autocmd! ColorScheme * call s:define_color()
"augroup END

function! s:define_level(pattern)
  for level in s:levels
    execute printf('syntax match logcatLevel%s @%s@ contains=@logcatItem',
    \              level, printf(a:pattern, level[0]))
  endfor
endfunction

syntax match logcatTime /\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d/ contained skipwhite nextgroup=@logcatTimeNext
syntax match logcatProcess /([0-9 ]\{5}\%(:0x\x\+\)\?)/ contained

syntax cluster logcatItem add=logcatTag

call s:define_level('^\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d\s\+\d\+\s\+\d\+ %s .*$')
syntax cluster logcatItem add=logcatLineHead
syntax cluster logcatTimeNext add=logcatProcess
syntax match logcatLineHead /^/ contained nextgroup=logcatTime
syntax match logcatProcess /\s\+\d\+\s\+\d\+/ contained skipwhite nextgroup=logcatTag
syntax match logcatTag '\<[VDIWEF] [^:]\+:'ms=s+2,me=e-1 contained

highlight default link logcatTag Tag
highlight default link logcatTime Label
highlight default link logcatProcess Number

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""For kernel log
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"#define KERN_EMERG      "<0>"    /* system is unusable */   
"#define KERN_ALERT      "<1>"    /* action must be taken immediately */   
"#define KERN_CRIT       "<2>"    /* critical conditions */   
"#define KERN_ERR        "<3>"    /* error conditions */   
"#define KERN_WARNING    "<4>"    /* warning conditions */   
"#define KERN_NOTICE     "<5>"    /* normal but significant */   
"#define KERN_INFO       "<6>"    /* informational */   
"#define KERN_DEBUG      "<7>"    /* debug-level messages */  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:define_color1()
  if &background is 'dark'
    highlight default logLevelDebug   guifg=Cyan   ctermfg=Cyan
    highlight default logLevelInfo    guifg=Green  ctermfg=Green
    highlight default logLevelNOTICE  guifg=Blue   ctermfg=Blue
    highlight default logLevelWarning guifg=Yellow ctermfg=Yellow
    highlight default logLevelError   guifg=Red    ctermfg=Red
  else
    highlight default logLevelDebug   guifg=DarkCyan   ctermfg=DarkCyan
    highlight default logLevelInfo    guifg=DarkGreen  ctermfg=DarkGreen
    highlight default logLevelNOTICE  guifg=DarkBlue   ctermfg=DarkBlue
    highlight default logLevelWarning guifg=DarkYellow ctermfg=DarkYellow
    highlight default logLevelError   guifg=DarkRed    ctermfg=DarkRed
  endif
  highlight default logLevelFatal guifg=White ctermfg=White guibg=Red ctermbg=Red
endfunction

call s:define_color1()
augroup syntax-log
  autocmd! ColorScheme * call s:define_color1()
augroup END

syntax match logLevelFatal   '^<0>.*$' contains=@logItem,log_string,log_number,log_date,log_time,log_process,log_tag,log_comment,log_label
syntax match logLevelFatal   '^<1>.*$' contains=@logItem,log_string,log_number,log_date,log_time,log_process,log_tag,log_comment,log_label
syntax match logLevelFatal   '^<2>.*$' contains=@logItem,log_string,log_number,log_date,log_time,log_process,log_tag,log_comment,log_label
syntax match logLevelError   '^<3>.*$' contains=@logItem,log_string,log_number,log_date,log_time,log_process,log_tag,log_comment,log_label
syntax match logLevelWarning '^<4>.*$' contains=@logItem,log_string,log_number,log_date,log_time,log_process,log_tag,log_comment,log_label
syntax match logLevelNOTICE  '^<5>.*$' contains=@logItem,log_string,log_number,log_date,log_time,log_process,log_tag,log_comment,log_label
syntax match logLevelInfo    '^<6>.*$' contains=@logItem,log_string,log_number,log_date,log_time,log_process,log_tag,log_comment,log_label
syntax match logLevelDebug   '^<7>.*$' contains=@logItem,log_string,log_number,log_date,log_time,log_process,log_tag,log_comment,log_label

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" The Importent information
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"SYSTEM ANR
syn match log_info 	'\c.*\<\(am_anr\|ANR in \|Reason: keyDispatchingTimedOut\|Reason: Broadcast of Intent\|Reason: executing service\|Reason: Input dispatching timed out\|Timeout of broadcast\).*'  contains=@logItem,log_string,log_number,log_date,log_time,log_process,log_tag,log_comment,log_label

"Kill
syn match   log_info  '\c.*\<\(Killing\|am_kill\).*'   contains=@logItem,log_string,log_number,log_date,log_time,log_process,log_tag,log_comment,log_label

"AVC denied
syn match   log_info  '\c.*\<\(avc: denied\).*'   contains=@logItem,log_string,log_number,log_date,log_time,log_process,log_tag,log_comment,log_label

hi def link log_info  logcatLevelWarning

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""" The Critical error
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"KERNEL Critical 
syn match log_critical 	'\c.*\<\(Watchdog bark\|BUG: soft lockup\|Kernel panic\|Oops\|NULL pointer dereference\|Unable to handle kernel paging\|unhandled page fault\|kernel BUG at\).*'  contains=@logItem,log_time

"KERNEL MODEM
syn match log_critical 	'\c.*\<\(ARM9 has CRASHED\|ARM9 HAS CRASHED\|Watchdog bite received from modem\|SMSM: Modem SMSM state changed to SMSM_RESET\|Error in file\).*'  contains=@logItem,log_time

"KERNEL SUB
syn match log_critical 	'\c.*\<\(not syncing: Subsystems have crashed\|subsys-restart: subsystem_shutdown\|GSS SMSM state changed to SMSM_RESET\|riva: smsm state changed to smsm reset\|LPASS SMSM state changed to SMSM_RESET\|apr_tal:open timeout\|APR: Unable to open handle\).*'  contains=@logItem,log_time

"KERNEL SUB Watchdog
syn match log_critical 	'\c.*\<\(Watchdog bite received from Riva\|Watchdog bite received from GSS\|Watchdog bite received from Q6\|Watchdog bite received from lpass Q6\|Watchdog bite received from ADSP\).*'  contains=@logItem,log_time

"KERNEL USER
syn match log_critical 	'\c.*\<\(Trigger a crash\|Trigger a forced crash\|SysRq : Show Blocked State\|Force crash triggered\).*'  contains=@logItem,log_time

"KERNEL RESART
syn match log_critical 	'\c.*\<\(Restarting system with command\).*'  contains=@logItem,log_time

"KERNEL REBOOT & Power OFF
syn match log_critical 	'\c.*\<\(Rebooting in\|Going down for restart\|power off\).*'  contains=@logItem,log_time

"KERNEL NATIVE
syn match log_critical 	'\c.*\<\(Native crash-info:\).*'  contains=@logItem,log_time

"MAIN LOG
syn match log_critical 	'\c.*\<\(uncaught exception\|IOException\|VM aborting\|Out of memory on a\|Systemdump initiated\|Watchdog detected a hang\).*'  contains=@logItem,log_time

"MAIN MEMORY
syn match log_critical 	'\c.*\<\(signal 6 .SIGABRT\|signal 4 .SIGILL\|signal 11 .SIGSEGV\|signal 7 .SIGBUS\|signal 16.SIGSTKFLT\).*'  contains=@logItem,log_time

"SYSTEM SWWD
syn match log_critical 	'\c.*\<\(WATCHDOG KILLING\).*'  contains=@logItem,log_time

"SYSTEM FATAL
syn match log_critical 	'\c.*\<\(FATAL EXCEPTION\).*'  contains=@logItem,log_time

"SYSTEM USER
syn match log_critical 	'\c.*\<\(Force Crash by PWR KEY\).*'  contains=@logItem,log_time

hi def link log_critical  logcatLevelFatal

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""The Generic Keyword for generic log
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syn region  log_string 	start=/'/ end=/'/ end=/$/ skip=/\\./
syn region  log_string 	start=/"/ end=/"/ skip=/\\./

syn match   log_number 	'0x[0-9a-fA-F]*\|0X[0-9a-fA-F]*'
syn match   log_number 	'\s[0-9a-fA-F]\{4}\s\|\s[0-9a-fA-F]\{8}\s\|\s[0-9a-fA-F]\{16}\s'

syn match   log_date '\(Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\) [ 0-9]\d *'
syn match   log_date '\d\{4}-\d\d-\d\d'

"syn match   log_time '\d\d:\d\d:\d\d\s*'
"syn match   log_time '\c\d\d:\d\d:\d\d\(\.\d\+\)\=\([+-]\d\d:\d\d\|Z\)'
syn match   log_time '\[ *[0-9]\d*\.\d*\]'

syn match   log_process '([0-9 ]\{5}\%(:0x\x\+\)\?)'
syn match   log_tag ' [_A-Za-z][_A-Za-z0-9]*:'

syn match   log_comment '---*\|===*\|###*'
syn match   log_label '\*\*.*\*\*'

hi def link log_error 		logLevelError
hi def link log_warning 	logLevelWarning
hi def link log_string 		String
hi def link log_number 		Number
hi def link log_date 		Constant
hi def link log_time 		Type
hi def link log_process 	Number       
hi def link log_tag 	        Function
hi def link log_comment 	Comment
hi def link log_label 	        Label          

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let b:current_syntax = "log"

let &cpo = s:cpo_save
unlet s:cpo_save

finish
