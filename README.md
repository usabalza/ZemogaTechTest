# ZemogaTechTest
This is a Swift app for testing. It includes the features of API calls, caching with CoreData, adding favorites and deleting posts individually or all at once.

# Usage
The PostList screen has a list of all posts, tapping on one of them will send the user to the detail. In the top right corner, on navigation bar, there is a refresh button for reload data from API. Downwards, the "Delete All" button will wipe out the data from the phone; in order to retrieve it again the user must close and open again the app, or tapping the Refresh button.

The PostDetail screen includes the individual body for a post, the user data and the related comments. The user can add or remove posts from favorites; or delete individual posts.

All the posts are saved in the phone after retrieving them with Alamofire, and CoreData is used for the initial creation of local entries, fetching them on tableView, updating and deleting.

# Alamofire
This third-party component is the quintessencial API requests library, it offers many benefits including multipart support for uploading images and other media.

# Design Pattern used
VIPER was used in the development of this app, because its modular and easy to specialize each component.
VIEW: The view has the .xib archive for mockup and the .swift file for connecting outlets and actions
PRESENTER: The presenter has the business logic and links every component, providing navigation with router, connecting with interactor to sending requests, and retrieving the response to the view again, so the user can see it on screen.
INTERACTOR: The interactor is responsible to send the API calls and handling responses to send them to the presenter.
ROUTER: The router does the navigation between modules.
ENTITIES: They are structs to represent data.
CONTRACT: It contains a protocol with all the variables and functions to be used.
BUILDER: It receives the data from previous modules and send it to presenter.
