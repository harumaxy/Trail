extends Node

const PORT = 4242

#const PlayerNode := preload("res://scenes/player_node.tscn")
const Cursor := preload("res://scenes/cursor.tscn")


@export var players: Node = null
@export var canvas : Node = null
@onready var multiplayer_spawner = $MultiplayerSpawner as MultiplayerSpawner


func start_network(is_server: bool):
  var peer = ENetMultiplayerPeer.new()

  if is_server:
    self.multiplayer.peer_connected.connect(self.create_player)
    self.multiplayer.peer_disconnected.connect(self.destroy_player)
    peer.create_server(PORT)
    self.create_player(self.multiplayer.get_unique_id())
    print("server listening on localhost %d" % PORT)
  else:
    var target_ip = "localhost"
    peer.create_client(target_ip, PORT)
  
  self.get_tree().root.multiplayer.multiplayer_peer = peer

func create_player(id):
  var p = Cursor.instantiate()
  p.name = str(id)
  print(p.name)
  players.add_child(p)

func destroy_player(id):
  players.get_node(str(id)).queue_free()

func _ready():
  multiplayer_spawner.spawned.connect(func (x): print(x))
  print(multiplayer_spawner._spawnable_scenes)
  print(OS.get_cmdline_args())
  if "--server" in OS.get_cmdline_args():
    start_network(true)
  else:
    start_network(false)
    

