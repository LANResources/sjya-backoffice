# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Organization.create name: 'LAN Resources'
Organization.create name: 'St. Joseph Youth Alliance'
User.create first_name: 'Nick',
            last_name: 'Reed',
            email: 'nreed@biozymeinc.com',
            role: 'administrator',
            password: 'changeM3!',
            password_confirmation: 'changeM3!'
