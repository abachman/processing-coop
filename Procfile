web: bundle exec unicorn_rails -p $PORT
ws: bundle exec rerun --pattern '{socket.rb}' -- ruby socket.rb -p $PORT
# socket-test: bundle exec ruby -Itest/ -Ilib/ test/websocket/machine_controller_test.rb
# ws-test: bundle exec rerun --pattern '{socket.rb,lib/qsockets.rb,lib/qsockets/**/*.rb,test/websocket/**/*.rb}' -- ruby -Itest/ -Ilib/ test/websocket/account_test.rb
