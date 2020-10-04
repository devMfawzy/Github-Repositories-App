## Installation

1. clone this repo 
1. `cd Github-Repositories-App`
1. run `pod install`
1. `open Github\ Repositories.xcworkspace`
1. Build & Run

## Note
The api.github.com/repositories endpoint accepts the `since` paramater instead of `page`.
The `since` value is an id of last visible repo. id
This endpoin particually don't accept the `per_page` paramater (like other endpoints) to limit the number of items per page.
So, the pagination is working but the limit value have no effect at all.
