# krishi-startup-flutter-app-one-stop-service-for-farmers-
# Krishi - Agricultural Services Platform

Krishi is a comprehensive Flutter-based mobile application designed to empower farmers through technology and seamless service delivery. The platform integrates advanced agricultural technologies with user-friendly interfaces to address various challenges faced by farmers.

## Features

### Crop Recommendation System
- **Basic Version**: Provides recommendations based on location and weather/climate conditions using GPS
- **Advanced Version**: Incorporates Soil Health Card (SHC) data for more accurate recommendations

### Crop Disease Detection System
- Classifies between crop and non-crop images
- Identifies specific crops from images
- Detects diseases affecting crops and provides treatment recommendations

### On-Demand Machinery Accessibility
- Rental and hiring services for agricultural machinery
- Real-time availability checking
- Subscription plans for frequent access at discounted rates

### Maintenance and Support
- Connect farmers with service centers and repair shops
- Annual Maintenance Plans (AMC)
- Emergency repair support
- Spare parts marketplace

### Logistics Management
- Machinery transportation services
- Produce transport to markets
- Storage solutions with warehouse partnerships
- Route optimization using AI

### Custom Hiring of Labor
- Labor marketplace connecting farmers with skilled workers
- Worker profiles with ratings and reviews
- Group hiring options for large-scale tasks

## Tech Stack

### Flutter Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  form_field_validator: ^1.1.0
  flutter_svg: ^2.0.10+1
  image_picker: ^1.1.2
  permission_handler: ^11.3.1
  flutter_rating_bar: ^4.0.1
  carousel_slider: ^5.0.0
  cached_network_image: ^3.2.3
  animations: ^2.0.11
  get: ^4.6.6
  smooth_page_indicator: ^1.2.0+3
  get_storage: ^2.1.1
  provider: ^6.1.2
  font_awesome_flutter: ^10.8.0
  flutter_cart: ^0.0.9
  google_fonts: ^6.2.1
  gap: ^3.0.1
  shimmer: ^3.0.0
  razorpay_flutter: ^1.3.7
  flutter_login: ^5.0.0
  flutter_stripe: ^11.3.0
  dropdown_button2: ^2.3.9
  webview_flutter: ^4.10.0
  lottie: ^3.2.0
  onesignal_flutter: ^5.1.0
  infinite_scroll_pagination: ^4.1.0
  geolocator: ^13.0.2
```

## Implementation Highlights

- **State Management**: Using GetX and Provider for efficient state management
- **Location Services**: Geolocator for precise location detection to power recommendation systems
- **Payment Integration**: Razorpay and Stripe for seamless payment processing
- **Local Storage**: GetStorage for caching and offline capabilities
- **Responsive UI**: Animations and custom widgets for a fluid user experience
- **Notifications**: OneSignal for real-time alerts and updates
- **Image Processing**: For crop disease detection system

## Installation

```bash
# Clone this repository
git clone https://github.com/krishnakant2004/krishi.git

# Navigate to the project directory
cd krishi

# Install dependencies
flutter pub get

# Run the app
flutter run
