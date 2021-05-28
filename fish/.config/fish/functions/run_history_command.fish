# Defined in /home/aaron/.config/fish/config.fish @ line 95
function run_history_command
	echo $history[$argv[1]] $argv[2..-1]
	eval $history[$argv[1]] $argv[2..-1]
end
