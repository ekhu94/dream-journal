Entry.delete.all
Dream.delete.all
User.delete.all
<<<<<<< HEAD

user1 = User.create(name: "syd")
user2 = User.create(name: "erik")
=======
#should new instances be .create or .new?
user1 = User.create(name: "syd")
user2 = User.create(name: "erik")

dream1 = Dream.create(date: DateTime.now, hours_slept: 8, user_id: 1)
dream2 = Dream.create(date: DateTime.now, hours_slept: 3, user_id: 2)
dream3 = Dream.create(date: DateTime.now, hours_slept: 1, user_id: 1)
dream4 = Dream.create(date: DateTime.now, hours_slept: 14, user_id: 2)
>>>>>>> bce182a57a512d1465e35b1b574b9544bbb27a75

dream1 = Dream.create(hours_slept: 8, user_id: 1)
dream2 = Dream.create(hours_slept: 3, user_id: 2)
dream3 = Dream.create(hours_slept: 1, user_id: 1)
dream4 = Dream.create(hours_slept: 14, user_id: 2)

<<<<<<< HEAD

entry1 = Entry.create(date: DateTime.now, category: "nightmare", remembrance: 80, description: "I was falling into the 5th dimension and eating chocolate bars with Gucci Mane.", recurring: true, dream_id: 1)
entry2 = Entry.create(date: DateTime.now, category: "normal", remembrance: 32, description: "My boyfriend and I went shopping at the mall.", recurring: false, dream_id: 2)
entry3 = Entry.create(date: DateTime.now, category: "nightmare", remembrance: 10, description: "It started off where I was coding but everytime I ran learn test, more and more errors would populate.", recurring: true, dream_id: 1)
entry4 = Entry.create(date: DateTime.now, category: "false awakening", remembrance: 76, description: "I kept thinking I was walking into my house but it wasn't real.", recurring: false, dream_id: 2)
entry5 = Entry.create(date: DateTime.now, category: "lucid", remembrance: 55, description: "I kcreate I was dreaming so I decided to walk into the fire. It was so much fun.", recurring: false, dream_id: 2)
entry6 = Entry.create(date: DateTime.now, category: "normal", remembrance: 68, description: "I was skipping through the Willy Wonka's Chocolate Factory.", recurring: true, dream_id: 2)
=======
entry1 = Entry.create(category: "nightmare", remembrance: 80, description: "I was falling into the 5th dimension and eating chocolate bars with Gucci Mane.", recurring: true, dream_id: 1)
entry2 = Entry.create(category: "normal", remembrance: 32, description: "My boyfriend and I went shopping at the mall.", recurring: false, dream_id: 2)
entry3 = Entry.create(category: "nightmare", remembrance: 10, description: "It started off where I was coding but everytime I ran learn test, more and more errors would populate.", recurring: true, dream_id: 1)
entry4 = Entry.create(category: "false awakening", remembrance: 76, description: "I kept thinking I was walking into my house but it wasn't real.", recurring: false, dream_id: 2)
entry5 = Entry.create(category: "lucid", remembrance: 55, description: "I knew I was dreaming so I decided to walk into the fire. It was so much fun.", recurring: false, dream_id: 2)
entry6 = Entry.create(category: "normal", remembrance: 68, description: "I was skipping through the Willy Wonka's Chocolate Factory.", recurring: true, dream_id: 2)
>>>>>>> bce182a57a512d1465e35b1b574b9544bbb27a75

