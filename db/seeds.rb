# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# user
# id | email | encrypted_password | reset_password_token | reset_password_sent_at | remember_created_at | sign_in_count | 
# | current_sign_in_at | last_sign_in_at | current_sign_in_ip | last_sign_in_ip | created_at | updated_at | username 

# room
# id | name | description | private | message_scrub | voting | mms | last_post | created_at | updated_at 

# msg
# id | self_destruct | self_destruct_time | self_destruct_type | type | room_id | user_id | created_at | updated_at 

require 'faker'

Message.delete_all
Room.delete_all
User.delete_all

ogCooler = Room.create(
	name: "ogCooler",
	description: "this is the original watrcoolr",
	private: true,
	message_scrub: true,
	voting: "uni",
	mms: true	
)

gForce = User.create(
	email: "agaynor72@gmail.com",
	password: "password",
	username: "gForce",
	firstname: "Alex",
	lastname: "Gaynor"
)
mittRomney = User.create(
	email: "mitulp91@gmail.com",
	password: "password",
	username: "mittRomney",
	firstname: "Mitul",
	lastname: "Patel"
)
noob = User.create(
	email: "chandlermoisen@gmail.com",
	password: "password",
	username: "noobAlert",
	firstname: "Chandler",
	lastname: "Moisen"
)

turd = User.create(
	email: "turd@ferguson.com",
	password: "password",
	username: "turdFerguson",
	firstname: "Turd",
	lastname: "Ferguson"
)

gForce.rooms << ogCooler
mittRomney.rooms << ogCooler
noob.rooms << ogCooler


first_msg = Message.create(
	self_destruct: true,
	self_destruct_time: 0,
	self_destruct_type: "all_viewed",
	msg_type: "Text",
	room_id: ogCooler.id,
	user_id: gForce.id,
	msg_content: "What up world this is the first message in our seeds file."
)

second_msg = Message.create(
	self_destruct: true,
	self_destruct_time: 60,
	self_destruct_type: "timed",
	msg_type: "Text",
	room_id: ogCooler.id,
	user_id: noob.id,
	msg_content: "Yo @gForce you're a fucking troll you nerd... aLLLLERRRRTTTTT"
)

third_msg = Message.create(
	self_destruct: false,
	self_destruct_time: 0,
	self_destruct_type: "never",
	msg_type: "Text",
	room_id: ogCooler.id,
	user_id: mittRomney.id,
	msg_content: "Sup fools this your shouldve been president Mitt Romney"
)


tribunal = Tribunal.create(
	room_id: ogCooler.id,
	user_id: turd.id,
	votes_for: 0,
	votes_against: 0,
	total_votes: 3,
	active: true
)

ogCooler.tribunals << tribunal
turd.tribunals << tribunal




