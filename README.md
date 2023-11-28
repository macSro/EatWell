<a name="top"></a>

# EatWell Reviewer

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#downgrading">Downgrading</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#run">Run</a></li>
      </ul>
    </li>
    <li><a href="#features">Features</a></li>
    <li><a href="#demo">Demo</a></li>
  </ol>
</details>

## About The Project

This project contains the app developed as part of my thesis as well as the paper itself. It was created within my Bachelor degree studies at _Wrocław University of Science and Technology_. The complete paper can be found in ```thesis.pdf``` (written in Polish).

_For examples of the app usage, please refer to the <a href="#demo">Demo</a> section._

#### Thesis title

_Mobile app for cooking enthusiasts featuring searching for recipes considering owned products_

#### Abstract

_Cooking is considered to be one of the most popular hobbys among different age groups. Along with the dynamic development of the Internet and, in a broad sense, information technology, more and more aspects of everyday life are assisted by various technological solutions. It is no different in the culinary world._ 

_The purpose of this Engeneering Thesis was to design and implement a mobile app for cooking enthusiasts. It should improve the process of recipe search thanks to the existance of numerous filtering and sorting options, for example based on user’s owned products. User must obtain a possibility to publish new recipes, rate existing ones and report products missing in a database. The decision was made to implement additional reviewer’s app in order to process the missing inquiries._

_The effect of creating the solution explained above would not only be sharing inspiration with novice cooks, but also offering users help with cooking everyday as well as in a crisis situation, such as being quarantined due to the COVID-19 pandemic._

### Built With

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase)
![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)

State management: <a href="https://pub.dev/packages/flutter_bloc">BloC</a>

<p align="right">(<a href="#top">back to top</a>)</p>



## Getting Started

To get a copy of this project running on your machine follow these steps.

### Prerequisites

* Flutter SDK installed _(version < 2.0.0)_

* Dart SDK installed _(version < 2.12.0)_

* IDE configured for development of Flutter applications _(e.g., VS Code)_

### Downgrading

If you have a more recent version of Flutter SDK installed, please downgrade it before the app installation:

1. Navigate to your Flutter SDK directory

2. Switch to a previous version _(e.g., 1.22.6)_:

```
git checkout 1.22.6
```

3. Update Dart SDK automatically:

```
flutter doctor -v
```

<br>

In order to switch back to the most recent version, run the following commands:

```
flutter channel stable

flutter upgrade
```

### Installation

1. Clone this repository:

   ```
   git clone https://github.com/macSro/EatWell.git
   ```

2. Navigate to the cloned directory:

   ```
   cd EatWell
   ```

3. Install the dependencies:

   ```
   flutter pub get
   ```

### Run

1. Inside your IDE select the target device

2. Run the app with IDE "Run" button _(VS Code: F5)_ or by executing:

```
flutter run
```

<p align="right">(<a href="#top">back to top</a>)</p>



## Features 

* Register account

* Login using email/password or Google account

* Browse and filter recipes

* Rate a recipe

* Add a recipe to favorites

* Publish a recipe

* Report a product missing in the database

* Manage pantry (products on hand)

* Ban a product from diet



## Demo

https://github.com/macSro/EatWell/assets/56345054/0020942a-6a92-42f3-9ab0-04bd66642903

https://github.com/macSro/EatWell/assets/56345054/affeb64b-f374-4cd1-93ca-271633240081

https://github.com/macSro/EatWell/assets/56345054/0cad2b20-e27d-4912-b6dc-1590130ad4e6

https://github.com/macSro/EatWell/assets/56345054/71a98e62-a322-45e5-b779-741efe382910

https://github.com/macSro/EatWell/assets/56345054/711a5f1b-78a3-4f7b-b917-49af79e2e22d

<p align="right">(<a href="#top">back to top</a>)</p>
