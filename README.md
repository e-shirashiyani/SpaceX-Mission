# SpaceX Missions Showcase App

![App Icon](https://github.com/YourUsername/YourRepoName/raw/main/1024.png)

## Overview

The SpaceX Missions Showcase app is a mobile application that allows users to view and explore completed missions of SpaceX rockets. The app provides a user-friendly interface to display a list of missions, along with their brief information, and allows users to view more details about each mission, including a picture, description, mission name, and completion date. Additionally, users can bookmark their favorite missions for future reference.

## Features

- Displaying the List of Missions: The app displays a list of missions, sorted by the last completed mission. The list supports pagination, showing 20 missions per page.

- Mission Details: Users can select a mission from the list to view more details about it, including a picture, description, mission name, and completion date.

- Wikipedia Link: If available, the app displays a button to open the Wikipedia link associated with the selected mission, allowing users to learn more about it.

- Bookmarking: Users can bookmark missions of interest, and the bookmarked missions will be displayed in a separate list for easy access.


## Getting Started

### Prerequisites

- Xcode 12 or higher
- Swift 5.0 or higher

## Architecture

The app is designed using the Clean Architecture pattern, also known as the Uncle Bob Architecture. It follows the separation of concerns principle, separating the app into three main layers:

- Presentation Layer (UIKit): Contains the view controllers responsible for displaying the app's user interface.

- Domain Layer: Contains the business logic of the app, including the use cases and entities.

- Data Layer: Handles data retrieval and storage, interacting with external APIs and the local database.

The communication between layers is facilitated through protocols, ensuring low coupling and high flexibility in the app's architecture.


## Unit Tests

Unit tests are written using the XCTest framework to test the core functionalities of the view controllers. Mock objects are used to isolate the view controllers from the actual data and domain layers, ensuring controlled responses during testing.


## Acknowledgments

- Special thanks to SpaceX for providing the API to access mission data.



