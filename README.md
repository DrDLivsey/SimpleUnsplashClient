**SimpleUnsplashClient - is an iOS app-client for Unsplash webservice.**_

**Features**:

1. Calling the Unsplash API "GET /photos: in order to recieve photos from the Editorial feed.
2. Presenting an answer on the main View as a CollecionView with such metadata as:
   1. Image
   2. Image description - max 2 strings (colored with parameter from API server answer)
   3. Number of likes on the Unsplash.
   4. Tapping on the cell opens the next screen with a larger image and a username/owner of the image in the navigation bar.
3. The main CollectionViews uses reusable cell made with a xib-file.

**Prerequisites**:
Installed Xcode on the mac.

**How to build**:
For using Unsplash API you need to be registered as a developer. Link - https://unsplash.com/developers
Before using the Unsplash API, read the API Guidelines.
What to do:
1. Create a new application here - https://unsplash.com/oauth/applications
2. Copy Access Key from the "Keys" section ![keys](https://github.com/DrDLivsey/SimpleUnsplashClient/assets/120713641/b37201de-1d27-463f-aa54-3a799467930e)
3. Open the app's Xcode project and paste it in urlWithPage constant (Presenter/ImagePresenter.swift) between "client_id=" and "&page=". As at the screenshot below.
![insertaccesskey](https://github.com/DrDLivsey/SimpleUnsplashClient/assets/120713641/552d5501-200c-4141-be62-4a268a62a93d)
