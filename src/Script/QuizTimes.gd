extends Control

signal nyawa_updated(nyawa)

var pertanyaan 
var text
var rand = RandomNumberGenerator.new()

onready var buttonsarray = [
	$VBoxContainer/MarginContainer/HBoxContainer/Btn1,
	$VBoxContainer/MarginContainer/HBoxContainer/Btn2,
	$VBoxContainer/MarginContainer/HBoxContainer/Btn3
]

var i = 0

var nilaiAwal
var nilaiAkhir

var quizclass = load("res://src/Script/Quiz.gd")
var qz = quizclass.new()

export (float) var max_nyawa = 3

onready var nyawa = max_nyawa

onready var waktu = 30

func _ready():
	pertanyaan()

func _set_pertanyaan(a,b):
	pertanyaan = get_node("VBoxContainer/Label")
	text = str(a, "  ×  " , b )
	pertanyaan.set_text(text)


func pertanyaan():
	update_waktu(waktu)
	$QuizTimer.start()
	if i <= 10:
		nilaiAwal = 0
		nilaiAkhir = 10
	elif i > 10:
		nilaiAwal = 10
		nilaiAkhir = 20
	elif i >= 15:
		nilaiAwal = 15
		nilaiAkhir = 25
	elif i >= 20:
		nilaiAwal = 20
		nilaiAkhir = 50
	elif i >= 25:
		nilaiAwal = 50
		nilaiAkhir = 100
	elif i >= 30:
		nilaiAwal = 100
		nilaiAkhir = 1000
	
	$Nyawa.set_text(str("HP : ",nyawa))
	
	rand.randomize()
	var a = rand.randi_range(nilaiAwal,nilaiAkhir)
	rand.randomize()
	var b = rand.randi_range(nilaiAwal,nilaiAkhir)
	
	_set_pertanyaan(a,b)
	
	for btn in buttonsarray:
		btn.set_text("")
		btn.disconnect("pressed",self,"_some_button_pressed")
		btn.disconnect("pressed",self,"_some_button_pressed2")
		btn.disconnect("pressed",self,"_some_button_pressed3")
	
	var benar = buttonsarray[randi() % buttonsarray.size()]
	var hasil = qz.kali(a,b)
	benar.set_text(str(hasil))
	benar.connect("pressed", self, "_some_button_pressed")
	
	var salah = []
	for j in buttonsarray:
		if benar != j:
			salah.append(j)
	
	
	salah[0].connect("pressed",self,"_some_button_pressed2")
	rand.randomize()
	var randomsalah0
	while true:
		randomsalah0 = rand.randi_range(nilaiAwal,(nilaiAkhir*nilaiAkhir))
		if randomsalah0 != hasil:
			break
	salah[0].set_text(str(randomsalah0))
	
	
	salah[1].connect("pressed",self,"_some_button_pressed3")
	rand.randomize()
	var randomsalah1
	while true:
		randomsalah1 = rand.randi_range(nilaiAwal,(nilaiAkhir*nilaiAkhir))
		if randomsalah1 != hasil and randomsalah1 != randomsalah0:
			break
	salah[1].set_text(str(randomsalah1))

func _some_button_pressed():
	AudioTrue.play()
	if i<10000:
		pertanyaan()
		print("%d" %i)
		i+=1
		waktu = 30
	else:
		get_tree().change_scene("res://src/Scene/GUI/TitleScreen.tscn")
	
func _some_button_pressed2():
	print("salah")
	popupshow()
	_set_nyawa(nyawa - 1)
	waktu = 30
	pertanyaan()

func _some_button_pressed3():
	print("salah")
	popupshow()
	_set_nyawa(nyawa - 1)
	waktu = 30
	pertanyaan()

func popupshow():
	WrongSound.play()
	$PopupSalah.show()
	yield(get_tree().create_timer(2.0), "timeout")
	$PopupSalah.hide()


func _set_nyawa(value):
	var prev_nyawa = nyawa
	nyawa = clamp(value, 0, max_nyawa)
	if nyawa != prev_nyawa:
		emit_signal("nyawa_updated", nyawa)
		if nyawa == 0:
			Global.Score = i
			get_tree().change_scene("res://src/Scene/PapanScore.tscn")

func update_waktu(waktu):
	$Waktu.set_text(str(waktu))

func _on_QuizTimer_timeout():
	if waktu <= 0:
		Global.Score = i
		get_tree().change_scene("res://src/Scene/PapanScore.tscn")
	else:
		waktu -= 1
		update_waktu(waktu)


func _on_BtnSetting_pressed():
	$Setting.show()
