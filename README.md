# Clean Architecure Sample
Sample application that demonstrates the Clean Architecture Structure in iOS using CocoaTouch frameworks combined in one workspace. It utilises RxSwift and Swinject.
The only screens that are presented at this point are Welcome Screen and a Login Screen.

## Paradigms and Patterns

App makes use of multiple design patterns including:

 - Dependency Inversion pattern in order to achieve low coupling between the components and to simplify testing.
 - Model-View-Presenter pattern to achieve separation between presentation logic and domain logic.


## Architectural Project Organisation

The project is organised in three conceptual layers: *Presentation*, *Domain* and *Data*.

### Presentation

The ***Presentation*** layer contains UI and Presentation logic, and it's organised following the Model-View-Presenter (MVP) pattern.

### Domain

The ***Domain*** layer contains two things: A app specific **Model** that represents the real life objects managed by the app. The classes and structs that made up the model are passed between layers during internal communication. They are completely decoupled from the iOS framework and have no responsibilities besides that of being a data representation.

The second thing you will find in the Domain layer are **Use Cases**. Use cases are simple classes which choreograph calls to the data layer from the presentation layer. Ideally each use case represents a single task.

The final thing you will find in the Domain layer are **Repositories**. These are interfaces implemented by the Data layer which represent the lower level calls that the use cases can access to send and receive data.

### Data

The ***Data*** layer contains all of the objects responsible for storing and retrieving data used by the app. This includes: service APIs, local storage and code to map data from external sources to the Domain models. All of the objects that provide data implement the relevant **Repository** interfaces provided by the Domain layer.


### Xcode Project Organisation

The project is built using a workspace and a number of sub projects as follows:

* __CleanArchitectureSample.xcworkspace__
	* __CleanArchitectureSample project__ - Thin wrapper around the projects that make up the project. Containing only minimal code including the AppDelegate for the app and any resources that cannot be stored in the presentation framework bundle.
	* __Presentation project__ - Contains all the UI and presentation code.

  * __Domain project__ - Contains the domain models and use case business logic used by the presentation layer. In turn, makes calls to the data layer to send and retrieve data.
  * __Data project__ - Contains the data layer which provides access to information locally and on remote servers.
  * __Support project__ - Classes and functions which are used by all the other projects. For example, dependency injection code.


### TODO:

* Unit tests using Quick and Nimble
* Localisation
