extends Button

const url = "http://127.0.0.1:3000/api"

@onready var username_line_edit = $"../username"
@onready var password_line_edit = $"../password"

var http_request: HTTPRequest

func _pressed():
	http_request = HTTPRequest.new()
	
	add_child(http_request)
	
	var username = username_line_edit.text
	var password = password_line_edit.text
	
	var headers = ["Content-Type: application/json"]
	
	http_request.request_completed.connect(_on_request_completed)
	
	var json = JSON.stringify({
		"username": username,
		"password": password
	})
	
	http_request.request(url + "/login", headers, HTTPClient.METHOD_POST, json)

func _on_request_completed(result, response_code, headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())

	if response and response.has("status"):
		if (response["status"] == "valid"):
			print("ok")
			get_tree().change_scene_to_file("res://scenes/world/World.tscn")
