Contributions:

Maria Maynard (Release 25% Overall 25%):
- Signup screen with email sign up using firebase.
- Social media opt in screen with place holders for social media login.
- Password reset functionality for users already logged in.
- Password reset email for users not logged in.

Gabriela Pulido (Release 25% Overall 25%):
- Notification Hub table view with notification placeholders.
- Twitter Channel table view.
- Instagram Channel table view.
- LinkedIn Channel table view.
- Facebook Channel table view.
- Facebook login on social media opt in.
- Twitter login on social media opt in.
- Pulling twitter notifications for retweets.

Ji-Young Seo (Release 25% Overall 25%):
- Splash screen with custom logo
- Log in screen that authenticates using firebase
- Instagram channel table view: attempted to connect to Instagram/Facebook APIs, as described in the Differences
- Local notification pull: attempted to have a workaround, as described below, of pulling messages directly from iPhone notification center]
- Twitter channel table view with filters by notification types

Audrey Chung  (Release 25% Overall 25%):
- Settings Screen with dummy data
        - updated since alpha from static cells & reflected "hardcoded" underlying code -> restructured w/ dynamic table w/ multiple custom cell type classes & more "generic", buildable code
- Connections to the social media opt in page and the change password page.
        - update since alpha includes working, sliding side menu for all w/ hamburger button, tap to close, updated UI (color, layout, headers).


Differences:
- Still no dark mode. Basic dark mode is easy to implement, but due to our custom coloring scheme, it doesn't come across quite right w/ the generic colors. We're shifting this to a reach goal for now...
- Due to issues with the Facebook and Instagram APIs, we were unable to use the API in the way we had intended to. Facebook use to have functionality that would have worked for us to pull notifications, but they have since gotten rid of it, and the Instagram API also does not support pulling their notifications. In order to even get any information from the notifications, the user would have to click on the notification in their notification list, to open the app so that we could pull the information, then they would be able to use our app. Because of this we decided to pivot and try to get Twitter working since we knew that the Twitter API had support for what we were trying to achieve. In our final, we plan to have some functionality for Facebook and Instagram that would work using the work around mentioned above.
- Similarly due to the blockers encountered w/ using different media APIs, beta does not include the ability to group notifications by type. We need the notifications reliably first!
