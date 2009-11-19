user = User.new(:username => 'admin', :email => 'admin@admin.com', :password => 'password', :password_confirmation => 'password', :admin => true)
user.build_managed_account(:name => 'Account Name')
user.save(false)
user.account = user.managed_account
user.save!

Page.create(:name => 'Index', :permalink => 'index', :content => 'This is the index', :account => user.account)