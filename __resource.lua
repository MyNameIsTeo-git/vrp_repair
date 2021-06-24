resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

author "MyNameIsTeo__"
dependency "vrp"

client_script {
    "lib/Tunnel.lua",
    "lib/Proxy.lua",
	"config.lua",
	"client/functions.lua",
	"client/main.lua",
}

server_script {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server/functions.lua",
	"server/main.lua",
}