user has many cars
user has many maintenance items (through car)

car belongs to user
car has many maintenance items through car-maintenance

maintenance has many cars through car-maintenance
maintenance belongs to user (through cars)

--------------------------------------------

Useful lessons:
1) Sinatra Complex forms associations
2) Active record associations in sinatra
3) Active record associations: Join tables
4)