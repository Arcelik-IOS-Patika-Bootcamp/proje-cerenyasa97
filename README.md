# CHARGER APP
Patika.dev Arçelik Swift Bootcamp Final Project

## Table of Contents
* About the Project
* Gettings Started
* Architecture
* Screenshots
* License

## About the Project
Appointment application from charging stations
* The station can be searched by province
* Appointments can be made by viewing the available dates and times of the station
* The registered email and device UDID can be viewed from the profile
* The project was developed with MVVM design pattern and Clean Architecture.
* Data Binding is used for the communication of View and ViewModel.
* A network layer called Network Manager has been created for network operations.
* An AppRouter layer was created using the Navigation Controller for routing operations.

## Gettings Started
##### Requirements
* iOS 15.5
* Swift 5
* XCode 13.4.1

##### Installation
Clone the repo
```
https://github.com/Arcelik-IOS-Patika-Bootcamp/proje-cerenyasa97.git
```
## Architecture
Model-View-ViewModel (MVVM) is a structural design pattern that separates objects into three distinct groups:
* Model, hold application data. They’re usually structs or simple classes.
* View, display visual elements and controls on the screen. They’re typically subclasses of UIViewController.
* View model, transform model information into values that can be displayed on a view.

![image](https://user-images.githubusercontent.com/59059790/179394709-85fba57e-f332-437a-a46c-4c7a98c144d1.png)

## Screenshots
<img width="354" alt="Ekran Resmi 2022-07-17 13 50 21" src="https://user-images.githubusercontent.com/59059790/179394854-a35985d7-aae2-4bd8-a399-7a49c4e105fd.png">

## License
Charger App is under MIT license. See LICENSE for more info.
