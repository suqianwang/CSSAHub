Account.destroy_all
Ride.destroy_all

Account.create!({
  :username => "ratlidav",
  :email => "ratlidav@tamu.edu",
  :name => "David Ratliff",
  :archived => false,
  :isAdmin => false
})

Account.create!({
  :username => "bob",
  :email => "bob@tamu.edu",
  :name => "Bob",
  :archived => false,
  :isAdmin => false
})

Account.create!({
  :username => "megan.grahman",
  :email => "megan.grahman@tamu.edu",
  :name => "Megan",
  :archived => false,
  :isAdmin => true
})
