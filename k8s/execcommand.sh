#!/usr/bin/expect -f

# enable stdout before interact.
log_user 1

set timeout 30
set app [lindex $argv 0]
set host [lindex $argv 1]
set command [lindex $argv 2]
set dirname [file dirname $argv0]
set prefix "k8s exec command"

send_user "$prefix: begin\n"
send_user "app->$app\n"
send_user "host->$host\n"
send_user "command->$command\n"
send_user "location->$dirname\n"

spawn $dirname/execbash.sh $app

if {"$host" != "" } {
	expect "/opt/web#"
	send "export HTTP_HOST=$host\n"
}

expect "/opt/web#"
send "$command\n"
if {"$command" == "./XXXX manage shell" } {
	expect "Loading..."
	send "XXXX\n"
}

interact

send_user "$prefix: exit\n"
