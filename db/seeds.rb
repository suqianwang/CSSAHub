Account.destroy_all

Account.create!({
  :username => "David Ratliff",
  :email => "ratlidav@tamu.edu",
  :name => "David Ratliff",
  :archived => false,
  :isAdmin => true
})

Account.create!({
  :username => "Bob123",
  :email => "bob@tamu.edu",
  :name => "Bob",
  :archived => false,
  :isAdmin => false
})