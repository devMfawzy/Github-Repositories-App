## Installation

1. clone this repo 
1. `cd Github-Repositories-App`
1. run `pod install`
1. `open Github\ Repositories.xcworkspace`
1. Build & Run

## Note
1. The api.github.com/repositories endpoint accepts the `since` paramater instead of `page`.
1. The `since` value is an id of last visible repo. id
1. This endpoin particually don't accept the `per_page` paramater (like other endpoints) to limit the number of items per page.
1. So, the pagination is working but the limit value have no effect at all.

#### Plase refer to these links
https://developer.github.com/v3/repos/#list-public-repositories
https://stackoverflow.com/questions/56925185/get-all-public-github-repositories-with-pagination
