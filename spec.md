# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
  - 
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
  - Using Users, Maintenance_items, & Cars models
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
  - all models have a 'has_many' relationship except the join table
- [x] Include user accounts
  - users are able to log in and out of their sessions
- [ ] Ensure that users can't modify content created by other users
  
- [ ] Include user input validations
- [ ] Display validation failures to user with error message (example form URL e.g. /posts/new)
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [ ] You have a large number of small Git commits
- [ ] Your commit messages are meaningful
- [ ] You made the changes in a commit that relate to the commit message
- [ ] You don't include changes in a commit that aren't related to the commit message



Maintenance Item 
name: Oil Change

Car A
oil change for this car
cost: $40
mileage_due: 30000
mileage_performed: 25000

Car B
oil change for this car
cost: $50
mileage_due: 20000
mileage_performed: 15000

in your car maintenance items controller
you will protect your routes by checking to see if current_user.id == car_maintenance_item.car.user.id

to schedule a maitenance, it will be a new form for car_maintenance_item, where you will select the car and the maintenance item
inputs for this form
car - dropdown
maintenance item - dropdown
mielage_due - input
mileageperformed - input
cost - input