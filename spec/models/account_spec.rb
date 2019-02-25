RSpec.describe Account, :type => :model do
	 describe "create_an_account1 form" do
		it "is invalid without an email" do
			user=Account.new(email: nil, name: 'bob', username: 'bob', password: 'bob')
			user.valid?
			expect(user.errors[:email].size).to eq(1)
		end
	end

	describe "create_an_account2 form" do
		it "is invalid without a username" do
		  user=Account.new(username: nil, name: 'bob', email: 'bob@tamu.edu', password: 'bob')
		  user.valid?
		  expect(user.errors[:username].size).to eq(1)
		end
	end

	describe "#create_an_account3 form" do
		it "is invalid without a password" do
		  user=Account.new(password: nil, name: 'bob', username: 'bob', email: 'bob@tamu.edu')
		  user.valid?
		  expect(user.errors[:password].size).to eq(2)
		end
	end

	describe "create_an_account4 form" do
		it "duplicate usernames are invalid" do
		  Account.create(username: 'bob', name: 'bob', password: 'bob', email: 'bob@tamu.edu')
		  user = Account.new(username: 'bob', name: 'bob', password: 'bob', email: 'bob@tamu.edu')
		  user.valid?
		  expect(user.errors[:username].size).to eq(1)
		end
	end
	
	describe "create_an_account5 form" do
		it "duplicate usernames are invalid" do
		  Account.create(username: 'bob', name: 'bob', password: 'bob', email: 'bob@tamu.edu')
		  user = Account.new(username: 'bob', name: 'bob', password: 'bob', email: 'bob@tamu.edu')
		  user.valid?
		  expect(user.errors[:email].size).to eq(1)
		end
	end

	describe "create_an_account_6 form" do
		it "is valid without a name" do
			user = Account.new(name: nil, username: 'bob', email: 'bob@tamu.edu', password: 'bob')
			user.valid?
			expect(user.errors[:name].size).to eq(0)
		end
	end
      
end