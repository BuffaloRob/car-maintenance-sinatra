require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
use CarsController
use UsersController
use MaintenanceItemsController
use CarMaintenanceItemsController
run ApplicationController