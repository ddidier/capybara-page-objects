# Capybara Page Objects #

[![Build Status](https://secure.travis-ci.org/ddidier/capybara-page-objects.png)](http://travis-ci.org/ddidier/capybara-page-objects)
[![Dependency Status](https://gemnasium.com/ddidier/capybara-page-objects.png)](https://gemnasium.com/ddidier/capybara-page-objects)
[![Code Climate](https://codeclimate.com/github/ddidier/capybara-page-objects.png)](https://codeclimate.com/github/ddidier/capybara-page-objects)

The [Page Objects](http://code.google.com/p/selenium/wiki/PageObjects) pattern applied to [Capybara](https://github.com/jnicklas/capybara):

> Within your web app's UI there are areas that your tests interact with. A Page Object simply models these as objects within the test code. This reduces the amount of duplicated code and means that if the UI changes, the fix need only be applied in one place.



## Documentation ##

Documentation can be found on [Github Pages - TODO]()



## Requirements ##

Tested with:
* Ruby 1.9.3
* Capybara 2.1



## Best Practices ##

* Avoid CSS or XPath selectors in your step definitions - do this within the page/component/element objects
* Avoid assertions in the page models themselves - do this in the step definitions



## Contributing ##

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version,  or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.



## Credits ##

This all started with a [NIH](http://en.wikipedia.org/wiki/Not_invented_here) fork from [andyw8/capybara-page-object](https://github.com/andyw8/capybara-page-object). Thanks to Andy Waite!



## Copyright ##

Copyright (c) 2013 David DIDIER.
See LICENSE.txt for further details.
