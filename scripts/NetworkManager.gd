extends Node

const PORT = 6000

func start_network(is_server: bool):
  var peer = ENetMultiplayerPeer.new()
  if is_server:
    peer.create_server(PORT)
  else:
    peer.create_client("localhost", PORT)
  self.multiplayer.multiplayer_peer = peer
