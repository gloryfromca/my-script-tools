#!/usr/bin/expect -f

# disable stdout before interact.
log_user 0

set timeout 30
set node [lindex $argv 0]
set prefix "jumpserver login"
if {$node eq ""} {
   set node "data"
}
set mfa [exec python -c "import pyotp; totp = pyotp.TOTP('XXXXXX');print(totp.now())"]

spawn ssh XXX.XXX@jumpserver.XXX.com

send_user "$prefix: begin\n"

expect "MFA auth"
send "$mfa\n"
send_user "MFA ok!\n"

expect "Opt>"
send "$node\r"
send_user "node ok!\n"

# sleep wait the shell takes over stdin and stdout.
sleep 1
send "clear\r"

interact

send_user "$prefix: exit\n"
