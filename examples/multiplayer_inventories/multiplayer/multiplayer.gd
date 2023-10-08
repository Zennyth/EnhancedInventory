extends Node

###
# ENET
###
const SERVER_IP: String = "localhost"
const SERVER_PORT: int = 7700
const MAX_PLAYERS: int = 2

var _peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()

func host() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	_peer.create_server(SERVER_PORT, MAX_PLAYERS)
	
func join() -> void:
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	_peer.create_client(SERVER_IP, SERVER_PORT)


func _on_connected_to_server() -> void:
	print("Connected to server")

func _on_peer_connected(peer_id: int) -> void:
	print("Peer <%s> connected" % str(peer_id))

func _on_peer_disconnected(peer_id: int) -> void:
	print("Peer <%s> disconnected" % str(peer_id))


###
# CORE
###
func _ready() -> void:
	await get_tree().create_timer(2).timeout
	
	host() if MultiplayerUtils.get_running_instance_number() == 0 else join()
	multiplayer.multiplayer_peer = _peer

	var inventory_manager: InventoryManager = NodeUtils.find_node(self, InventoryManager)
	inventory_manager.set_multiplayer_authority(multiplayer.is_server())
	inventory_manager.initialize()
