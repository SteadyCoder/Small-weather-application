# Small-weather-application
Small weather application for using it as example of code practice.

### Description

#### *Project logic*
Project has one main **SWWeatherViewController** that is responsible for main logic if application. It has a property of class **SWWeatherViewModel** that is responsible for business logic of application. By default view model use hard coded name of the cities for showing them on table view. But you can pass array of String to load your own cities.
By default it looks like this:
`let viewModel = SWWeatherViewModel()`
But you can do like that and load other cities:
`let viewModel = SWWeatherViewModel(withCitiesNames: ["Lviv", "Moscow", "Paris"])`

#### *Network layer*
Also you can find two classes **SWRequestManager** and **SWMockApiManager** used for network and testing of network. Both of the conforms to prorocol **SWRestAPI**. So that both of them can be easily replaced and you can use app even in offline mode for testing.

#### *Model layer*
For business logic we are having Core Data. That help us to store data and show it even in online. It also let us to us NSFetchedResultController for table view to easily update data.