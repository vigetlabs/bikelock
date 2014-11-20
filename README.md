## BikeLock

Web app for:
- manual override of the SparkCore powered Bike Lock
- handling texts to control the Bike Lock


To run locally:
```ruby
bundle install
rake db:setup
cd config && for i in *.example; do cp $i `echo $i | sed s/.example//g`; done

rails s
```
