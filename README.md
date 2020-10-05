## Installation

1. clone this repo 
1. `cd Github-Repositories-App`
1. run `pod install`
1. `open Github\ Repositories.xcworkspace`
1. Build & Run

## Note
1. The api.github.com/repositories endpoint accepts the `since` paramater instead of `page`.
1. The `since` value is an id of last visible repo. id.
1. This endpoin particually don't accept the `per_page` paramater (like other endpoints) to limit the number of items per page.
1. So, the pagination is working but the limit value have no effect at all.

*I have contacted the GitHub Support team about this link https://support.github.com/ticket/personal/0/856579*

part of their response:
> The endpoint: https://api.github.com/repositories only supports the since parameter exclusively for pagination. The per_page parameter is not supported, so it will always return 100 items. You will need to use the Link header to get the URL for the next page of repositories.
