# Sync
CS371L Group 10 

Design Doc: https://docs.google.com/document/d/1aFa3daDXXzLbjbN3tAqocCzo-mkj6GLoHsziD2YwamM/edit?usp=sharing

Proposal: https://docs.google.com/document/d/1xe5V4_3M6H2E2pxzvnNyJ8YgsW0u0I7JSLWXS9EGkTk/edit?usp=sharing


Alpha and Beta Release
----------------
Contributions:

Maria Maynard (Release % Overall %):
- Signup screen with email sign up using firebase.
- Social media opt in screen with place holders for social media login.
- Password reset functionality for users already logged in.
- Password reset email for users not logged in.

Gabriela Pulido (Release % Overall %):
- Notification Hub table view with notification placeholders.
- Twitter Channel table view.
- Instagram Channel table view.
- LinkedIn Channel table view.
- Facebook Channel table view.
- Facebook login on social media opt in.
- Twitter login on social media opt in.
- Pulling twitter notifications for retweets.

Ji-Young Seo (Release % Overall %):
- Splash screen
- Log in screen that authenticates using firebase.
- Reasearch on pulling notifications.

Audrey Chung  (Release % Overall %):
- Settings Screen with dummy data
- Connections to the social media opt in page and the change password page.


Differences:
- no dark mode. Implementing a side bar menu ended up being pretty tricky, so a lot of settings features were simplified.
- It's difficult to see the social media opt in view & the icon spacing is off. This is exclusively because of wip difficulties with the settings side bar. If accessed directly, it performs & looks exactly as intended!
- In our proposal we stated that there would be only an "admin login" in our alpha release. This was before we knew how to authenticate users using firebase, so we went ahead and set up a normal login system with no admin account.
- Due to issues with the Facebook and Instagram APIs, we were unable to use the API in the way we had intended to. Facebook use to have functionality that would have worked for us to pull notifications, but they have since gotten rid of it, and the Instagram API also does not support pulling their notifications. In order to even get any information from the notifications, the user would have to click on the notification in their notification list, to open the app so that we could pull the information, then they would be able to use our app. Because of this we decided to pivot and try to get Twitter working since we knew that the Twitter API had support for what we were trying to achieve. In our final, we plan to have some functionality for Facebook and Instagram that would work using the work around mentioned above.

