# Flutter-WeatherApp

A simple Flutter application that includes user authentication and displays the current weather for the user's location using the OpenWeatherMap API.

## Features

- User Authentication
- Current Weather Information
- Location-based Weather Updates
- Clean and Responsive UI

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)

### Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/cmlooz/Flutter-WeatherApp.git
    cd Flutter-WeatherApp
    ```

2. Install dependencies:

    ```sh
    flutter pub get
    ```

3. Set up the OpenWeatherMap API key:

    - In the file named `assets/config.json`.
    - Add your API key to the file:

    ```json
    {
    "apiKey": "YOUR_API_KEY",
    "baseUrl": "https://api.openweathermap.org/data/2.5/weather"}
    ```

4. Run the app:

    ```sh
    flutter run
    ```

## Usage

1. Sign up or log in using your credentials.
2. Allow location permissions to get weather updates for your current location.
3. View the current weather information on the main screen.

## Built With

- [Flutter](https://flutter.dev/) - The framework used
- [OpenWeatherMap API](https://openweathermap.org/api) - For weather data

## Authors

- **Juan Camilo Ortiz** - [cmlooz](https://github.com/cmlooz)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

- [OpenWeatherMap](https://openweathermap.org/) for their great API
- Flutter documentation and community for the resources and support
