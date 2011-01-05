# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/enviroments',  __FILE__)
run Depot::Application
